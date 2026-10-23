# Review: rajann44/pm-skills `product-management` against this library (2026-10-23)

Evidence for the `CHANGELOG.md` entry of the same date. Backlog row: ASL-067.

## The brief (owner, verbatim)

> run https://app.notion.com/p/jthoyer/product-management-skill-Full-review-of-rajann44-pm-skills-and-gap-list-against-my-agents-and-skill-401cfee1ca188115bcf9c8ecfcabe174 — based on this weeks work - run full audit

The Notion page (ASL-067) asks: review the skill in full; list the gaps and improvements it shows
in my agents and skills; give each one a verdict of **build new**, **integrate** or **leave**, with
the file it touches and what would reverse it. Done when the review is in `work-samples/`, each
gap is a backlog row, `CHANGELOG.md` records it, and `watchdog` has checked it for overlap.

"Based on this week's work" is read as: judge every gap against the library as it stands after
the merges of 16–23 October, not as it stood when the row was filed.

## Source read

- Repo: `github.com/rajann44/pm-skills`, commit `06bdc38` (2026-07-18), v1.1.0, MIT. Cloned
  read-only. The 2026-10-22 attempt failed: skills.sh is blocked by the proxy (still 403 today),
  and `add_repo` was denied. Today the git proxy served an anonymous clone.
- Read in full: `product-management/SKILL.md` (154 lines) and all nine references: strategy,
  discovery, execution, metrics-growth, conflicts, decisions-retro, artifacts-templates,
  limitations, glossary (headings only; it restates the others). Also read: `README.md`,
  `validation/audit-report.md`, the headings of `validation/gap-log.md` and `v2-backlog.md`.

**What it is.** One umbrella skill for B2B SaaS product managers. A router sends each task to a
reference file. Its spine is a **Context Gate**: before a PRD, roadmap or priority list it must
know the customer, the strategy and the time budget, and it scales the evidence it demands to the
size of the bet (5+ interviews for a 6-week build). Without evidence it pushes back with kill
criteria and a 10-line draft. Every kill threshold must state its anchor or be labelled an
assumption. It writes every final decision to `product/decisions.md` with a prediction and a
confidence, and a retro later scores them (no statistics under 10 resolved). Its frameworks are
Cagan, Torres, Singer (Shape Up), Biddle (DHM, GEM, GLEe), Fitzpatrick (Mom Test) and
Rachitsky. It was validated on 13 scenarios with a typed gap log and before/after diffs.

## What this week's work changed

A week ago, most of the source's discovery spine would have been a **build new** gap. It is not
now:

- `discovery-loop` (added 2026-10-20) covers the Opportunity Solution Tree, the four risks,
  assumption mapping, fake doors, deposits, repeat-use tests (concierge, Wizard of Oz), and kill
  criteria set before a test runs (its Continue / Change / Stop ranges).
- `.claude/references/intent-audit.md` (2026-10-20) set the pattern of standing docs an app keeps
  and agents cite. Gap I4 reuses it for product outcomes.
- The PM 2.0 Library in Notion (checked 2026-10-20) is now the owner's study area. Framework
  knowledge with no recurring task belongs there, not in a skill (gap L2).
- `discovery-loop` has not had its first real run (queued 2026-10-20). I4 and I7 edit it, so they
  wait for that run, to keep its audit clean.

## Library skills checked first (the page's list)

| Skill or agent | What it already covers from the source | Gap found |
|---|---|---|
| `product-requirement-document` | Decision context; brief vs PRD vs spec table; discovery vs delivery PRD; Assumption test (`methods.md:31,49`); Confirmed/Inferred/Assumed (`failure-modes.md:59`); rollout and 30/60/90 measurement | I1, I6 |
| `discovery-loop` | OST, four risks, assumption map, fake door, deposit, repeat-use tests, pre-set kill ranges, loop log | I4, I7 |
| `customer-insight` | Past-behaviour timeline interviews; churn timelines; after-the-fact rationalising (`jtbd-deep.md:163,177`); VPC interview questions | I3 |
| `positioning` | Differentiation | none (L2) |
| `project-management` | Ritual stack, stakeholder and manager updates | none (L5, L8) |
| `business-case-builder` | One-page case, success metrics with targets and dates | none (L8) |
| `research-to-ideas` | Evidence grades (Tested to Asserted), ranked ideas, Stage 8 test | none (L4, L6) |
| `multi-actor-strategy` | Direction choice, Stakeholder Proxy, Conviction Bets | none (L2, L6, L9) |
| `mc-planner` | Testable spec, non-goals | none; I6 leaves it unchanged |

## Verdicts

No **build new**. Six **integrate**, eleven **leave**. Every integrate is a missing step in a
skill or agent that already owns the job. None is applied here; each waits for the owner's
go-ahead, as gaps #1 and #2 of the `phuryn/pm-skills` review did.

**One extension of the decision rule, flagged:** L2, L5, L6 and L10 are left because the job does
not recur, not because something duplicates them. The rule on ASL-067 has no slot for that. It
is the mirror of the "job recurs" test for **build new**. The owner may want to add it.

**Evidence words.** The library uses three scales: Confirmed / Inferred / Asserted
(`research-to-ideas`, `idea-challenger`, `multi-actor-research`), Confirmed / Inferred / Assumed
(`product-requirement-document/references/failure-modes.md:59`) and Supported / Reasoned /
Assumed (`multi-actor-strategy`, for recommendations, a different job). I1 and I3 add no new
scale: each uses the one its skill already has. Whether to rename the PRD skill's "Assumed" to
"Asserted" is the owner's call; the 2026-10-20 `discovery-loop` review settled a similar clash
by adopting `research-to-ideas`' words (`work-samples/watchdog-2026-10-20.md:12`).

| # | Gap | Verdict | File it touches | Priority |
|---|---|---|---|---|
| I1 | Evidence gate before a PRD | Integrate | `.claude/skills/product-requirement-document/SKILL.md` | P2 |
| I2 | A count changed: check the query or event first | Integrate | `.claude/agents/investigator.md` | P3 |
| I3 | Read a leaver's usage before their stated reason | Integrate | `.claude/skills/customer-insight/references/jtbd-deep.md` | P3 |
| I4 | Read the product's outcomes doc first | Integrate, after the first real run | `.claude/skills/discovery-loop/SKILL.md` | P3 |
| I6 | A pitch with a fixed appetite, as its own artefact | Integrate | `.claude/skills/product-requirement-document/SKILL.md` and `references/methods.md` | P3 |
| I7 | Every kill range says where its number came from | Integrate, after the first real run | `.claude/skills/discovery-loop/SKILL.md` | P3 |
| L1 | Install the skill whole | Leave | none | — |
| L2 | Strategy frameworks (DHM, GLEe, GEM, moats, Aggregation Theory, platforms, OKRs) | Leave | none | — |
| L3 | Metrics frameworks (North Star, proxy metrics, AARRR, cohorts, growth loops) | Leave | none | — |
| L4 | Roadmap formats and prioritisation scoring | Leave | none | — |
| L5 | Shape Up operating model (no backlog, betting table, circuit breakers, hill charts) | Leave | none | — |
| L6 | Decision journal and calibration retro | Leave | none | — |
| L7 | Interview and test methods (Mom Test, commitment signals, interview guide, chat-friction test) | Leave | none | — |
| L8 | Templates and anti-patterns (one-pager, launch checklist, stakeholder update, strategy doc) | Leave | none | — |
| L9 | Gate bypass tags, automatic stakes tiers, Boardroom mode | Leave | none | — |
| L10 | Scenario-based validation of a skill | Leave | none | — |
| L11 | Working MVP against micro-tests (was I5) | Leave | none | — |

## Integrate

### I1. Evidence gate before a PRD — `product-requirement-document/SKILL.md`

- **Source:** `SKILL.md` §2 (Context Gate, Minimum Evidence Weight Rule, License to Say No).
- **What we have:** the Diagnostic asks for decision context and "are we still in discovery?"
  (`SKILL.md:100` sends pure discovery to `discovery-loop`). The artefact table
  (`SKILL.md:90-96`) and the discovery-vs-delivery table (`SKILL.md:118-131`) set the right
  document. The Assumption test exists (`references/methods.md:31,49`), and so does the
  Confirmed / Inferred / Assumed label (`references/failure-modes.md:59`). But all of it runs
  after drafting. Nothing ties how much PRD to write to how much evidence there is, before a word
  is written.
- **Change:** wire the Assumption test into the Diagnostic. Label the core problem's evidence on
  the skill's own scale (Confirmed / Inferred / Assumed). If it rests only on Assumed claims,
  write the discovery-phase PRD and send its riskiest assumption to `discovery-loop`. A build the
  committee has mandated is labelled "mandated, no evidence" rather than blocked (the source's
  Strategic Exception).
- **Why integrate:** the PRD skill owns the job; the gap is moving one existing test earlier.
- **Reverses if:** the next two PRDs arrive fully evidenced, so the step only adds length.

### I2. A count changed: check the query or event first — `.claude/agents/investigator.md`

- **Source:** `metrics-growth.md` §1 (Step-0 instrumentation check, re-baselining) and the
  "Linear Checklist Execution" anti-pattern.
- **What we have:** `investigator` owns live defects of unknown cause and traces a wrong value
  back (`investigator.md:19`). Step 5 lists known bug patterns (`investigator.md:22`), with none
  for a number that moved. Real trends belong to `product-management:metrics-review`, which
  triggers on "a sudden spike or drop" (its `SKILL.md:3`) and already covers trend shape.
- **Change:** one item in the step 5 list: a count or total changed, so check the query, the event
  or the definition first, and say how much of the change it explains. If the measurement is
  sound, the trend is `metrics-review`'s job, not a defect.
- **Why integrate:** live counts exist (the BalanceTRI-app console's pending count, Balance Bolt
  results). The agent owns the job; the gap is one known pattern.
- **Reverses if:** a metric question is routed to `investigator` and the item never fires, or the
  two jobs blur in routing.

### I3. Read a leaver's usage before their stated reason — `customer-insight/references/jtbd-deep.md`

- **Source:** `discovery.md` §5 (churn interview limits, telemetry triangulation, biased sample).
- **What we have:** `jtbd-deep.md` already says customers rationalise after the fact (`:163`),
  runs churn timeline interviews (`:177`) and reads falling usage as a churn signal (`:122`). It
  does not say to read a leaver's usage before the interview, or that leavers who agree to talk
  are not typical.
- **Change:** extend the churn row at `jtbd-deep.md:177`: read the person's usage first (last
  booking, last sign-in, where they stopped). Grade their stated reason Inferred until the data
  agrees. Note that leavers who say yes to a call are not a fair sample.
- **Why integrate:** the reference owns churn interviews; the gap is one sentence.
- **Reverses if:** the club has no usage data to read. Then cut the rule to "grade it Inferred".

### I4. Read the product's outcomes doc first — `discovery-loop/SKILL.md` (after its first real run)

- **Source:** `SKILL.md` §2 (Living Workspace State: load `product/strategy.md`, cite it with its
  date, warn when over 90 days old, flag a request that contradicts the stated focus).
- **What we have:** step 1 writes the outcome fresh each time. Neither app keeps an outcomes doc
  (`BalanceTRI-app/docs/` holds `permissions.md` only; `BalanceBolt/docs/` holds
  `how-to-guide.md`). `intent-audit.md` already sets the pattern for standing docs.
- **Change:** step 1 reads the product's outcomes doc if one exists, cites it with its date, warns
  when it is over 90 days old, and flags an idea that serves none of its outcomes. If none
  exists, the first pass writes one beside the loop log.
- **Why integrate:** the skill owns "fix one outcome"; the gap is where the outcome lives.
- **When:** after the first real run, so that run's audit grades the skill as shipped.
- **Reverses if:** two loop runs pass and no app has an outcomes doc. Then drop the step.

### I6. A pitch with a fixed appetite, as its own artefact — `product-requirement-document`

- **Source:** `execution.md` §1–2 (appetite, shaping, no-gos), `conflicts.md` §1,
  `artifacts-templates.md` §1 Section B. The source forbids blending a brief with a pitch
  (`SKILL.md:107`).
- **What we have:** "Appetite" and "Shape Up" appear nowhere in the library. The PRD skill
  excludes small builds (`SKILL.md:98,100`: more than one sprint; not for small incremental
  change), so a pitch cannot live inside the PRD. `mc-planner` sets non-goals but no time budget.
- **Change:** a new row in the artefact table (`SKILL.md:90-96`): **Pitch (fixed appetite)**, for
  a small build with a fixed time budget, under a page. Its shape goes in `references/methods.md`:
  problem, appetite, solution sketch, rabbit holes, no-gos. It stays a separate artefact, never a
  PRD section. `mc-planner` stays as it is.
- **Why integrate:** apps here are built in spare time, which is a fixed budget. The skill's
  artefact table owns the choice of document; the gap is one row and one shape.
- **Reverses if:** the next two small builds go straight to `mc-planner` and nobody reaches for a
  pitch.

### I7. Every kill range says where its number came from — `discovery-loop/SKILL.md` (after its first real run)

- **Source:** `SKILL.md:64` (every quantitative kill criterion states its anchor, or is labelled an
  assumption with a revisit trigger). Found by `watchdog`; the first draft missed it.
- **What we have:** the test card sets Continue, Change and Stop ranges before the test, with no
  gap (`discovery-loop/SKILL.md:118-122`). It never asks where the numbers came from.
- **Change:** one line under the card: each range cites its anchor (a baseline, a past result, a
  comparable feature), or is marked a guess with the date to revisit it.
- **Why integrate:** the skill owns the card; the gap is one line. A guessed threshold dressed as
  a measured one is the trap the card exists to stop.
- **When:** after the first real run, as for I4.
- **Reverses if:** the first two cards all have obvious anchors, so the line adds nothing.

## Leave

### L1. Install the skill whole

Its description triggers on PRDs, roadmaps, interviews, metrics, sprint planning and stakeholder
updates. That overlaps `product-requirement-document`, `discovery-loop`, `customer-insight`,
`project-management` and the `product-management:*` plugin. The 2026-10-18 merges removed exactly
this kind of overlap. It also writes `product/decisions.md` into the workspace after every PRD.
Take its best rules into the owning skills instead.
**Reverses if:** the owner moves to B2B SaaS product work where its defaults fit, and a blind
routing test shows it beats the current split.

### L2. Strategy frameworks — no recurring job

`multi-actor-strategy` owns "what should we do"; `positioning` owns differentiation;
`high-output-management` owns OKRs. No task this month needed DHM, GLEe or GEM. The frameworks are
study material: the PM 2.0 Library in Notion is their home.
**Reverses if:** the owner writes a product strategy doc twice in a quarter. Then fold DHM and GEM
into `multi-actor-strategy`'s Strategist as a reference.

### L3. Metrics frameworks

`product-management:metrics-review` covers the North Star, the L1/L2 hierarchy, activation and
cohort retention curves (its lines 41, 136, 150, 200). Tracking plans are covered by the
`product-tracking-skills` plugin, which is also outside this library. The source itself puts
consumer growth loops out of scope (`limitations.md` §3).
**Reverses if:** either plugin is removed from the account.

### L4. Roadmap formats and prioritisation scoring

`product-management:roadmap-update` covers Now/Next/Later, RICE, ICE and MoSCoW. The source's
best idea here, a cited source for every Impact and Effort rating, is mostly in `idea-challenger`
intake already: demand is capped at 2 on Asserted evidence (`idea-challenger.md:64`), and the
output names its weakest score.
**Reverses if:** an intake grade proves wrong because an unsourced Effort or Income score was
trusted. Then require a source on every factor.

### L5. Shape Up operating model — no recurring job

Shape Up rejects backlogs. This library runs a ranked Notion backlog that `close-out.md` writes
to. For a one-person team, `project-management`'s ritual stack covers cadence. A circuit breaker
already exists in `discovery-loop`'s Stop range and the ledger's "Reverses if" lines.
**Reverses if:** the pending backlog passes 50 rows and old rows stop being picked. Then try one
betting-table cull.

### L6. Decision journal and calibration retro — no recurring job yet

`discovery-loop` already logs each test with ranges set in advance and the result.
`product-requirement-document` Section 9 measures at 30/60/90 days with an owner.
`multi-actor-strategy` records Conviction Bets. Calibration statistics need 10 resolved decisions;
the source itself forbids them below that.
**Reverses if:** `discovery-loop` logs hold 10 resolved tests. Then add a read-back step to it.

### L7. Interview and test methods

`customer-insight` runs past-behaviour timeline interviews and bans "what do you want?"
(`SKILL.md:113-128`, `:153`); `references/vpc-deep.md` has interview questions.
`discovery-loop/references/experiments.md` covers commitment (pre-order or deposit, concierge) and
the "opinion dressed as data" trap. The chat-friction test (`discovery.md` §3) fits AI chat
features; neither app has or plans one, and Wizard of Oz already tests it.
**Reverses if:** an app plans a chat or assistant feature. Then add the friction test to
`experiments.md`.

### L8. Templates and anti-patterns

PRD Section 9 covers rollout; `release-engineer` covers release hygiene.
`project-management/references/update-templates.md` and `product-management:stakeholder-update`
cover updates. `business-case-builder` has a one-page format
(`references/formats-and-audiences.md:7`). `failure-modes.md` covers PRD anti-patterns.
**Reverses if:** a launch slips because a staged rollout step was missing. Then add the checklist
to PRD Section 9.

### L9. Gate bypass tags, automatic stakes tiers, Boardroom mode

`cpo` already frames each request as routine or high stakes and asks only when high. The
Stakeholder Proxy in `multi-actor-strategy` and `read-the-room` cover stakeholder simulation.
**Reverses if:** routine PRDs start stalling on questions `cpo`'s frame should have assumed.

### L10. Scenario-based validation — no recurring job

`skills-librarian/references/upgrade-gauntlet.md` builds a benchmark with a sealed held-out set
per skill. Agents get planted-defect A/B tests (`agent-vs-house-*.md`). The source's typed gap
labels (Reasoning, Methodology, Wording, Integrity) are a nice touch, not a gap.
**Reverses if:** a skill change ships that the gauntlet would have caught, because it was not run.

### L11. Working MVP against micro-tests (was I5)

`conflicts.md` §3 says micro-tests cannot show whether people complete the whole loop and come
back. `discovery-loop/references/experiments.md:26-27` already covers repeat use: concierge reads
"whether they use it again", Wizard of Oz reads "use and repeat use". Both run the loop by hand.
**Reverses if:** an idea's loop cannot be run by hand (payments through the app, automated
reminders at scale). Then add a "minimal working version" row to the menu.

## Backlog rows

Rows for I1, I2, I3, I4, I6 and I7, Status Pending. The eleven Leave verdicts are closed
decisions. `cpo/references/close-out.md:49` owes a row only for a finding still open, so they are
recorded on ASL-067 itself, which closes as Done. This departs from the page's "each gap is a
backlog row": the Leaves are recorded on the backlog, on the parent row, not one row each.

## Independence and limits

- Embodied in `cpo`, one thread: it read the source, searched the library and wrote every verdict.
  Reduced independence. `watchdog` (delegated) checked it; its 12 findings changed 7 verdicts.
- Argued against: L2 could be an integrate. A moat claim with no mechanism is a common strategy
  error, and `strategy-challenger` could test for it. Left out because no strategy task ran this
  month, so no evidence says it is needed.
- Not checked: the glossary line by line, the 13 scenario files, and whether the source's numbers
  (5 interviews, 15% of users, 90 days) are sourced. I1 and I4 take the ideas, not the numbers.

## watchdog check (delegated, 2026-10-23)

Brief: the artefact path, the source, the library, both ledgers and both apps; check overlap,
every file:line, fit with the decision rule, drift against the 2026-10-20 phuryn entries, and
anything missed. 500 words, read only.

Result: no High, 5 Medium, 7 Low. The main thread re-read every cited line before acting. All 12
held and all were applied.

| # | Grade | Finding | Fix applied |
|---|---|---|---|
| 1 | Medium | I6 put a pitch for small builds inside a skill that excludes small builds (`SKILL.md:98,100`) | Pitch becomes its own row in the artefact table |
| 2 | Medium | I5's premise wrong: concierge and Wizard of Oz already read repeat use (`experiments.md:26-27`) | I5 moved to Leave (L11) |
| 3 | Medium | I2 aimed at the wrong owner; trends belong to `metrics-review` | Narrowed to one known-pattern item at step 5; shape sentence dropped |
| 4 | Medium | I1 and I3 would widen the split between evidence scales | Each uses its skill's own scale; rename left to the owner |
| 5 | Medium | Ten Leave rows would break `close-out.md:49` | Rows for integrates only; Leaves recorded on ASL-067 |
| 6 | Low | I1 missed `methods.md:31,49` and `SKILL.md:118-131` | Cited; I1 reframed as moving the Assumption test earlier |
| 7 | Low | I1 cited `cody`'s overclaims, which were about tests, not PRDs | Sentence dropped |
| 8 | Low | I3 missed `jtbd-deep.md:122,163,177` | Target moved to `jtbd-deep.md:177` |
| 9 | Low | I4 and I5 edit `discovery-loop` before its first real run | I4 and I7 wait for that run |
| 10 | Low | L3 called `product-tracking-skills` library coverage | Said it is a plugin |
| 11 | Low | L2, L5, L6, L10 are "no recurring job", which the rule lacks | Flagged as an extension of the rule |
| 12 | Low | Missed: anchors for kill thresholds (source `SKILL.md:64`) | Added as I7 |

No `agent-improver` pass on `watchdog`: every finding held (`close-out.md`, step 2). Its report
looked over the 500-word cap (not counted). That is the known open issue (ASL-068), not a new one.
