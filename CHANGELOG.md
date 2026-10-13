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
| `CPO` | `changelog/2026-09-2.md`×4, `changelog/2026-09-1.md`×9 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×4 |
| `agent-improver` | `changelog/2026-09-1.md`×4 | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md`×5 |
| `code-improver` | `changelog/2026-09-1.md`×2 | `CHANGELOG-ARCHIVE.md`×4 |
| `cluster-analyst` | `changelog/2026-09-2.md`×2 | — |
| `cody` | `CHANGELOG.md`, `changelog/2026-09-2.md`×2, `changelog/2026-09-1.md`×2 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×8 |
| `cos` | `changelog/2026-09-2.md`, `changelog/2026-09-1.md`×2 | — |
| `evidence-auditor` | `changelog/2026-09-2.md`×2 | — |
| `idea-challenger` | `CHANGELOG.md`, `changelog/2026-09-2.md`×2 | — |
| `investigator` | `changelog/2026-09-2.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `mc-implementer` (retired 2026-09-29, `.claude/skills/_retired/mc-implementer/`) | `changelog/2026-09-2.md` | `changelog/2026-08.md`×2 |
| `mc-integrator` | `changelog/2026-09-2.md`, `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `mc-orchestrator` | `changelog/2026-09-2.md`, `changelog/2026-09-1.md` | `changelog/2026-08.md`×2, `CHANGELOG-ARCHIVE.md`×5 |
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

## 2026-10-13 — cody (BalanceTRI-app feedback form; REDUCED INDEPENDENCE — embodied by CPO)
- Verdict: Shipped working, tested code; three duplications and one guessed figure were found only after they were written.
- Scores: Mandate Strong · Triggers Strong · Tools Strong · Model Adequate · Instructions Strong · Observed Adequate · Boundary Strong.
- Why: Step 1's "search before you write a helper" covers functions that "format, label, derive or validate". It did not catch a re-implemented `setBusy` (`app.js:534`), and CSS is outside its wording, so `.auth-field` input rules and `.race-loading-eyebrow` were copied, not reused. A self-review and a watchdog pass caught all three. Separately, contrast figures went into a CSS comment before they were computed (6.1 → 5.86), against step 2's "a ratio you did not compute is an opinion".
- Changed: no edits. Proposed (Medium): extend step 1's search rule to say "any helper, component or CSS rule block — grep for an existing rule with the same declarations before adding one". (Low): "write measured figures only after running the computation".
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

