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
# Scope is the cloud-shipped surface: .claude/agents/ and .claude/references/.
# .claude/skills/ is deliberately excluded — skills
# are account-synced and legitimately live at ~/.claude/skills/, so the home-path
# rule below would invert there. _retired/ is excluded as an unmodified archive.
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

# Files in scope: what an agent asserts to a live runtime. The ledgers at the
# repo root are deliberately out — CHANGELOG.md records paths as they *were*,
# including every one since fixed, so checking it reports history as breakage.
mapfile -t in_scope < <(
  find "$lib_root/.claude/agents" "$lib_root/.claude/references" -name '*.md' 2>/dev/null
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
  # Every backticked token on every line, with its line number.
  while IFS=: read -r lineno tok; do
    [[ -z "$tok" ]] && continue

    # Only things shaped like a path or a filename we could resolve.
    case "$tok" in
      *.md|*.sh|*.json|*.html|*.js|*.ts|*.py|*.yml|*.yaml|*/) ;;
      */*)                                                    ;;
      *) continue ;;
    esac

    # Placeholders and globs describe a shape, not a file.
    case "$tok" in
      *'<'*|*'>'*|*'*'*|*YYYY*|*'{'*|*'$'*|*' '*) continue ;;
    esac

    # Not paths: slash commands, URLs, and bare file extensions.
    case "$tok" in
      /[a-z-]*) [[ "$tok" != */*/* && "$tok" != *.* ]] && continue ;;
    esac
    case "$tok" in
      *://*)   continue ;;
      .[a-z]*) [[ "$tok" != */* ]] && continue ;;
    esac

    # Skip when the surrounding line asserts the path is absent.
    if sed -n "${lineno}p" "$file" | grep -qiE "$negation_re"; then
      continue
    fi

    key="$tok"
    [[ -n "${allowed[$key]+x}" ]] && continue

    where="$rel:$lineno"
    dedup="$tok@@$rel"
    [[ -n "${seen[$dedup]+x}" ]] && continue
    seen["$dedup"]=1

    # A home path never resolves in a cloud container. Agents ship to cloud.
    if [[ "$tok" == '~/'* ]]; then
      report "HOME-PATH" "$tok" "$where"
      findings=$((findings + 1))
      continue
    fi

    # Try, in order: repo root, under .claude/, beside the referring file,
    # then inside any skill directory (skills carry their own references/).
    stripped="${tok%/}"
    resolved=0
    for base in "$lib_root" "$lib_root/.claude" "$(dirname "$file")" \
                "$lib_root/.claude/skills" "$lib_root"/.claude/skills/*/ \
                "$lib_root"/.claude/skills/_retired/; do
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
