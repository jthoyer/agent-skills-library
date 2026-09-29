# multi-actor-strategy — frozen inputs, 2026-09-29

The question and evidence pack for the agent plan's phase 1 baseline
(`.claude/skills/multi-actor-strategy/references/agent-plan.md`). **Phase 4 re-runs the skill
on this file alone.** Do not give a phase 4 run the baseline output
(`multi-actor-strategy-2026-09-29-baseline.md`). If it has seen that output, it is not a fair comparison.

The evidence is frozen as of 2026-09-29. A later run judges the decision as it stood on that
date, even if the facts have moved since.

## The question as raised

The 2026-09-11 full roster review (`work-samples/library-review-2026-09-11.md`, Part 3) deferred
the composition of the six `mc-*` coding agents and proposed a rule, for sign-off:

> If by **2026-10-01** no `mc-orchestrator` run has persisted a complete four-stage register,
> that is three consecutive weeks with the pipeline's central claim unevidenced, and the
> composition question gets answered on that — not on a dispatch probe.

Decision-maker: Justin (library owner). CPO holds portfolio authority to propose; retirements
need the owner's yes.

## Evidence pack

| # | Fact | Source |
|---|---|---|
| E1 | Six agents: `mc-orchestrator` (85 lines), `mc-planner` (44), `mc-reviewer` (46), `mc-implementer` (32), `mc-verifier` (32), `mc-integrator` (37). 20 commits between them; last edits 2026-09-12 to 2026-09-20. | `git log`, `wc -l` on `.claude/agents/mc-*.md` |
| E2 | No complete four-stage `mc-orchestrator` register has ever been persisted in this repo. None added since 2026-09-11. | `grep` of `work-samples/`, `CHANGELOG.md` |
| E3 | 22 of 26 sessions in the week to 2026-09-11 ran in five other repos (BalanceTRI-app, tri-momentum, CLACFridays, BalanceBolt, personal). Coding work happens there. Those repos are not visible from here, so pipeline use there is **unknown**. | `library-review-2026-09-11.md` F1 |
| E4 | Agents were not account-synced before 2026-09-10 (`scripts/sync-agents.sh`). Since 2026-09-11 the library ships as a plugin, and a fresh cloud session saw all agents. | `CHANGELOG.md` 2026-09-11, 2026-09-12 |
| E5 | An independently dispatched `mc-reviewer`, with `mc-verifier`, graded three `cody` dispatches on a 97-criterion app rebuild and found a real defect that cody's own 62-assertion suite missed. This ran **outside** the pipeline, dispatched from the top level. | `CHANGELOG-ARCHIVE.md` ~line 83–86 |
| E6 | `mc-reviewer` (Read, Grep, Glob) cannot execute; `mc-verifier` (Bash, Read, Grep, Glob) cannot edit. These tool limits were the stated reason the `mc-*` agents survived the 2026-08-18 cull that retired the eight `mar-*` agents. | `CHANGELOG-ARCHIVE.md` line 147; `CPO.md` |
| E7 | Dispatch has been observed from the top level only, never from an orchestrator fanning out to its actors. `mc-orchestrator.md` declares `Agent`. `CPO.md` step 4 tells CPO to dispatch the reviewer/verifier pair itself. | `CPO.md` lines 107, 179 |
| E8 | Dispatch reachability varies by session: present 2026-09-04/05/06, absent 2026-08-16, 08-18 and 09-11. This session (2026-09-29, cloud) has the Agent tool. | `library-review-2026-09-11.md` Part 3; this session |
| E9 | The eight `mar-*` agents were retired to a skill after five weeks with zero persisted artefacts. `research-to-ideas` later added four agents behind a skill-as-conductor, each justified by a blindness rule or a tool difference, with a retire test. | `CHANGELOG-ARCHIVE.md` 2026-08-18; `research-to-ideas/references/agent-workflow.md` |
| E10 | `cody` implements coding tasks, frontend and backend. It overlaps `mc-implementer`'s job ("turn an approved spec into working code"). | agent descriptions |
| E11 | BalanceBolt now has `run-tests.mjs` (161 checks) and a browser harness, so `mc-verifier` has something to execute there. Before 2026-09-04 it had none. | `10X-LOG.md` 2026-09-04, 2026-09-25 |
| E12 | The owner's mandate is cited in the ledger as rank-3 verb "Shrink and stabilise". The mandate file (`~/.claude/COS/mandate.md`) is not visible from this repo. | `CHANGELOG.md` line 283 |
| E13 | Whether the 2026-10-01 rule was ever signed off is not recorded. | ledger search |

## Audience

Justin, as library owner, deciding on or just after 2026-10-01. He reads the decision brief, not
the working.
