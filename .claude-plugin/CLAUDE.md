# Rules for the plugin manifest

`plugin.json` makes this repo installable as the `jh` plugin. It is the only surface that
carries agents to a session that doesn't have the repo attached.

- **A new agent needs a `passed` row in `ADMISSIONS.md` first.** It has to beat plain Claude
  on a recorded test (`.claude/references/admission-test.md`).
- **Never hand-edit the `agents` list.** It takes explicit `.md` paths, not a folder, so an
  agent added without it validates clean and ships missing. After adding, renaming or
  removing an agent, run `bash scripts/sync-plugin-manifest.sh` from the repo root.
- **`skills` points at a folder** (`./.claude/skills/`) and needs no step.
- **Keep the agent and skill counts true** when either changes. They appear twice: in
  `plugin.json`'s `description` and in `marketplace.json`'s. Update both together.

CI fails on drift via `sync-plugin-manifest.sh --check`. The push hook runs it too.
