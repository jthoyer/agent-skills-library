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
#   3. REQUIRES  — a skill that ships scripts/ must state what they need, on a
#      line starting "Requires:", next to where SKILL.md runs them. Environments
#      differ; an unstated dependency fails silently in the one that lacks it.
#
# _retired/ stays excluded as an unmodified archive.
#
# Usage:
#   scripts/check-skill-structure.sh     # report, exit 1 on any finding
set -uo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skills="$(cd "$script_dir/.." && pwd)/.claude/skills"

findings=0
flag() { printf '%-10s %s\n' "$1" "$2"; findings=$((findings + 1)); }

for dir in "$skills"/*/; do
  dir="${dir%/}"
  name="$(basename "$dir")"
  [[ "$name" == _retired ]] && continue
  skill_md="$dir/SKILL.md"
  [[ -f "$skill_md" ]] || continue

  if [[ -d "$dir/references" ]]; then
    for ref in "$dir"/references/*; do
      [[ -f "$ref" ]] || continue
      base="$(basename "$ref")"
      rel="$name/references/$base"

      grep -q "references/$base" "$skill_md" \
        || flag ORPHAN "$rel — not named in $name/SKILL.md"

      if [[ "$ref" == *.md ]] && (( $(wc -l < "$ref") > 100 )); then
        head -40 "$ref" \
          | grep -qiE '^#+ +(contents|table of contents)\b|^\*\*contents\*\*' \
          || flag CONTENTS "$rel — $(wc -l < "$ref") lines, no contents list in the first 40"
      fi
    done
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
echo "Skill structure clean: contents lists, one-level references, stated dependencies."
