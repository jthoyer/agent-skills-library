#!/usr/bin/env bash
# Checks every agent's frontmatter, and the trailing line of its body.
#
# Grep the frontmatter that grants a capability; never reason in prose about
# what an agent can do. A prose claim about tooling goes stale within hours —
# the frontmatter is the only source that cannot.
#
# Four defect classes, each free to find and each previously found by accident:
#   NAME!=FILENAME  the `name:` field is the dispatch address. A filename will
#                   not dispatch. Nine files were archived on 2026-08-18 without
#                   one filename matching the address anyone would have searched.
#   DESC>1024       a description over the cap is silently truncated, which is a
#                   routing failure nobody sees. Found security-auditor.md at
#                   1,129 characters on 2026-09-05, in one command.
#   NO-MODEL        the agent inherits a tier nobody chose.
#   ARTEFACT        a stray authoring tag on the last line. Six of six mc-* files
#                   ended with `</content>` from 2026-09-02, surviving four later
#                   commits that edited those very files and two agent-improver
#                   passes, because prose review skims trailing lines.
#
# Usage:
#   scripts/check-frontmatter.sh           # report flags only, exit 1 on any
#   scripts/check-frontmatter.sh --list    # full inventory table, then the flags
set -uo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lib_root="$(cd "$script_dir/.." && pwd)"
agents_dir="$lib_root/.claude/agents"

DESC_CAP=1024

list_all=0
[[ "${1:-}" == "--list" ]] && list_all=1

if [[ ! -d "$agents_dir" ]]; then
  echo "No agents directory at $agents_dir" >&2
  exit 1
fi

findings=0
count=0

(( list_all )) && printf '%-20s %-20s %-8s %-6s %s\n' FILE NAME MODEL DESC TOOLS

for f in "$agents_dir"/*.md; do
  [[ -e "$f" ]] || continue
  b="$(basename "$f" .md)"
  [[ "$b" == "CHANGELOG" ]] && continue
  count=$((count + 1))

  n="$(grep -m1 '^name:'  "$f" | sed 's/^name: *//')"
  t="$(grep -m1 '^tools:' "$f" | sed 's/^tools: *//')"
  m="$(grep -m1 '^model:' "$f" | sed 's/^model: *//')"

  # Description length: everything between `description:` and the next top-level key.
  dl="$(awk '/^description:/{f=1;sub(/^description: *>?-? */,"")}
             f&&/^[a-zA-Z_-]+:/&&!/^description:/{exit}
             f{printf "%s",$0}' "$f" | wc -c | tr -d ' ')"

  flags=()
  [[ "$n" != "$b" ]]      && flags+=("NAME!=FILENAME(declares '$n')")
  [[ "$dl" -gt $DESC_CAP ]] && flags+=("DESC>$DESC_CAP($dl)")
  [[ -z "$m" ]]           && flags+=("NO-MODEL")
  [[ -z "$t" ]]           && flags+=("NO-TOOLS")

  # Trailing authoring artefact on the last line of the body.
  last="$(tail -1 "$f")"
  case "$last" in
    ''|'</'*|'<'*'>') flags+=("ARTEFACT(last line: '${last:-<empty>}')") ;;
  esac

  (( list_all )) && printf '%-20s %-20s %-8s %-6s %s\n' "$b" "$n" "${m:--}" "$dl" "${t:--}"

  if [[ ${#flags[@]} -gt 0 ]]; then
    printf 'FLAG  %-20s %s\n' "$b" "${flags[*]}"
    findings=$((findings + ${#flags[@]}))
  fi
done

echo
if (( findings > 0 )); then
  echo "$findings frontmatter/body defect(s) across $count agents."
  echo "A non-empty flag is a live defect, not a note — fix it before routing anything."
  exit 1
fi
echo "$count agents: frontmatter and trailing lines clean."
