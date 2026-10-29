#!/usr/bin/env bash
# Admission check: nothing joins the library without evidence that it beats
# plain Claude. Rule: .claude/references/admission-test.md. Registry: ADMISSIONS.md.
#
# Why a script: the 20 Oct test found agents tied plain Claude on detection, and
# on 6 Sep content-writing lost to no skill at all. Nothing had tested it before
# it went in. A rule that needs someone to remember it fails the way that one did.
#
#   MISSING      an agent or skill on disk has no row in ADMISSIONS.md
#   STALE        a row names something that no longer exists
#   NO-EVIDENCE  a `passed` row whose evidence isn't an existing path under work-samples/
#   NEW-GRANDFATHER  a `grandfathered` row not in the frozen 2026-10-29 list below
#   BAD-STATUS   a status other than `passed` or `grandfathered`
#
# The frozen list is meant to stay frozen. Removing a name (it passed, or it
# was retired) is fine. Adding one is the defect this script exists to catch.
#
# Requires: bash, awk, grep.
set -uo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
reg="$root/ADMISSIONS.md"

GRANDFATHERED=" agent-improver cluster-analyst code-improver cody evidence-auditor idea-challenger
investigator mc-integrator mc-planner mc-reviewer mc-verifier release-engineer security-auditor
source-scout strategy-challenger strategy-juror ux-designer watchdog
academic-researcher balance-tri-club-brand business-case-builder content-research-writer cos cpo
customer-insight deep-research discovery-loop editor etf-investing-advisor etf-investing-coach
first-principles high-output-management humanizer issue-tree job-scan justin-voice made-to-stick
market-analyst mc-orchestrator multi-actor-research multi-actor-strategy notion-second-brain
positioning product-requirement-document project-management read-the-room recent-pulse red-team
research-to-ideas resume-builder rewrite scr-pyramid-communicator six-thinking-hats
skills-librarian terse-mode triathlon-coach youtube-explainer "
GRANDFATHERED=" $(echo $GRANDFATHERED) "

findings=0
flag() { printf '%-17s %s\n' "$1" "$2"; findings=$((findings + 1)); }

[[ -f "$reg" ]] || { echo "MISSING-REGISTRY  ADMISSIONS.md not found"; exit 1; }

# Rows as "kind<TAB>name<TAB>status<TAB>evidence", kind from the section heading.
rows="$(awk -F'|' '
  /^## Agents/ {k="agent"; next}
  /^## Skills/ {k="skill"; next}
  /^## / {k=""; next}
  k!="" && /^\|/ && $2 !~ /Name|---/ {
    n=$2; s=$3; e=$4
    gsub(/^ +| +$/,"",n); gsub(/^ +| +$/,"",s); gsub(/^ +| +$/,"",e)
    printf "%s\t%s\t%s\t%s\n", k, n, s, e
  }' "$reg")"

on_disk=""
for f in "$root"/.claude/agents/*.md; do
  n="$(grep -m1 '^name:' "$f" | awk '{print $2}')"
  on_disk+="agent	$n"$'\n'
done
for d in "$root"/.claude/skills/*/; do
  n="$(basename "$d")"
  [[ "$n" == _retired || ! -f "$d/SKILL.md" ]] && continue
  on_disk+="skill	$n"$'\n'
done

while IFS=$'\t' read -r kind name; do
  [[ -z "$name" ]] && continue
  printf '%s\n' "$rows" | grep -q "^$kind	$name	" || flag MISSING "$kind $name: add a row to ADMISSIONS.md (see .claude/references/admission-test.md)"
done <<< "$on_disk"

while IFS=$'\t' read -r kind name status evidence; do
  [[ -z "$name" ]] && continue
  printf '%s' "$on_disk" | grep -q "^$kind	$name$" || flag STALE "$kind $name: listed but not on disk"
  case "$status" in
    passed)
      if [[ "$evidence" != work-samples/* || ! -e "$root/$evidence" ]]; then
        flag NO-EVIDENCE "$kind $name: evidence must be an existing work-samples/ path, got '$evidence'"
      fi ;;
    grandfathered)
      [[ "$GRANDFATHERED" == *" $name "* ]] || flag NEW-GRANDFATHER "$kind $name: new parts must pass the admission test, not be grandfathered" ;;
    *) flag BAD-STATUS "$kind $name: status '$status'" ;;
  esac
done <<< "$rows"

if (( findings )); then
  printf '\n%d admission finding(s).\n' "$findings"
  exit 1
fi
echo "admissions: every agent and skill has a row; no new part without evidence"
