# Agents CHANGELOG

The improvement ledger for this agent library. Every review by `agent-improver` appends a dated entry here. The goal: agents that are measurably better in three months than they are today.

**How to read this:** each entry records what changed, why, and how you'd know it worked. Before re-reviewing an agent, read its most recent entry and check whether the last fix actually helped. The index below says where that entry is.

**Entry format:**

```
## YYYY-MM-DD — <agent name>
- Verdict: <one line>
- Changed: <what was edited, or "no edits — proposed N fixes">
- Why: <root cause>
- Expected effect: <what should improve, and how you'd know>
- Follow-up: <deferred items or items needing sign-off>
```

Keep an entry inside **250 words per agent reviewed**, declared in the heading when it covers more than one. Overflow goes to `work-samples/`, not into the entry.

---

## How this ledger is split (changed 2026-09-13)

**This file holds the current month only.** When the month turns, the closing month's entries move verbatim to `changelog/YYYY-MM.md`. Nothing is trimmed and nothing is dropped — size is bounded by construction, so a single `Read` always returns the whole live file.

| File | Holds |
|---|---|
| `CHANGELOG.md` | the current month |
| `changelog/YYYY-MM.md` | one closed month each, verbatim |
| `changelog/YYYY-MM-1.md`, `-2.md` | a closed month too big for one read, split at the 16th (2026-09 is the first) |
| `CHANGELOG-ARCHIVE.md` | everything moved out by the old retention sweeps (pre-2026-09-13) |

**This replaces the old retention rules.** Top-2-per-agent, the top-4 `library — portfolio` cap, and the periodic sweeps all existed to keep one growing file under a single `Read`. A month split does that structurally, so they are retired: **do not sweep, do not trim, do not archive on size grounds.** If a month ever grows past a single read on its own, split that month by fortnight rather than deleting anything.

*(History, since the file used to argue about this: the cliff was measured at 67.5–71.2 KB by `wc -c`, and on 2026-09-12 the live file reached 69.3 KB — about 200 tokens of margin — with retention able to free nothing, because every entry over the library cap was held by some agent's top-2. That is what forced the split.)*

---

## Where each agent's history lives

Counts are entries whose **heading names** the agent — which includes creation and batch entries, not only reviews of it. A row is a pointer to where to look, not evidence the agent has been reviewed.

| Agent | Latest entries in | Also in |
|---|---|---|
| `CPO` (retired 2026-10-13 → `cpo` skill) | `changelog/2026-09-2.md`×4, `changelog/2026-09-1.md`×9 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×4 |
| `agent-improver` | `changelog/2026-09-1.md`×4 | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md`×5 |
| `code-improver` | `changelog/2026-09-1.md`×2 | `CHANGELOG-ARCHIVE.md`×4 |
| `cluster-analyst` | `changelog/2026-09-2.md`×2 | — |
| `cody` | `CHANGELOG.md`, `changelog/2026-09-2.md`×2, `changelog/2026-09-1.md`×2 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×8 |
| `cos` (agent retired 2026-10-13 → `cos` skill) | `changelog/2026-09-2.md`, `changelog/2026-09-1.md`×2 | — |
| `evidence-auditor` | `changelog/2026-09-2.md`×2 | — |
| `idea-challenger` | `CHANGELOG.md`, `changelog/2026-09-2.md`×2 | — |
| `investigator` | `changelog/2026-09-2.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `mc-implementer` (retired 2026-09-29, `.claude/skills/_retired/mc-implementer/`) | `changelog/2026-09-2.md` | `changelog/2026-08.md`×2 |
| `mc-integrator` | `changelog/2026-09-2.md`, `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `mc-orchestrator` (agent retired 2026-10-13 → skill) | `changelog/2026-09-2.md`, `changelog/2026-09-1.md` | `changelog/2026-08.md`×2, `CHANGELOG-ARCHIVE.md`×5 |
| `mc-planner` | `changelog/2026-08.md`×2 | `CHANGELOG-ARCHIVE.md`×5 |
| `mc-reviewer` | `changelog/2026-09-1.md` | `changelog/2026-08.md`×2, `CHANGELOG-ARCHIVE.md`×4 |
| `mc-verifier` | `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md`×2 |
| `release-engineer` | `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `security-auditor` | `changelog/2026-09-1.md`×3 | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `source-scout` | `changelog/2026-09-2.md`×2 | — |
| `strategy-challenger` | `changelog/2026-09-2.md`×2 | — |
| `strategy-juror` | `changelog/2026-09-2.md`×2 | — |
| `ux-designer` | `CHANGELOG-ARCHIVE.md` | — |
| `watchdog` | `changelog/2026-09-1.md`×2 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×3 |

---

<!-- New entries below this line, newest first -->

## 2026-10-14 — library — portfolio (app repos keep no agent copies; `sync-agents.sh` retired)
- Decision (owner, 2026-10-14): the library is the only source of agents and references. Copies removed from BalanceTRI-app (#91), BalanceBolt (#27), tri-momentum (#14) and CLACFridays (#18); each now carries a one-line note to attach the library. `scripts/sync-agents.sh` is deleted (git history keeps it).
- Evidence: three of four app repos held stale copies, including the three agents retired on 2026-10-13, and five more had drifted. The sync script never deletes, so every retirement left orphans behind.
- Trade-off accepted: agents are not account-synced, so a session on an app repo alone has no library agents. Attaching the library restores them.
- Rejected: re-syncing the copies. It keeps app-only sessions working but recreates the drift.
- Reverses if: attaching the library to app sessions proves impractical, or the `jh` plugin loads in cloud sessions (then the plugin carries the agents).
- Next audit targets: `cpo` (first app-repo run with the library attached), `cody` (first dispatch without a local copy).

## 2026-10-13 — library — portfolio (`cos` and `mc-orchestrator` agents become skills; CI flags conductors)
- Decision: convert both agents to skills of the same name, archive the agents unmodified (`.claude/skills/_retired/cos/`, `.claude/skills/_retired/mc-orchestrator/`). Owner-approved second PR of the `cpo` redesign. Every conductor in the library is now a skill.
- Evidence (delegated): a dispatched agent never holds `Agent` (live test, same day). Blind routing gate 8/8. Sample: `work-samples/cos-mc-orchestrator-skills-2026-10-13.md`.
- Guard: `check-frontmatter.sh` flags `AGENT-TOOL` for any agent listing `Agent` or `Task`. Proven on planted fixtures; runs in CI.
- Gate fixes: `mc-orchestrator` adds `security-auditor` for auth, payments or member data; its trigger no longer collides with `multi-actor-research`; `cos` routes product decisions to `multi-actor-strategy` and `product-requirement-document`.
- Rejected: renaming `mc-orchestrator` to a new skill name. The old name keeps "run the coding playbook" and every pointer working.
- Reverses if: a harness grants dispatched subagents the `Agent` tool, or a conductor needs its own isolated context more than it needs to dispatch.
- Open: `balancetri-app` still holds synced `CPO.md`, `cos.md`, `mc-orchestrator.md`; the sync script never deletes. Account-synced copies need the same clean-up in claude.ai settings.
- Next audit targets: `etf-investing-advisor` + `etf-investing-coach` (shared triggers), `cos` (first brief as a skill), `high-output-management` ("where should I spend my time" overlaps `cos`).

## 2026-10-13 — library — portfolio (CPO agent and prompt-refiner retired into the `cpo` skill)
- Decision: retire the `CPO` agent and the `prompt-refiner` skill; the `cpo` skill is the one front door (frame → route → do → review). `/rewrite` launches it. Approved by the owner, gated on two tests.
- Evidence (all delegated, none embodied): a dispatched `CPO` reported no `Agent` tool although `CPO.md:5` listed it. Blind routing test went from 6/8 to 8/8. Blind intake comparison: new `cpo` 86/90, old `cpo` 73, `prompt-refiner` 46; the new system is never worse in any cell. Sample: `work-samples/cpo-redesign-2026-10-13.md`.
- Rule adopted: conductors are skills, executors are agents.
- Rejected: keeping `prompt-refiner` as intake only. It duplicated `cpo`'s framing and routing and scored lower on both.
- Archived unmodified: `.claude/skills/_retired/CPO/CPO.md`, `.claude/skills/_retired/prompt-refiner/`. History stays in this ledger; the skill carries rules only (7,871 words → 861 plus three on-demand references).
- Reverses if: two runs in a month need a dispatched router, or the routing test drops below 8/8 after an edit.
- Open: `cos` and `mc-orchestrator` list `Agent` but cannot use it when dispatched (second PR, approved). `balancetri-app` still holds a synced `CPO.md`; the sync script never deletes, so remove it by hand. Account-synced copies of `prompt-refiner` need removing in claude.ai settings.
- Next audit targets: `cpo` (first real multi-agent run under the new close-out), `cos` (same conversion), `watchdog` (now the default reviewer for member-facing work).

## 2026-10-13 — cody (Balance Bolt hand-set waves; REDUCED INDEPENDENCE — embodied by CPO)
- Verdict: Built, tested and committed locally (`BalanceBolt@f1076d5`, not pushed). The riskiest defect, deploy order, surfaced only at review.
- Scores: Mandate Strong · Triggers Strong · Tools Strong · Model Adequate · Instructions Adequate · Observed Strong · Boundary Strong.
- Why: The change spans two halves that deploy separately: GitHub Pages on merge, and Apps Script pasted in by hand. Nothing in `cody.md` asks the builder to state the deploy order, or to check what the new front end does against the old backend. Shipped front-first, a move is silently reverted by the next poll. The suite never loads `apps-script.gs`, so the backend was only executed at the verifier stage. Earlier today's search-before-writing fix held: existing helpers, `.timing-edit` and `.status-tag` were reused, and no CSS was copied.
- Changed: applied 2026-10-13 with the owner's yes (High). A step-1 rule: when a change spans separately deployed halves, state the deploy order, test the new half against the old one, and execute any half the suite does not load.
- Expected effect: deploy-order risk is named in cody's own summary, not found downstream.
- Follow-up: an independent pass when dispatch is reachable. Dispatch probe: resolved-negative. No Notion tool. Sample: `work-samples/cody-2026-10-13-pass2.md`.

## 2026-10-13 — cody (BalanceTRI-app feedback form; REDUCED INDEPENDENCE — embodied by CPO)
- Verdict: Shipped working, tested code; three duplications and one guessed figure were found only after they were written.
- Scores: Mandate Strong · Triggers Strong · Tools Strong · Model Adequate · Instructions Strong · Observed Adequate · Boundary Strong.
- Why: Step 1's "search before you write a helper" covers functions that "format, label, derive or validate". It did not catch a re-implemented `setBusy` (`app.js:534`), and CSS is outside its wording, so `.auth-field` input rules and `.race-loading-eyebrow` were copied, not reused. A self-review and a watchdog pass caught all three. Separately, contrast figures went into a CSS comment before they were computed (6.1 → 5.86), against step 2's "a ratio you did not compute is an opinion".
- Changed: Medium applied on the user's say-so (2026-10-13): step 1's search rule now covers any helper, component or CSS rule, and tells cody to grep for the declarations, not the class name. Not applied (Low): "write measured figures only after running the computation".
- Expected effect: the next UI build reuses existing rules at write time, and self-review finds nothing to dedupe.
- Follow-up: an independent `agent-improver` pass when dispatch is reachable. Dispatch probe: resolved-negative (no Agent/Task tool). No Notion tool in session. Sample: `work-samples/cody-2026-10-13.md`.

## 2026-10-09 — idea-challenger (intake mode: Impact-Effort grade and quick-win step)
- Verdict: **extended, not reviewed.** No `agent-improver` pass and no real run behind the new mode yet.
- Changed: `idea-challenger.md` gains an intake mode. It scores a newly proposed idea 1–5 on Impact (demand evidence, income, career lift, compounding) and Effort (hours, dependencies, unknowns), names the quadrant, and writes one "When X, I will Y" quick-win step. `references/agent-workflow.md` gains the matching table row and an "Intake" section. The description grew from 665 to 795 characters.
- Why: the owner wanted a fast triage for new ideas outside a full run. The agent only stress-tested ideas already ranked.
- Guards: Stage 6 stays blind. Intake grades never reach a Stage 6 dispatch, the Stage 5 score or `check_brief.py`. Demand evidence caps at 2 when only Asserted. Effort runs 5 = heavy, the opposite of Stage 5, so the output labels it.
- Expected effect: a new idea gets a quadrant and a next step in one dispatch. Check on the first real use: does the step fit under two hours and read a signal?
- Follow-up: not synced to the four consuming repos (`scripts/sync-agents.sh`). `research-to-ideas-map.html` and `SKILL.md` do not mention intake mode. Next audit targets: `idea-challenger` (first intake run), `cluster-analyst` (depth gain untested), `source-scout` (parallelism is its only edge).

## 2026-10-03 — library — portfolio (agent roster synced into the four consuming repos)
- Verdict: **closed.** The follow-up open since 2026-09-11 ("sync the roster into the four repos (needs write access, not done)", `changelog/2026-09-1.md`) is done.
- Changed: ran `scripts/sync-agents.sh` against BalanceTRI-app, tri-momentum, CLACFridays and BalanceBolt, at library `47bd084`. Each repo received the same change: six agents added (`cluster-analyst`, `evidence-auditor`, `idea-challenger`, `source-scout`, `strategy-challenger`, `strategy-juror`), nine agents and two references updated, and `mc-implementer` removed by hand. Pushed to each repo's `main`: `cbb8a8e`, `56c40ba`, `67445c3`, `0606160`.
- Why: agents are not account-synced. Until today these repos held a snapshot older than both pipelines. `research-to-ideas` and `multi-actor-strategy` ran there with no agents behind them. `mc-implementer`, retired 2026-09-29, was still there, so `mc-orchestrator` could dispatch it. The sync script never deletes, which is why it needed removing by hand.
- Skipped: `jthoyer/research-to-ideas` is an empty repo with no branch, so not a consumer. `jthoyer/agents` is archived.
- Expected effect: in those repos, CPO can route to the research and strategy lanes, and the blind agents dispatch. Check by listing `.claude/agents/` in any of the four: 21 files, no `mc-implementer.md`.
- Ledger: September rolled out on 2026-10-03. At 75 KB it was past a single read, so it is split by fortnight into `changelog/2026-09-1.md` (1–15) and `changelog/2026-09-2.md` (16–30), verbatim. The index above was recounted from headings. Its old September counts had drifted (CPO said ×10, 13 headings name it), so treat earlier counts as approximate.
- Follow-up: the sync is still manual. It goes stale on the next agent change unless someone reruns the script. Worth making it part of the close-out after any agent edit.

