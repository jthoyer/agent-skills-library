#!/usr/bin/env bash
# Copies this library's .claude/agents/*.md into another repo's .claude/agents/.
# Agents aren't account-synced like skills, so consuming repos hold a snapshot
# that needs re-syncing by hand after changes here. This script just makes the
# re-copy a one-liner; it never deletes files in the target that aren't sourced
# from here.
set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") <target-repo-path>" >&2
  echo "Copies this library's .claude/agents/*.md into <target-repo-path>/.claude/agents/." >&2
  exit 1
}

[[ $# -eq 1 ]] || usage

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lib_root="$(cd "$script_dir/.." && pwd)"
src_dir="$lib_root/.claude/agents"
target_repo="$(cd "$1" && pwd)"
dest_dir="$target_repo/.claude/agents"

if [[ ! -d "$src_dir" ]]; then
  echo "No agents found at $src_dir" >&2
  exit 1
fi

mkdir -p "$dest_dir"

added=()
updated=()
unchanged=0

for src in "$src_dir"/*.md; do
  name="$(basename "$src")"
  dest="$dest_dir/$name"
  if [[ ! -f "$dest" ]]; then
    cp "$src" "$dest"
    added+=("$name")
  elif ! cmp -s "$src" "$dest"; then
    cp "$src" "$dest"
    updated+=("$name")
  else
    unchanged=$((unchanged + 1))
  fi
done

echo "Synced agents into $dest_dir"
if [[ ${#added[@]} -gt 0 ]]; then
  printf '  added:     %s\n' "${added[@]}"
fi
if [[ ${#updated[@]} -gt 0 ]]; then
  printf '  updated:   %s\n' "${updated[@]}"
fi
if [[ $unchanged -gt 0 ]]; then
  echo "  unchanged: $unchanged file(s)"
fi
echo "Review the diff and commit in the target repo."
