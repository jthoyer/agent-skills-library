#!/usr/bin/env bash
# PreToolUse hook (Bash). Runs the library's CI checks before any `git push`.
#
# CLAUDE.md used to say "before pushing, run the health checks". That relied on
# memory, the failure mode checks.yml was written to remove: four dead pointers
# shipped in one week past readers looking straight at them. A hook does not
# forget. CI stays as the backstop.
#
# Mirrors .github/workflows/checks.yml step for step. Add a step there, add it here.
#
# Exit 2 blocks the push and hands the findings to Claude. Any other command
# passes straight through.
#
# Requires: bash, jq, python3 (the last two only for the push case).
set -uo pipefail

input="$(cat)"

if ! command -v jq >/dev/null 2>&1; then
  echo "pre-push-checks: jq not found, checks skipped. CI will still run them." >&2
  exit 0
fi

cmd="$(printf '%s' "$input" | jq -r '.tool_input.command // empty')"

# `git push`, `git -C <dir> push`, `git push -u origin x`. A false match on
# something like `git log --grep push` only costs a few seconds of checks.
printf '%s' "$cmd" | grep -Eq '(^|[;&|[:space:]])git([[:space:]]+[^;&|]*)?[[:space:]]push([[:space:]]|$)' || exit 0

lib_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$lib_root" || exit 0

failed=()
run() {
  local label="$1"; shift
  local out
  if ! out="$("$@" 2>&1)"; then
    failed+=("$label")
    printf '\n== %s ==\n%s\n' "$label" "$out" >&2
  fi
}

run "References resolve"                bash scripts/check-references.sh
run "Plugin manifest current"           bash scripts/sync-plugin-manifest.sh --check
run "Frontmatter and trailing lines"    bash scripts/check-frontmatter.sh
run "Skill structure"                   bash scripts/check-skill-structure.sh
run "research-to-ideas checker tests"   python3 .claude/skills/research-to-ideas/scripts/test_check_brief.py
run "multi-actor-strategy checker tests" python3 .claude/skills/multi-actor-strategy/scripts/test_check_strategy.py

if (( ${#failed[@]} )); then
  printf '\nPush blocked: %d check(s) failed: %s. Fix them, then push again.\n' \
    "${#failed[@]}" "$(IFS=,; echo "${failed[*]}")" >&2
  exit 2
fi
exit 0
