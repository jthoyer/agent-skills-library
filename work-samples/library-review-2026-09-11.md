# Full agent review — 2026-09-11

**Reviewer:** CPO, **embodied** (see Independence). **Scope:** all 16 agents in `.claude/agents/`.
**Evidence base:** this week's session index (titles/dates/repos/status only, 26 sessions,
Mon 2026-09-07 – Fri 2026-09-11); `CHANGELOG.md` + `CHANGELOG-ARCHIVE.md`; `10X-LOG.md`;
`work-samples/` (4 files); `git log`; the agent files themselves.

## Independence — read this before any verdict below

**Dispatch probe: resolved negative.** This session's tool list contains no `Agent`/`Task`
function, although `CPO.md` frontmatter declares `Agent`. Per `CPO.md` step 0(a) that is a
*resolved* negative, not an unresolved probe. Consequences, stated plainly:

- Every role in this document was **embodied by CPO**, not delegated. Nothing here is an
  independent review. `agent-improver`'s own Inputs-4 rule applies: **REDUCED INDEPENDENCE**.
- A follow-up independent pass is owed on every verdict that recommends a change.
- **Frontmatter declaring `Agent` is not evidence the tool is granted.** Reachability has now
  been observed both ways within eight days — positive on 2026-09-04/05/06 (three genuine cold
  dispatches, one of which produced the `cos` work sample), negative today. Neither observation
  generalises. Do not restate this as settled in either direction.

## What this evidence base cannot support

The session index is titles, dates, repos and status. It records **no agent or skill invocation
and no quality signal**. So this review makes **no claim about how any agent performed this
week**. Where a verdict cites performance it cites the ledger, a work sample, or the file on
disk, and says which. Where the honest answer is "unknown", it says unknown — that is most of
the roster, and that fact is itself the headline finding.

---

## Part 1 — Per-agent verdicts (all 16)

Ranked by what the evidence actually supports. "Reviews" counts ledger headings naming the agent
across `CHANGELOG.md` + `CHANGELOG-ARCHIVE.md`.

| # | Agent | Reviews | Work sample ever | Verdict |
|---|---|---|---|---|
| 1 | `ux-designer` | **0** | **No** | **Trial — review now, first in queue** |
| 2 | `mc-integrator` | 2 (oldest: 2026-08-17) | No | Improve — stalest review in the library |
| 3 | `investigator` | 2, both definition-only | No | Improve — wire to `review-gates` |
| 4 | `mc-orchestrator` | 7 | Partial (one 2-of-4 register) | Keep — but measurement debt is now overdue |
| 5 | `watchdog` | 6 | No | **Improved this run** (dead path fixed) |
| 6 | `release-engineer` | 3, definition-only | No | Keep — untested branch is the whole agent |
| 7 | `mc-implementer` | 2 (2026-08-17) | No | Keep — low risk, low urgency |
| 8 | `cos` | 1 | Yes (2026-09-05) | Keep — finish the CPO boundary on cos's side |
| 9 | `cody` | 13 | Yes (2026-08-31 ×2) | Keep — description now undersells the agent |
| 10 | `CPO` | 11 | Yes (2026-09-04) | **Improved this run** (paths, body sweep) |
| 11 | `agent-improver` | 8 | No | **Improved this run** (queue handshake) |
| 12 | `mc-reviewer` | 7 | No | Keep as is — reviewed 2026-09-06 |
| 13 | `security-auditor` | 4 | No | Keep as is — reviewed 2026-09-06 |
| 14 | `code-improver` | 6 | Yes (graded 2026-09-06) | Keep as is — trial closed, KEPT |
| 15 | `mc-planner` | 7 | No | Keep as is |
| 16 | `mc-verifier` | 4 | No | Keep as is — reviewed 2026-09-05 |

**No agent is recommended for retirement or merger on this week's evidence.** See Part 3 for why
the one standing retirement question (`mc-*`) is deliberately not answered today.

### The four that need something

**1. `ux-designer` — the library's only never-reviewed agent, and the one the week most needed.**
Added 2026-09-01. Zero ledger entries (its single `CHANGELOG` mention is the portfolio entry that
*created* it, not a review). Zero work samples. Its own step 8 asks callers to flag reworked mocks
for `agent-improver` — a feedback channel that has never carried anything.

The week's largest work class by title was UI/visual direction: `Week number design options`,
`Race schedule design`, `Week blocks layout improvements`, `Week/day width and scroll focus`
(tri-momentum), `Filter layout repositioning`, `Race to club-focused race design`,
`Event type dropdown and filtering` (BalanceTRI-app) — seven sessions. "Design options" is this
agent's literal trigger phrase.

**I cannot tell from titles whether it ran.** That is the finding. Either it ran seven times and
produced nothing gradeable, or it ran zero times and the work went straight to implementation —
and the library has no way to tell those apart. The queue has named it first target in three
consecutive portfolio entries (`CHANGELOG.md:116`, `:162`, and carried forward) since 2026-09-05
and it is still unreviewed six days later.

*Action:* not a definition edit. **Capture one real work sample**, then review against it. Until
then its whole 3-options-then-polish premise is untested. Definition reads well; that is not
evidence.

**2. `mc-integrator` — 25 days since last review, the stalest in the roster.**
Last reviewed 2026-08-17 (`FIRST INDEPENDENT REVIEW`). Never had a work sample. Fixed this run:
the file ended in a bare six-column table header with no rows and no caption — now labelled as
the decision-log shape with an explicit "say *no impasses reached* rather than returning an empty
table". Otherwise sound; its Stage-4 grade-gating language is the sharpest in the pipeline.

**3. `investigator` — behavioural content, no runs, and outside the shared evidence gate.**
Two entries, both definition-only, both from the 2026-08-18 three-new-agents batch. 35 lines, the
shortest non-trivial agent. It is a read-only, confidence-disciplined review-class role with an
Iron Law and a 3-hypothesis stop — but it is **not** wired to `~/.claude/references/review-gates.md`,
which `code-improver`, `mc-reviewer`, `security-auditor` and `watchdog` all are. Its §1 pre-report
gate applies directly to a root-cause claim.

*Proposed (not applied — adds a dependency, wants sign-off):* add the `review-gates` read to
Behaviours to adopt, scoped to §1 and §3 only, matching `watchdog`'s partial-applicability pattern.

**4. `mc-orchestrator` — the 2026-09-07 fix is still unverified, and the clock is now running.**
The newest ledger entry says: *"Expected: next `mc-orchestrator` run flags `/compact` after a
register write. Absent ⇒ decorative."* Four days on there is no such run. Worse, the file itself
(line 65) records that the only register ever persisted from a real run holds Stage 1 and the
Reviewer's Stage 3a — **the full four-stage pipeline has never produced a complete artefact**.

*Action:* set a decision date rather than drifting. See Part 3.

### The three improved this run

- **`watchdog`** — step 5 told it to `Read` `~/.claude/agents/CHANGELOG.md` to check whether a
  finding was already tracked. That path **does not exist**; `CPO.md` has documented it as a trap
  since 2026-09-05 and `watchdog` carried it anyway. A dead path in an instruction fails silently
  and *inverts the result*: the agent reads nothing and concludes the finding is new. Fixed to
  `<library-root>/CHANGELOG.md`, with the skills ledger named as the separate second ledger.
- **`CPO`** — eight hardcoded `/Users/justinhoyer/...` paths, none of which resolve in this
  environment. I hit this myself: the file's own "canonical paths" block was wrong for the machine
  it was running on. Replaced with a resolved `<library-root>`, plus the macOS-vs-cloud difference
  stated explicitly. Also added a **body-integrity sweep** to step 2 (below).
- **`agent-improver`** — library-audit step 3 selected targets by gap size with no knowledge that
  a queue exists. `Next audit targets` appeared in `CPO.md` **only**; the handshake was one-sided,
  which is exactly why `ux-designer` was named three times and reviewed zero. Step 3 now greps the
  ledger for the most recent queue line and must state which targets it dropped.

### The nine held as is
`cody`, `code-improver`, `cos`, `mc-implementer`, `mc-planner`, `mc-reviewer`, `mc-verifier`,
`release-engineer`, `security-auditor`. All have a current-enough review or a recently-closed
trial. Two carry small, noted-not-fixed items:
- **`cos`** — the CPO/`cos` collision found 2026-09-05 was fixed on CPO's side only.
  `cos.md:3` still reads "what should I work on" with no boundary clause, while `CPO.md`
  carries the full disambiguation. Routers read descriptions. *Proposed, not applied:* one clause
  in `cos.md`'s description. Held back because it changes routing behaviour and I am
  reduced-independence.
- **`cody`** — 107 lines of hard-won discipline behind a 287-character description that says only
  "implements coding tasks". Nothing in it signals the mandatory four steps, the constraint-assertion
  rule, or the `ux-designer` boundary (which `ux-designer` states from its side but `cody` does not).
  There is 737 characters of headroom under the cap. *Proposed, not applied:* same reason.

---

## Part 2 — Portfolio findings

### F1. The binding constraint is distribution, not composition *(highest)*

22 of 26 sessions this week ran in five repos that are **not** this one: BalanceTRI-app (8),
tri-momentum (5), CLACFridays (4), BalanceBolt (2), personal (2). Only 4 touched the library.

This repo's own git history states the mechanism: commit `502a5df` (2026-09-10) adds
`scripts/sync-agents.sh`, whose header reads *"Agents aren't account-synced like skills, so
consuming repos hold a snapshot that needs re-syncing by hand after changes here."*

So: **skills are available everywhere; agents are only present in a repo someone hand-copied them
into**, and the tool that makes that copy one command was written on Thursday — after 21 of the
week's 26 sessions had already run. Every agent edit made between 2026-08-15 and 2026-09-10 reached
consuming repos only if someone copied it by hand.

I cannot verify the five consuming repos' state from here — they are not on this box — so I cannot
say the agents were absent. What I can say is that **no mechanism existed to keep them current**,
and that this, not roster composition, is the first thing to check before concluding any agent
"didn't earn its keep" this week. An agent that was never present cannot have been chosen against.

*This reframes the fit question the brief asked.* Structural unreachability is the likely
explanation for the whole roster's missing evidence, and it is testable in minutes.

### F2. Short-form product copy is the gap that got filled by nothing

Six sessions were copy: `App description and website link` ×4 (one per app repo, all on 2026-09-10),
`Empty races message copy`, `Balance bolt event description`. Roughly a quarter of the week.

Nothing in the roster claims that trigger.
- No **agent** does copy at all.
- `content-writing` was **retired 2026-09-06** on blind-gauntlet evidence, superseded by
  `content-research-writer`.
- `content-research-writer`'s own description scopes it to *"any request to produce written content
  **longer than a few paragraphs**"* — which excludes an app-store description and an empty-state
  message by construction.
- The retirement note's stated **reversal condition** is: *"Restore if `content-research-writer`
  proves worse at **short-form work (social posts, subject lines)** … or if its research/citation
  layer gets in the way of a quick draft."*

The week supplied six natural tests of that exact condition and captured no evidence either way.
This is not a claim that anything performed badly — it is a claim that a **pending, written-down
reversal test went unrun while its trigger fired six times**.

*Recommendation:* not a new agent. A short-form-copy **skill**, or an explicit short-form section
in `content-research-writer`, decided after one deliberate comparison. Copy is voice-and-format
work loaded into the current turn — the exact thing `CPO.md` says should be a skill, not an agent.

Second-order: the same task titled identically across four repos on one day is four cold starts at
the same problem. Whatever the answer is, it should end up written down once.

### F3. Duplication — real, but of the prose kind, and the fix already exists

Embodied `watchdog` sweep across all 16 files. **No two agents do the same job**; every adjacent
pair carries an explicit boundary (`code-improver`↔`mc-reviewer`↔`watchdog`; `cody`↔`ux-designer`;
`investigator`↔`mc-reviewer`↔`mc-verifier`; `security-auditor`↔the `security-review` skill;
`Plan`↔`mc-planner` on persistence). **No merge or retirement is warranted on overlap.**

What *is* duplicated is prose, in three clusters:

| Discipline | Written out in full in | Cost |
|---|---|---|
| "harness defect vs product defect" | `cody`, `mc-implementer`, `investigator` | 3 copies drift independently |
| "a newly-written suite must be proven to fail" | `cody`, `mc-verifier`, `mc-orchestrator` | 3 copies; the `MAX_WAVES` anecdote is already abridged differently in each |
| "search for an existing helper before writing one" | `cody`, `mc-implementer` | 2 copies |

The library already solved this on 2026-09-06 with `.claude/references/` — and solved it correctly
once more elsewhere: `cody.md` handles the Google-Drive/mmap pattern by **pointing at**
`release-engineer.md` rather than copying it. That is the pattern to apply.

*Proposed, not applied:* one new `~/.claude/references/verification-discipline.md` holding all
three, with the five agents pointing at it. **Not applied** because it touches five definitions at
once and `CPO.md` is explicit that collapsing shared prose is a documentation fix needing care —
and because I am reduced-independence. It is a clean, cheap, separately-reviewable change.

### F4. Three registers, no readers — and one of them just got a reader

A repeating structural failure, now on its third instance:

1. **`10X-LOG.md` had no consumer** — diagnosed 2026-08-31. Its best idea (the extended frontmatter
   grep) sat unapplied 18 days. Fixed 2026-09-05 by routing entries to the Notion backlog.
   **Status: fixed, and the grep has landed** — `CPO.md` step 2 now carries the full
   `name:`/`tools:`/`model:`/desc-length/filename sweep. Verified on disk this run. It ran clean on
   all 16 agents today, which is itself the proof it works.
2. **The improvement queue had no consumer** — found today. `Next audit targets:` existed only in
   `CPO.md`. **Status: fixed this run** in `agent-improver.md` step 3.
3. **The agent definitions have no consumer in 22 of 26 sessions** — F1. **Status: open.**

Same shape every time: a register is written faithfully, nothing is instructed to read it, and the
gap is invisible because the writing half keeps happening.

### F5. Reviews read prose and skip mechanics

Today's frontmatter sweep came back **clean on all 16 agents** — no name/filename divergence, no
description over 1,024 chars (`security-auditor` is 855, down from the 1,129 fixed on 2026-09-05),
every agent has an explicit model tier. Good.

Both real defects were **below** the frontmatter:
- Six of six `mc-*` files ended with a stray `</content>` tag. Introduced by `41ab577` (2026-09-02).
  Survived **four** later commits that edited those very files (`1842351`, `97b3a8e`, `ddc2641`,
  and the 09-05 fix pass) and at least two `agent-improver` reviews (`mc-verifier` 09-05,
  `mc-reviewer` 09-06). Nine days.
- `watchdog.md:30`'s dead ledger path — documented as a trap in `CPO.md` and shipped anyway.

Neither is subtle. Both are invisible to a reader checking whether the *reasoning* is sound, which
is what a review actually does. *Applied this run:* `CPO.md` step 2 now sweeps trailing artefacts
and resolves every `~/.claude/...` path against disk, alongside the frontmatter check.

### F6. `CHANGELOG.md` is inside its own measured danger band

`wc -c` = **68,224 bytes**, 256 lines. The ledger's own header records the cliff as between
**67,450 B (read clean)** and **71,246 B (truncated at line 214 of 258)**, with ~60 KB named as the
safety margin. It is 774 B past the last known-clean measurement and ~3 KB below known failure.

Per `agent-improver.md`'s standing instruction a retention sweep is **proposed, not done unasked**.
Flagging it as the top mechanical next action — a truncating ledger silently breaks library-audit
steps 1 and 2, which is the failure this whole review depends on not having.

### F7. Skills — no full audit run, and one is not needed yet

Per the brief I checked only agent↔skill overlap and contradiction, across 48 live skills.
- **No contradiction found.** Every skill an agent names resolves on disk: `first-principles`,
  `issue-tree`, `red-team`, `multi-actor-research`, `multi-actor-strategy`, `scr-pyramid-communicator`,
  `scqa-framework`, `skills-librarian`, `prompt-refiner`, `product-requirement-document`,
  `justin-voice`, `humanizer`. 12 of 12.
- **One overlap, correctly handled:** `security-auditor` vs the built-in `security-review` skill —
  both files state the boundary (inline pass vs dedicated dispatch).
- **One overlap, newly open:** `content-research-writer` vs nothing, at the short-form end — F2.

**A full 48-skill audit is not warranted this run.** The skills library has its own ledger
(`.claude/skills/CHANGELOG.md`), its own owner (`skills-librarian`), and a substantive audit on
2026-09-06. Re-auditing it from CPO would duplicate that owner's job — the exact boundary error
this review is meant to catch elsewhere.

---

## Part 3 — The `mc-*` question, deliberately left open

Six of 16 agents are the coding pipeline. The standing argument for retiring some of it
(`10X-LOG.md`, 2026-08-16) is that split actors pay maintenance for an independence they cannot
deliver if dispatch is unreachable. Today's probe is negative, which superficially strengthens it.

**I am not acting on that, and the reason matters.** Dispatch was observed *working* on
2026-09-04/05/06 and *absent* on 2026-08-16, 2026-08-18 and today. Retiring five files on the basis
of whichever environment this week's review happened to run in is precisely the "stamped
observation ages into a lie" error `CPO.md` warns against. The `mc-*` five survived the 2026-08-18
cull on restricted tool sets that are load-bearing (`mc-reviewer` cannot execute; `mc-verifier`
cannot Edit) plus real caught-defect evidence, and none of that has been falsified.

What *has* accumulated is measurement debt: no complete four-stage register exists, ever, and the
2026-09-07 hygiene fix is unverified.

*Proposed decision rule, for sign-off:* if by **2026-10-01** no `mc-orchestrator` run has persisted
a complete four-stage register, that is three consecutive weeks with the pipeline's central claim
unevidenced, and the composition question gets answered on that — not on a dispatch probe.

---

## Part 4 — Ranked next actions

| # | Action | Owner | Why now |
|---|---|---|---|
| 1 | Run `scripts/sync-agents.sh` against all five consuming repos; confirm what was actually there first | user | F1 — decides whether any other item matters |
| 2 | Retention sweep on `CHANGELOG.md` (68,224 B, in the cliff band) | `agent-improver`, on sign-off | F6 — a truncating ledger breaks audit steps 1–2 |
| 3 | Capture one `ux-designer` work sample, then review it | CPO → `agent-improver` | Only never-reviewed agent; queued 3× and skipped 3× |
| 4 | Decide short-form copy: extend `content-research-writer`, or new skill | CPO + `skills-librarian` | F2 — ~25% of the week, nothing claims it |
| 5 | Review `mc-integrator` (25 days) and `investigator` (definition-only) | `agent-improver` | Staleness, now that the queue is actually read |
| 6 | Extract `verification-discipline.md`; point 5 agents at it | on sign-off | F3 — three clusters drifting |
| 7 | Boundary clauses: `cos.md:3` (vs CPO), `cody` description (vs `ux-designer`) | on sign-off | Both half-fixed; routers read descriptions |
| 8 | Independent re-run of this review when dispatch is reachable | `agent-improver` | Everything here is reduced-independence |

**Next audit targets: `ux-designer`** — only never-reviewed agent, queued three times since
2026-09-05 and skipped three times; needs a captured work sample before the review, not another
definition-only pass. **`mc-integrator`** — 25 days stale, the oldest in the roster, never had a
work sample, and its one artefact defect was found mechanically today rather than by review.
**`investigator`** — two definition-only entries, behavioural content with no run behind it, and
the only read-only review-class agent not wired to `review-gates.md`.
