#!/usr/bin/env bash
# Structural checks from Anthropic's skill-authoring guidance (reviewed 2026-10-02).
# Each rule exists because of how Claude reads a skill, not for tidiness:
#
#   1. CONTENTS  — a reference file over 100 lines needs a contents list near the
#      top. Claude often previews only the first 100 lines of a file; a list there
#      lets it jump to the section it needs instead of guessing from the opening.
#   2. ORPHAN    — every file in a skill's references/ must be named in that
#      skill's SKILL.md. A file reachable only through another reference is two
#      levels deep, and nested files are the ones Claude reads partially.
#      A subfolder file may instead be covered by a pattern line in SKILL.md,
#      such as `references/commands/[command].md`, as long as its stem also
#      appears in SKILL.md in backticks (`analyze`). The pattern tells Claude how
#      to build the path; the stem proves SKILL.md routes to that file.
#   3. REQUIRES  — a skill that ships scripts/ must state what they need, on a
#      line starting "Requires:", next to where SKILL.md runs them. Environments
#      differ; an unstated dependency fails silently in the one that lacks it.
#
# CONTENTS and ORPHAN walk references/ recursively, dotfiles aside.
# _retired/ stays excluded as an unmodified archive.
#
# Usage:
#   scripts/check-skill-structure.sh     # report, exit 1 on any finding
set -uo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skills="$(cd "$script_dir/.." && pwd)/.claude/skills"

findings=0
flag() { printf '%-10s %s\n' "$1" "$2"; findings=$((findings + 1)); }
re_escape() { printf '%s' "$1" | sed 's/[][\.^$*+?(){}|]/\\&/g'; }
bt='`'

for dir in "$skills"/*/; do
  dir="${dir%/}"
  name="$(basename "$dir")"
  [[ "$name" == _retired ]] && continue
  skill_md="$dir/SKILL.md"
  [[ -f "$skill_md" ]] || continue

  if [[ -d "$dir/references" ]]; then
    while IFS= read -r ref; do
      ref_path="${ref#"$dir"/}"            # references/commands/analyze.md
      rel="$name/$ref_path"

      if ! grep -qF "$ref_path" "$skill_md"; then
        sub="$(dirname "$ref_path")"       # references/commands
        if [[ "$sub" == references ]]; then
          flag ORPHAN "$rel — not named in $name/SKILL.md"
        else
          base="$(basename "$ref_path")"
          stem="${base%.*}"
          ext=""; [[ "$base" == *.* ]] && ext=".${base##*.}"
          # Pattern: the subfolder, a [placeholder], the same extension.
          # Guard: the stem in backticks, e.g. `analyze` or `apply [company]`.
          sub_re="$(re_escape "$sub")"
          ext_re="$(re_escape "$ext")"
          stem_re="$(re_escape "$stem")"
          if ! grep -qE "${sub_re}/\[[A-Za-z0-9_-]+\]${ext_re}" "$skill_md"; then
            flag ORPHAN "$rel — not named in $name/SKILL.md, and no $sub/[name]$ext pattern line"
          elif ! grep -qE "${bt}${stem_re}[${bt} ]" "$skill_md"; then
            flag ORPHAN "$rel — $sub/[name]$ext pattern found, but ${bt}${stem}${bt} is not named in $name/SKILL.md"
          fi
        fi
      fi

      if [[ "$ref" == *.md ]] && (( $(wc -l < "$ref") > 100 )); then
        head -40 "$ref" \
          | grep -qiE '^#+ +(contents|table of contents)\b|^\*\*contents\*\*' \
          || flag CONTENTS "$rel — $(wc -l < "$ref") lines, no contents list in the first 40"
      fi
    done < <(find "$dir/references" -type f ! -name '.*' | sort)
  fi

  if [[ -d "$dir/scripts" ]]; then
    grep -qE '^\s*(\*\*)?Requires:' "$skill_md" \
      || flag REQUIRES "$name/SKILL.md — ships scripts/ but has no 'Requires:' line"
  fi
done

echo
if (( findings > 0 )); then
  echo "$findings structural finding(s)."
  exit 1
fi
echo "Skill structure clean: contents lists, named or patterned references, stated dependencies."
