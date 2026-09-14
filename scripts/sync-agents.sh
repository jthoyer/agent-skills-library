#!/usr/bin/env bash
# Copies this library's .claude/agents/*.md AND .claude/references/*.md into
# another repo's .claude/.
#
# Agents aren't account-synced like skills, so consuming repos hold a snapshot
# that needs re-syncing by hand after changes here. This script just makes the
# re-copy a one-liner; it never deletes files in the target that aren't sourced
# from here.
#
# References are copied because 12 of the 16 agents read one of them
# (review-gates, external-content, session-hygiene) by repo-relative path.
# Shipping agents without them leaves every review-class agent running with no
# evidence gate — which is exactly what happened on 2026-09-11, when the four
# consuming repos received 16 agents and 0 references.
set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") <target-repo-path>" >&2
  echo "Copies this library's .claude/agents/*.md into <target-repo-path>/.claude/agents/." >&2
  exit 1
}

[[ $# -eq 1 ]] || usage

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lib_root="$(cd "$script_dir/.." && pwd)"
target_repo="$(cd "$1" && pwd)"

if [[ ! -d "$lib_root/.claude/agents" ]]; then
  echo "No agents found at $lib_root/.claude/agents" >&2
  exit 1
fi

added=()
updated=()
unchanged=0

copy_tree() {
  local src_dir="$1" dest_dir="$2" label="$3"
  [[ -d "$src_dir" ]] || { echo "  (no $label to copy at $src_dir)"; return; }
  mkdir -p "$dest_dir"
  local src name dest
  for src in "$src_dir"/*.md; do
    [[ -e "$src" ]] || continue
    name="$label/$(basename "$src")"
    dest="$dest_dir/$(basename "$src")"
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
}

copy_tree "$lib_root/.claude/agents"     "$target_repo/.claude/agents"     "agents"
copy_tree "$lib_root/.claude/references" "$target_repo/.claude/references" "references"

echo "Synced into $target_repo/.claude/"
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
