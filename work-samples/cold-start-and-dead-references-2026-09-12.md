# Two findings from asking "will my agents run in a new cloud session?"

The question was simple. Answering it honestly turned up one timing artefact that nearly
became a false published finding, and one real defect affecting 12 of the 16 agents.

## Finding 1 — the first turn of a fresh cloud session is not a measurement

A cloud session was created on `CLACFridays`, which carries 16 agents on `main` (verified
by `git ls-tree -r origin/main`, merged 4 minutes earlier). It was asked which agents it
could see.

| Turn | Answer |
|---|---|
| 1, eleven seconds in | **none** — zero of CPO, cody, ux-designer, security-auditor, mc-verifier |
| 2, same session, nothing changed | **all five**, 22 agent types total (16 + 6 built-ins) |

Its reported branch state was `{"": null}` on the first turn — consistent with a checkout
that had not registered yet.

**This had already happened once tonight** and was not recognised as the same thing: the
plugin declared in `~/.claude/settings.json` reported `no` on the first run and loaded all
16 agents on the second. Two sightings, same shape, four hours apart.

Had the first reading stood, this library would now carry a published finding that
committed agents do not reach cloud sessions — the exact opposite of the truth, on the
question the whole day's work was about.

Written up as `.claude/references/session-cold-start.md` and wired into `CPO` and
`mc-orchestrator`, the two agents that open by taking stock of what the session has.

The file is careful to exclude the **dispatch probe**: that reads whether an `Agent`/`Task`
tool exists, which is a harness tool present from turn 1. A negative there stays resolved.
Conflating the two would turn a real finding into a standing excuse.

## Finding 2 — every shared reference pointer was dead in cloud

`grep -rn "~/\.claude/references"` returns **13 occurrences across 12 files**. Every agent
that reads a shared gate — `review-gates.md`, `external-content.md`, `session-hygiene.md` —
pointed at `~/.claude/references/…`.

`~/.claude/references` **does not exist in a cloud container.** Confirmed here, the same
way `~/.claude/agents` was confirmed absent this morning. This is the fourth instance of
the defect class fixed in `CPO.md` and `watchdog.md` earlier today, and it was the largest
one still open.

Affected: `cody`, `code-improver`, `cos`, `CPO`, `mc-orchestrator`, `mc-planner`,
`mc-reviewer`, `security-auditor`, `ux-designer`, `watchdog` (×2), plus both
`stage-register.md` references. Twelve of the sixteen agents.

All 13 rewritten to the repo-relative `.claude/references/<file>.md`, each carrying a
one-clause locating note on its first occurrence in a file.

### The compounding half

`sync-agents.sh` copied `.claude/agents/*.md` and nothing else. So the four product repos
received, on 2026-09-11:

| Repo | agents on `main` | references on `main` |
|---|---|---|
| BalanceTRI-app | 16 | **0** |
| tri-momentum | 16 | **0** |
| CLACFridays | 16 | **0** |
| BalanceBolt | 16 | **0** |

Two failures stacked: agents pointing at a path that cannot resolve in cloud, at files that
were not shipped at all. The review-class agents — `code-improver`, `mc-reviewer`,
`security-auditor`, `watchdog` — would each run with no evidence gate. Several of them do
say "if it isn't present, say so and fall back", so they degrade rather than break; but
degraded is not working, and nothing would have surfaced it.

`sync-agents.sh` now copies both trees. Verified against a throwaway target: 16 agents +
3 references on first run, `unchanged: 19 file(s)` on the second.

## Still to do

The four product repos hold the **pre-fix** agents and no references. They need a re-sync
and four more PRs before any of this reaches them. Not done here — that is four outward
repositories and the user's call.
