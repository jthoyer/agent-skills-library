#!/usr/bin/env bash
# PreToolUse hook (Edit|Write|MultiEdit). Blocks edits inside .claude/skills/_retired/.
#
# _retired/ is an unmodified archive: every check script excludes it on that
# promise. An edit there changes history nobody re-checks, and a skill revived
# by editing in place skips the checks a live skill must pass.
#
# Retiring a skill still works: that is a `git mv` through Bash, which this hook
# never sees. To revive one, move it back out first, then edit.
#
# Requires: bash, jq.
set -uo pipefail

input="$(cat)"
command -v jq >/dev/null 2>&1 || exit 0

path="$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')"

case "$path" in
  */.claude/skills/_retired/*|.claude/skills/_retired/*)
    echo "Blocked: $path is in .claude/skills/_retired/, an unmodified archive. To revive the skill, git mv it back to .claude/skills/ first, then edit." >&2
    exit 2
    ;;
esac
exit 0
