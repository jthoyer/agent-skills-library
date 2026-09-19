#!/usr/bin/env bash
# Checks the frontmatter and trailing line of every agent AND every skill.
#
# Grep the frontmatter that grants a capability; never reason in prose about
# what an agent can do. A prose claim about tooling goes stale within hours —
# the frontmatter is the only source that cannot.
#
# --- Agents: .claude/agents/*.md -------------------------------------------
#   NAME!=FILENAME  the `name:` field is the dispatch address. A filename will
#                   not dispatch. Nine files were archived on 2026-08-18 without
#                   one filename matching the address anyone would have searched.
#   DESC>1024       a description over the cap is silently truncated, which is a
#                   routing failure nobody sees. Found security-auditor.md at
#                   1,129 characters on 2026-09-05, in one command.
#   NO-MODEL        the agent inherits a tier nobody chose.
#   NO-TOOLS        the agent inherits `*` — every tool, chosen by nobody.
#   ARTEFACT        a stray authoring tag on the last line. Six of six mc-* files
#                   ended with `</content>` from 2026-09-02, surviving four later
#                   commits that edited those very files and two agent-improver
#                   passes, because prose review skims trailing lines.
#
# --- Skills: .claude/skills/<name>/SKILL.md --------------------------------
# Added 2026-09-19. The skills half had none of this while being the half that
# actually reaches every session (skills are account-synced; agents are not).
# Every check below is one skills-librarian already specifies in its own
# "Audit the library" workflow (§4) and has only ever run by hand — which is how
# 13 broken sub-file pointers across 5 skills shipped under an "all 46 clean"
# audit note in the 2026-08-17 seed commit.
#   NO-SKILL.md     a skill directory with nothing to load.
#   BAD-FRONTMATTER the YAML block does not open on line 1 or never closes.
#   YAML-*          the block does not parse. Applied to agents too — see the
#                   `yaml_flags` comment for the defect it was written against.
#   TAB-IN-YAML     a tab in the frontmatter; YAML rejects it.
#   NAME!=DIRNAME   for a skill the *directory* name is the address, not a
#                   filename — every SKILL.md is called SKILL.md.
#   NO-DESC         no description means no trigger, so the skill never fires.
#   DESC>1024       same hard cap, same silent truncation.
#   BODY>500        skills-librarian's own stated standard. The fix is moving
#                   content into `references/` with a pointer, not deleting it.
#   ARTEFACT        same class as the agents' `</content>` defect.
#
# Description length is measured the way the YAML parser sees it, which is also
# the method skills-librarian §"Description character limit" writes down: strip
# the `description: >` key, strip indentation from continuation lines, join with
# single spaces, count characters. One measurement, both halves, so the two
# cannot drift.
#
# Characters, emphatically not bytes. These descriptions are full of em dashes
# at 3 bytes each, and `wc -m` silently counts bytes under a C locale — which is
# what CI runs under. On its first run this check reported `red-team` at 1,025
# and over cap; a real YAML parser says 1,021 characters, 1,025 bytes, i.e. 3
# characters of headroom. Dropping UTF-8 continuation bytes before counting is
# exact and locale-independent, which `wc -m` is not.
#
# Usage:
#   scripts/check-frontmatter.sh           # report flags only, exit 1 on any
#   scripts/check-frontmatter.sh --list    # full inventory tables, then flags
set -uo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lib_root="$(cd "$script_dir/.." && pwd)"
agents_dir="$lib_root/.claude/agents"
skills_dir="$lib_root/.claude/skills"

DESC_CAP=1024
BODY_CAP=500

list_all=0
[[ "${1:-}" == "--list" ]] && list_all=1

findings=0

# Characters in the description as the YAML parser would resolve it.
desc_len() {
  awk '
    /^---[[:space:]]*$/ { d++; if (d == 2) exit; next }
    d != 1 { next }
    /^description:/ {
      f = 1
      sub(/^description:[[:space:]]*[>|]?-?[[:space:]]*/, "")
      if ($0 != "") { out = out sep $0; sep = " " }
      next
    }
    f && /^[A-Za-z_][A-Za-z0-9_-]*:/ { f = 0 }
    f {
      line = $0
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)
      if (line != "") { out = out sep line; sep = " " }
    }
    END { printf "%s", out }
  ' "$1" | LC_ALL=C tr -d '\200-\277' | LC_ALL=C wc -c | tr -d ' '
}

# Does the frontmatter block actually parse as YAML?
#
# The defect this exists for: a `description:` written as an unquoted plain
# scalar that contains a colon-space. YAML reads `Triggers on: market analysis`
# as a nested mapping and throws — so the whole block fails to parse and the
# skill's trigger text is not there to match on. It is invisible to every prose
# read because the line is perfectly good English. `market-analyst/SKILL.md`
# shipped this way and was found by the first run of this check, 2026-09-19.
# skills-librarian §5 names the fix: a `>` block scalar.
#
# Implemented in bash so CI needs nothing installed. Where PyYAML happens to be
# importable, a real parse runs as well and catches anything this misses.
yaml_flags() {
  local file="$1" out=""
  out="$(awk '
    NR == 1 && !/^---[[:space:]]*$/ { print "BAD-FRONTMATTER(no opening --- on line 1)"; exit }
    NR == 1 { next }
    /^---[[:space:]]*$/ { closed = 1; exit }
    /^[[:space:]]*(#|$)/ { next }
    /^[A-Za-z_][A-Za-z0-9_-]*:/ {
      key = $0; sub(/:.*/, "", key)
      val = $0; sub(/^[A-Za-z_][A-Za-z0-9_-]*:[[:space:]]*/, "", val)
      if (val == "" || val ~ /^[>|]/ || val ~ /^"/ || val ~ /^'"'"'/) next
      if (val ~ /: /)  printf "YAML-UNQUOTED-COLON(%s: needs a > block scalar)\n", key
      else if (val ~ /:$/) printf "YAML-UNQUOTED-COLON(%s: trailing colon)\n", key
      next
    }
    /^[[:space:]]/ { next }     # indented continuation, fine
    /^- /           { next }    # list item, fine
    { printf "BAD-FRONTMATTER(unparseable line %d: %s)\n", NR, substr($0, 1, 40) }
    END { if (!closed) print "BAD-FRONTMATTER(block never closes)" }
  ' "$file")"

  # Belt and braces where the environment provides it. Never required.
  if python3 -c 'import yaml' 2>/dev/null; then
    local perr
    perr="$(python3 - "$file" <<'PY' 2>/dev/null
import re, sys, yaml
c = open(sys.argv[1], encoding='utf-8').read()
m = re.match(r'^---\n(.*?)\n---\n', c, re.DOTALL)
if not m:
    print("BAD-FRONTMATTER(no --- delimited block at top of file)")
else:
    try:
        yaml.safe_load(m.group(1))
    except Exception as e:
        print("YAML-PARSE-ERROR(%s)" % str(e).splitlines()[0])
PY
)"
    [[ -n "$perr" ]] && out="${out:+$out$'\n'}$perr"
  fi

  # Callers read this with `while read || [[ -n $y ]]`, because command
  # substitution strips the trailing newline and a plain `while read` drops the
  # final line — which silently ate the PyYAML finding while this was written.
  [[ -n "$out" ]] && printf '%s\n' "$out"
}

# A stray authoring tag or an empty final line. Both mean the body was written
# by something that did not finish cleanly, and both survive prose review.
trailing_artefact() {
  local last
  last="$(tail -1 "$1")"
  case "$last" in
    ''|'</'*|'<'*'>') printf 'ARTEFACT(last line: %s)' "${last:-<empty>}" ;;
  esac
}

# --------------------------------------------------------------------------
# Agents
# --------------------------------------------------------------------------
if [[ ! -d "$agents_dir" ]]; then
  echo "No agents directory at $agents_dir" >&2
  exit 1
fi

agent_count=0
(( list_all )) && { echo "AGENTS"; printf '%-20s %-20s %-8s %-6s %s\n' FILE NAME MODEL DESC TOOLS; }

for f in "$agents_dir"/*.md; do
  [[ -e "$f" ]] || continue
  b="$(basename "$f" .md)"
  [[ "$b" == "CHANGELOG" ]] && continue
  agent_count=$((agent_count + 1))

  n="$(grep -m1 '^name:'  "$f" | sed 's/^name: *//;s/ *$//')"
  t="$(grep -m1 '^tools:' "$f" | sed 's/^tools: *//')"
  m="$(grep -m1 '^model:' "$f" | sed 's/^model: *//')"
  dl="$(desc_len "$f")"

  flags=()
  while IFS= read -r y || [[ -n "$y" ]]; do [[ -n "$y" ]] && flags+=("$y"); done < <(yaml_flags "$f")
  [[ "$n" != "$b" ]]        && flags+=("NAME!=FILENAME(declares '$n')")
  [[ "$dl" -gt $DESC_CAP ]] && flags+=("DESC>$DESC_CAP($dl)")
  [[ -z "$m" ]]             && flags+=("NO-MODEL")
  [[ -z "$t" ]]             && flags+=("NO-TOOLS")
  a="$(trailing_artefact "$f")"; [[ -n "$a" ]] && flags+=("$a")

  (( list_all )) && printf '%-20s %-20s %-8s %-6s %s\n' "$b" "$n" "${m:--}" "$dl" "${t:--}"

  if [[ ${#flags[@]} -gt 0 ]]; then
    printf 'FLAG  agent  %-20s %s\n' "$b" "${flags[*]}"
    findings=$((findings + ${#flags[@]}))
  fi
done

# --------------------------------------------------------------------------
# Skills
# --------------------------------------------------------------------------
skill_count=0
if [[ -d "$skills_dir" ]]; then
  (( list_all )) && { echo; echo "SKILLS"; printf '%-34s %-34s %-6s %-6s %s\n' DIR NAME DESC LINES SUBDIRS; }

  for d in "$skills_dir"/*/; do
    [[ -d "$d" ]] || continue
    b="$(basename "$d")"
    # _retired holds archived originals, kept unmodified by design.
    [[ "$b" == "_retired" ]] && continue
    skill_count=$((skill_count + 1))

    s="$d/SKILL.md"
    if [[ ! -f "$s" ]]; then
      printf 'FLAG  skill  %-34s %s\n' "$b" "NO-SKILL.md"
      findings=$((findings + 1))
      continue
    fi

    flags=()
    while IFS= read -r y || [[ -n "$y" ]]; do [[ -n "$y" ]] && flags+=("$y"); done < <(yaml_flags "$s")

    fm="$(awk 'NR==1{next} /^---[[:space:]]*$/{exit} {print}' "$s")"
    [[ "$fm" == *$'\t'* ]] && flags+=("TAB-IN-YAML")

    n="$(printf '%s\n' "$fm" | grep -m1 '^name:' | sed 's/^name: *//;s/ *$//')"
    [[ "$n" != "$b" ]] && flags+=("NAME!=DIRNAME(declares '${n:-<none>}')")

    dl="$(desc_len "$s")"
    if ! printf '%s\n' "$fm" | grep -q '^description:'; then
      flags+=("NO-DESC")
      dl=0
    elif [[ "$dl" -gt $DESC_CAP ]]; then
      flags+=("DESC>$DESC_CAP($dl)")
    fi

    bl="$(wc -l < "$s" | tr -d ' ')"
    [[ "$bl" -gt $BODY_CAP ]] && flags+=("BODY>$BODY_CAP($bl) — move content to references/")

    a="$(trailing_artefact "$s")"; [[ -n "$a" ]] && flags+=("$a")

    if (( list_all )); then
      subs="$(find "$d" -mindepth 1 -maxdepth 1 -type d -printf '%f ' 2>/dev/null)"
      printf '%-34s %-34s %-6s %-6s %s\n' "$b" "${n:--}" "$dl" "$bl" "${subs:--}"
    fi

    if [[ ${#flags[@]} -gt 0 ]]; then
      printf 'FLAG  skill  %-34s %s\n' "$b" "${flags[*]}"
      findings=$((findings + ${#flags[@]}))
    fi
  done
fi

# --------------------------------------------------------------------------
# The skills index in .claude/skills/README.md, against disk
# --------------------------------------------------------------------------
# Agents have `sync-plugin-manifest.sh --check` holding plugin.json to the files
# on disk. Skills have no manifest — plugin.json points at the directory — so
# their README is the index, and nothing held it to anything. On 2026-09-19 it
# declared 49 skills, listed 11 icare skills and `content-writing` retired weeks
# earlier, and omitted `rewrite`, live since 2026-09-11: 12 errors in the one
# file a person reads to find out what the library contains.
#
# Matched on backticked names in the categorised list only, so prose elsewhere
# in the README cannot register a skill as present.
readme="$skills_dir/README.md"
if [[ -f "$readme" && -d "$skills_dir" ]]; then
  mapfile -t on_disk < <(
    for d in "$skills_dir"/*/; do
      b="$(basename "$d")"
      [[ "$b" == "_retired" ]] && continue
      [[ -f "$d/SKILL.md" ]] && echo "$b"
    done | sort
  )
  mapfile -t indexed < <(
    awk '/^\*\*.*\([0-9]+\)\*\* —/,/^$/' "$readme" \
      | grep -oE '`[a-z0-9][a-z0-9-]*`' | tr -d '`' | sort -u
  )

  declare -A disk_set=() index_set=()
  for s in "${on_disk[@]}"; do disk_set["$s"]=1; done
  for s in "${indexed[@]}"; do index_set["$s"]=1; done

  for s in "${on_disk[@]}"; do
    if [[ -z "${index_set[$s]+x}" ]]; then
      printf 'FLAG  index  %-34s %s\n' "$s" "ON-DISK-NOT-IN-README"
      findings=$((findings + 1))
    fi
  done
  for s in "${indexed[@]}"; do
    if [[ -z "${disk_set[$s]+x}" ]]; then
      printf 'FLAG  index  %-34s %s\n' "$s" "IN-README-NOT-ON-DISK"
      findings=$((findings + 1))
    fi
  done

  declared="$(grep -m1 -oE '^## Skills \([0-9]+\)' "$readme" | grep -oE '[0-9]+')"
  if [[ -n "$declared" && "$declared" != "${#on_disk[@]}" ]]; then
    printf 'FLAG  index  %-34s %s\n' "README.md" \
      "COUNT-STALE(declares $declared, ${#on_disk[@]} on disk)"
    findings=$((findings + 1))
  fi
fi

echo
if (( findings > 0 )); then
  echo "$findings frontmatter/body defect(s) across $agent_count agents and $skill_count skills."
  echo "A non-empty flag is a live defect, not a note — fix it before routing anything."
  exit 1
fi
echo "$agent_count agents and $skill_count skills: frontmatter and trailing lines clean."
