#!/usr/bin/env bash
# Resolves every path and filename this library's agents assert, against disk.
#
# Four times in one week a dead pointer shipped and was found by accident:
#   ~/.claude/agents/CHANGELOG.md   (watchdog step 5, a path that never existed)
#   ~/.claude/references/*          (13 occurrences across 12 files, dead in cloud)
#   the styleguide discovery list    (cody.md:45 and ux-designer.md, same miss twice)
# Each was invisible to prose review, which reads for sense and skims paths.
# This script reads only the paths.
#
# Scope is .claude/agents/, .claude/references/ and .claude/skills/.
#
# Skills were excluded wholesale until 2026-09-19, on the grounds that they are
# account-synced and legitimately live at ~/.claude/skills/, so the home-path
# rule below inverts there. That reasoning covers home-form paths and nothing
# else: a dead *repo-relative* pointer inside a skill is the same defect as one
# inside an agent, and it is the more common one — 13 broken `references/*.md`
# pointers across 5 skills shipped in the 2026-08-17 seed commit under an
# "all 46 clean" audit note. So the exemption is now the narrow thing it was
# always meant to be: inside a skill, ~/.claude/skills/... is fine and every
# other assertion is checked.
#
# Sub-file resolution is also tighter inside a skill. `references/actors.md`
# named in skill A must exist in skill A; resolving it against any skill in the
# tree is exactly how a broken pointer reads as clean.
#
# _retired/ stays excluded as an unmodified archive.
#
# Usage:
#   scripts/check-references.sh            # report, exit 1 on any finding
#   scripts/check-references.sh --list     # print every token and its verdict
set -uo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lib_root="$(cd "$script_dir/.." && pwd)"
allowlist="$script_dir/reference-allowlist.txt"

list_all=0
[[ "${1:-}" == "--list" ]] && list_all=1

# Files in scope: what an agent or skill asserts to a live runtime. Ledgers are
# deliberately out — at the repo root and inside .claude/skills/ alike. A
# CHANGELOG records paths as they *were*, including every one since fixed and
# every sub-file of a retired skill, so checking one reports history as
# breakage. 25 of the 54 findings on this check's first skills-inclusive run
# came from .claude/skills/CHANGELOG.md, every one of them a correct record of
# something that no longer exists.
mapfile -t in_scope < <(
  find "$lib_root/.claude/agents" "$lib_root/.claude/references" -name '*.md' 2>/dev/null
  find "$lib_root/.claude/skills" -name '*.md' -not -path '*/_retired/*' \
       -not -name 'CHANGELOG.md' 2>/dev/null
)

# Allowlisted tokens: a path this library does NOT own. One per line,
# "token<TAB>reason". A token here is never reported.
declare -A allowed=()
if [[ -f "$allowlist" ]]; then
  while IFS=$'\t' read -r tok reason; do
    [[ -z "$tok" || "$tok" == \#* ]] && continue
    allowed["$tok"]="${reason:-no reason recorded}"
  done < "$allowlist"
fi

findings=0
declare -A seen=()

report() {
  local verdict="$1" tok="$2" where="$3"
  printf '%-12s %-52s %s\n' "$verdict" "$tok" "$where"
}

# A line that says a path is absent is not asserting it is present. Skipping
# these is what lets an agent warn "~/.claude/agents/CHANGELOG.md does not
# exist" without the warning itself reading as the very defect it warns about.
negation_re='does not exist|do not exist|does not resolve|never existed|no longer exists|is not there|isn'"'"'t there|does not appear|will not appear|never appear|no directory under|non-existent|nonexistent'

for file in "${in_scope[@]}"; do
  rel="${file#"$lib_root"/}"
  # Is this file a skill? Skills address the account-synced tree by home path
  # legitimately, and their sub-files must resolve within their own directory.
  in_skill=0
  skill_dir=""
  if [[ "$rel" == .claude/skills/* ]]; then
    in_skill=1
    rest="${rel#.claude/skills/}"
    skill_dir="$lib_root/.claude/skills/${rest%%/*}"
  fi
  # Every backticked token on every line, with its line number.
  while IFS=: read -r lineno tok; do
    [[ -z "$tok" ]] && continue

    # Only things shaped like a path or a filename we could resolve.
    case "$tok" in
      *.md|*.sh|*.json|*.html|*.js|*.ts|*.py|*.yml|*.yaml|*/) ;;
      */*)                                                    ;;
      *) continue ;;
    esac

    # Placeholders and globs describe a shape, not a file. `[...]` is the
    # bracket form of the same thing — `decision-brief-[topic]-[date].html` is
    # an output filename template, not a file anyone can resolve.
    case "$tok" in
      *'<'*|*'>'*|*'*'*|*YYYY*|*'{'*|*'$'*|*' '*|*'['*|*']'*) continue ;;
    esac

    # Not paths: slash commands, URLs, and bare file extensions.
    case "$tok" in
      /[a-z-]*) [[ "$tok" != */*/* && "$tok" != *.* ]] && continue ;;
    esac
    case "$tok" in
      *://*)   continue ;;
      .[a-z]*) [[ "$tok" != */* ]] && continue ;;
    esac

    # Skip when the surrounding prose asserts the path is absent. Two lines,
    # not one: these files are hard-wrapped, so "`~/.claude/agents/` does" ends
    # a line and "**not** exist in a cloud session" begins the next. Checking
    # only the token's own line flagged both `README.md:18` and
    # `prompt-refiner/SKILL.md:118` — two deliberate warnings reported as the
    # very defect they warn about. The cost of the wider window is that a
    # negation about some *other* path on the next line can mask a real
    # finding; hard-wrapped prose makes that much rarer than the false positive.
    # Flattened to one line, with markdown emphasis stripped: the real sentence
    # in prompt-refiner reads "does" / newline / "**not** exist", which matches
    # nothing line-by-line and nothing with the asterisks left in.
    #
    # Backticked spans come out first, so the negation is read from the prose
    # and never from the path. Without that strip, a decoy pointer named
    # `references/nonexistent-playbook.md` exempted *itself* — the word
    # "nonexistent" is in the pattern — and the check passed a dead pointer.
    if sed -n "${lineno},$((lineno + 1))p" "$file" \
         | sed 's/`[^`]*`//g' \
         | tr '\n' ' ' | tr -d '*_' | grep -qiE "$negation_re"; then
      continue
    fi

    key="$tok"
    [[ -n "${allowed[$key]+x}" ]] && continue

    where="$rel:$lineno"
    dedup="$tok@@$rel"
    [[ -n "${seen[$dedup]+x}" ]] && continue
    seen["$dedup"]=1

    # A home path never resolves in a cloud container. Agents ship to cloud.
    # The one exception: a skill naming the account-synced skills tree it
    # actually lives in. That is the whole of the skills exemption — a skill
    # pointing at ~/.claude/agents/... is still a defect, and was one
    # (`prompt-refiner`, fixed 2026-09-11).
    if [[ "$tok" == '~/'* ]]; then
      if (( in_skill )) && [[ "$tok" == '~/.claude/skills/'* || "$tok" == '~/.claude/skills' ]]; then
        (( list_all )) && report "ok(synced)" "$tok" "$where"
        continue
      fi
      report "HOME-PATH" "$tok" "$where"
      findings=$((findings + 1))
      continue
    fi

    # Try, in order: repo root, under .claude/, beside the referring file,
    # then inside any skill directory (skills carry their own references/).
    # A skill's own assertions resolve against itself only — `references/x.md`
    # named in skill A must exist in skill A, not merely somewhere in the tree.
    stripped="${tok%/}"
    resolved=0
    if (( in_skill )); then
      bases=("$lib_root" "$lib_root/.claude" "$(dirname "$file")" "$skill_dir")
    else
      bases=("$lib_root" "$lib_root/.claude" "$(dirname "$file")" \
             "$lib_root/.claude/skills" "$lib_root"/.claude/skills/*/ \
             "$lib_root"/.claude/skills/_retired/)
    fi
    for base in "${bases[@]}"; do
      [[ -e "$base/$stripped" ]] && { resolved=1; break; }
    done
    if (( resolved )); then
      (( list_all )) && report "ok" "$tok" "$where"
      continue
    fi

    # A bare filename may live anywhere under the library.
    if [[ "$stripped" != */* ]]; then
      if find "$lib_root" -name "$stripped" -print -quit 2>/dev/null | grep -q .; then
        (( list_all )) && report "ok(found)" "$tok" "$where"
        continue
      fi
    fi

    report "UNRESOLVED" "$tok" "$where"
    findings=$((findings + 1))
  done < <(grep -onE '`[^`]+`' "$file" | sed 's/`//g')
done

echo
if (( findings > 0 )); then
  echo "$findings unresolved reference(s)."
  echo "Fix the pointer, or add the token to scripts/reference-allowlist.txt with a reason."
  exit 1
fi
echo "All asserted paths resolve."
