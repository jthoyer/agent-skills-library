# `mc-*` usage check, 2026-09-29

The usage check on `mc-orchestrator`, `mc-planner` and `mc-integrator` that the 2026-09-29
`library — portfolio` entry in `CHANGELOG.md` set for 2026-10-08. Run early, on the owner's request.

**Question:** has any of the three been used since 2026-09-10 in the consuming repos?

**Answer: no use found.** Owner decision on this result: **keep all three.** No retirement, no
new default.

## What was checked

| Source | Scope | Result |
|---|---|---|
| Git history, BalanceBolt | Every branch, cloned read-only; commit messages since 2026-09-10; every file outside `.claude/agents` and `.claude/skills` | No use. Matches were library copies (`.claude/references/*`) and one comment in `run-tests.mjs` saying `mc-verifier` can run it |
| Git history, BalanceTRI-app | As above | No use. Matches were library copies only |
| Git history, CLACFridays | As above | No use. Matches were library copies only |
| Git history, tri-momentum | As above | No use of the three. `CLAUDE.md` records an independent `mc-reviewer` catching three defects self-review missed, from about 2026-09-01 (before the window, and the pair, not the three) |
| Pipeline artefacts, all four repos | Every branch; searched for Stage Registers, Handoff Notes, specs with acceptance criteria or non-goals | None found |
| Cloud sessions | 85 sessions created since 2026-09-10 (47 BalanceTRI-app, 17 agent-skills-library, 11 BalanceBolt, 4 CLACFridays, 1 tri-momentum, 5 with no repo); titles and summaries | None names the three or the coding pipeline. The one session naming any `mc-*` agent was a 2026-09-12 agent availability check (a probe, not use) |

All four repos hold the six `mc-*` agent files on their default branch, synced from this library.
The agents were **present** in every repo. They were not **used**.

## Not checked

- **"personal"**: no repo by that name exists on GitHub for this account.
- **Local sessions** run on the owner's machine: not in the cloud session list.
- **Session transcripts**: only titles and summaries were read, not full events.

If any of these holds a pipeline run, this result is wrong.
