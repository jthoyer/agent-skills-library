# Agents CHANGELOG

The improvement ledger for this agent library. Every review by `agent-improver` inserts a dated entry at the top, under the `New entries below this line` marker. The goal: agents that are measurably better in three months than they are today.

**How to read this:** each entry records what changed, why, and how you'd know it worked. Before re-reviewing an agent, read its most recent entry and check whether the last fix actually helped. The index below says where that entry is.

**Entry format:**

```
## YYYY-MM-DD — <agent name>
- Verdict: <one line>
- Scores: Mandate · Triggers · Tools · Model · Instructions · Observed · Boundary (Strong / Adequate / Weak each)
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
| `CPO` (retired 2026-10-13 → `cpo` skill) | `changelog/2026-10.md`×3, `changelog/2026-09-2.md`×4, `changelog/2026-09-1.md`×9 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×4 |
| `agent-improver` | `changelog/2026-09-1.md`×4 | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md`×5 |
| `code-improver` | `changelog/2026-09-1.md`×2 | `CHANGELOG-ARCHIVE.md`×4 |
| `cluster-analyst` | `changelog/2026-09-2.md`×2 | — |
| `cody` | `changelog/2026-10.md`×7, `changelog/2026-09-2.md`×2, `changelog/2026-09-1.md`×2 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×8 |
| `cos` (agent retired 2026-10-13 → `cos` skill) | `changelog/2026-10.md`, `changelog/2026-09-2.md`, `changelog/2026-09-1.md`×2 | — |
| `evidence-auditor` | `changelog/2026-09-2.md`×2 | — |
| `idea-challenger` | `changelog/2026-10.md`, `changelog/2026-09-2.md`×2 | — |
| `investigator` | `changelog/2026-09-2.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `mc-implementer` (retired 2026-09-29, `.claude/skills/_retired/mc-implementer/`) | `changelog/2026-09-2.md` | `changelog/2026-08.md`×2 |
| `mc-integrator` | `changelog/2026-10.md`, `changelog/2026-09-2.md`, `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `mc-orchestrator` (agent retired 2026-10-13 → skill) | `changelog/2026-10.md`×3, `changelog/2026-09-2.md`, `changelog/2026-09-1.md` | `changelog/2026-08.md`×2, `CHANGELOG-ARCHIVE.md`×5 |
| `mc-planner` | `changelog/2026-10.md`×2, `changelog/2026-08.md`×2 | `CHANGELOG-ARCHIVE.md`×5 |
| `mc-reviewer` | `changelog/2026-10.md`×3, `changelog/2026-09-1.md` | `changelog/2026-08.md`×2, `CHANGELOG-ARCHIVE.md`×4 |
| `mc-verifier` | `changelog/2026-10.md`×2, `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md`×2 |
| `release-engineer` | `changelog/2026-09-1.md` | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `security-auditor` | `changelog/2026-10.md`, `changelog/2026-09-1.md`×3 | `changelog/2026-08.md`, `CHANGELOG-ARCHIVE.md` |
| `source-scout` | `changelog/2026-09-2.md`×2 | — |
| `strategy-challenger` | `changelog/2026-09-2.md`×2 | — |
| `strategy-juror` | `changelog/2026-09-2.md`×2 | — |
| `ux-designer` | `changelog/2026-10.md`×4 | `CHANGELOG-ARCHIVE.md` |
| `watchdog` | `changelog/2026-10.md`×3, `changelog/2026-09-1.md`×2 | `changelog/2026-08.md`×3, `CHANGELOG-ARCHIVE.md`×3 |

---

<!-- New entries below this line, newest first -->

## 2026-11-02 — library — ledger: October rolled out
- Changed: all 34 October entries (2026-10-03 to 2026-10-30) moved verbatim to `changelog/2026-10.md`. At 54 KB the month fits a single read, so it is not split. Checked byte for byte against the previous commit; the only difference is one trailing blank line.
- Index: "Where each agent's history lives" recounted from October's headings. It had drifted during October. Seven agents had October entries the table didn't show: `CPO`, `cos`, `mc-integrator`, `mc-orchestrator`, `mc-verifier`, `security-auditor`, and `cody` (×7, not ×1). Four counts were off: `mc-planner` ×2, `mc-reviewer` ×3, `ux-designer` ×4, `watchdog` ×3.
- Follow-up: nothing updates the index when an entry is written. Recount it at each month's roll-out.
- Next audit targets: unchanged, see `changelog/2026-10.md` (latest: `ux-designer`, `cody`).

## 2026-11-02 — library — portfolio: `interview-coach` admitted
- Decision (reduced independence: the cpo skill wrote the fixture, key and grader brief): add `interview-coach` (noamseg/interview-coach-skill at `634a8dd`, MIT). The owner asked for it via `/rewrite` and chose "run the test, add only if it passes".
- Evidence: admission test `work-samples/admission-interview-coach-2026-11-02/`. Transcript analysis, skill against no skill, two runs each, sealed key, blind dispatched grader. Skill 10/10 twice, no skill 8/10 twice. The grader ranked both skill runs first and second. The skill won on linking two answers to one root cause and on naming one first move.
- Who produced it: four `general-purpose` arms and one `general-purpose` grader, all delegated. The key was sealed first; the grader brief was written after the outputs (disclosed in the sample README). `watchdog` reviewed the PR: five should-fix findings, all fixed.
- Rejected: testing only the core and dropping the `resume`, `linkedin` and `pitch` commands (the owner chose the whole skill). Using it outside the library.
- Adapted: description with boundaries; resume work routes to `resume-builder` unless typed; personal files (`coaching_state.md`, `job-search/`, `materials/`) never live in a repo and are gitignored; contents lists.
- Reverses if: an owner-written test of another command (`mock` or `stories`) finds no skill does as well, or it takes a standalone resume request from `resume-builder`.
- Follow-up: owner fixture for `mock`; upload the zip to claude.ai.
- Next audit targets: `interview-coach` (owner-written `mock` test), `resume-builder` (overlap with `interview-coach resume`), plus the queue above.
