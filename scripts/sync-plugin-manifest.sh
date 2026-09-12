#!/usr/bin/env bash
# Regenerates the "agents" array in .claude-plugin/plugin.json from .claude/agents/*.md.
#
# Why this exists: plugin.json's "agents" field takes explicit .md paths, not a
# directory (a directory fails validation). So adding an agent without updating the
# manifest silently leaves it out of the plugin — it validates clean and ships short.
# "skills" does take a directory and needs no such step.
#
# Run with --check in CI or before a release to fail on drift instead of fixing it.
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lib_root="$(cd "$script_dir/.." && pwd)"
manifest="$lib_root/.claude-plugin/plugin.json"
agents_dir="$lib_root/.claude/agents"

[[ -f "$manifest" ]] || { echo "No manifest at $manifest" >&2; exit 1; }
[[ -d "$agents_dir" ]] || { echo "No agents at $agents_dir" >&2; exit 1; }

check_only=false
[[ "${1:-}" == "--check" ]] && check_only=true

python3 - "$manifest" "$agents_dir" "$lib_root" "$check_only" <<'PY'
import json, sys, glob, os
manifest, agents_dir, lib_root, check_only = sys.argv[1:5]
found = sorted("./" + os.path.relpath(p, lib_root) for p in glob.glob(os.path.join(agents_dir, "*.md")))
d = json.load(open(manifest))
current = d.get("agents", [])
if current == found:
    print(f"plugin.json agents list is current ({len(found)} agents).")
    sys.exit(0)
missing = [a for a in found if a not in current]
stale = [a for a in current if a not in found]
for a in missing: print(f"  missing from manifest: {a}")
for a in stale:   print(f"  in manifest but not on disk: {a}")
if check_only == "true":
    print(f"DRIFT: manifest lists {len(current)}, disk has {len(found)}. Run sync-plugin-manifest.sh to fix.")
    sys.exit(1)
d["agents"] = found
json.dump(d, open(manifest, "w"), indent=2)
open(manifest, "a").write("\n")
print(f"Updated plugin.json: {len(found)} agents.")
PY
