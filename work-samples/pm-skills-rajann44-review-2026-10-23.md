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
criteria and a 10-line draft. It writes every final decision to `product/decisions.md` with a
prediction and a confidence, and a retro later scores them (no statistics under 10 resolved).
Its frameworks are Cagan, Torres, Singer (Shape Up), Biddle (DHM, GEM, GLEe), Fitzpatrick (Mom
Test) and Rachitsky. It was validated on 13 scenarios with a typed gap log and before/after diffs.

## What this week's work changed

A week ago, most of the source's discovery spine would have been a **build new** gap. It is not
now:

- `discovery-loop` (added 2026-10-20) covers the Opportunity Solution Tree, the four risks,
  assumption mapping, fake doors, deposits, and kill criteria set before a test runs (its
  Continue / Change / Stop ranges).
- `.claude/references/intent-audit.md` (2026-10-20) set the pattern of standing docs an app keeps
  and agents cite. Gap I4 reuses it for product outcomes.
- The PM 2.0 Library in Notion (checked 2026-10-20) is now the owner's study area. Framework
  knowledge with no recurring task belongs there, not in a skill (gap L2).
- The 2026-10-22 pipeline run showed unlabelled claims passing as fact (`cody`'s overclaims). That
  raises the value of gap I1, which labels each PRD claim by its evidence.

## Library skills checked first (the page's list)

| Skill or agent | What it already covers from the source | Gap found |
|---|---|---|
| `product-requirement-document` | Decision context, discovery vs delivery PRD, Confirmed/Inferred/Assumed (as a remedy), rollout and 30/60/90 measurement | I1, I6 |
| `discovery-loop` | OST, four risks, assumption map, fake door, deposit, pre-set kill ranges, loop log | I4, I5 |
| `customer-insight` | Past-behaviour timeline interviews, churn diagnosis, VPC interview questions | I3 |
| `positioning` | Differentiation | none (L2) |
| `project-management` | Ritual stack, stakeholder and manager updates | none (L5, L8) |
| `business-case-builder` | One-page case, success metrics with targets and dates | none (L8) |
| `research-to-ideas` | Evidence grades (Tested to Asserted), ranked ideas, Stage 8 test | none (L4, L6) |
| `multi-actor-strategy` | Direction choice, Stakeholder Proxy, Conviction Bets | none (L2, L6, L9) |
| `mc-planner` | Testable spec, non-goals | none; I6 leaves it unchanged |

## Verdicts

No **build new**. Six **integrate**, ten **leave**. Every integrate is a missing step in a skill
or agent that already owns the job. None is applied here; each waits for the owner's go-ahead,
as gaps #1 and #2 of the `phuryn/pm-skills` review did.

| # | Gap | Verdict | File it touches | Priority |
|---|---|---|---|---|
| I1 | Evidence gate before a PRD | Integrate | `.claude/skills/product-requirement-document/SKILL.md` | P2 |
| I2 | A metric change: check the measurement first | Integrate | `.claude/agents/investigator.md` | P3 |
| I3 | Churn reasons need usage data beside them | Integrate | `.claude/skills/customer-insight/SKILL.md` | P3 |
| I4 | Read the product's outcomes doc first | Integrate | `.claude/skills/discovery-loop/SKILL.md` | P3 |
| I5 | When a working MVP is the cheapest test | Integrate | `.claude/skills/discovery-loop/references/experiments.md` | P3 |
| I6 | Appetite: fix the time, flex the scope | Integrate | `.claude/skills/product-requirement-document/references/methods.md` | P3 |
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

## Integrate

### I1. Evidence gate before a PRD — `product-requirement-document/SKILL.md`

- **Source:** `SKILL.md` §2 (Context Gate, Minimum Evidence Weight Rule, License to Say No).
- **What we have:** the diagnostic asks for decision context and "are we still in discovery?"
  (line 100 sends pure discovery to `discovery-loop`). Labelling each claim Confirmed, Inferred or
  Assumed exists, but only as the remedy to Failure Mode 3 in `references/failure-modes.md:59`.
  Nothing ties how much PRD to write to how much evidence there is.
- **Change:** in the Diagnostic, one step: label the problem's evidence Confirmed, Inferred or
  Assumed. If the core problem rests only on Assumed claims, write the discovery-phase PRD and
  send its riskiest assumption to `discovery-loop`. A build the committee has mandated is labelled
  "mandated, no evidence" rather than blocked (the source's Strategic Exception).
- **Why integrate:** the PRD skill owns the job; the gap is one step and a promoted rule.
- **Reverses if:** the next two PRDs arrive fully evidenced, so the step only adds length.

### I2. A metric change: check the measurement first — `.claude/agents/investigator.md`

- **Source:** `metrics-growth.md` §1–2 (Step-0 instrumentation check, re-baselining, shape
  analysis) and the "Linear Checklist Execution" anti-pattern.
- **What we have:** `investigator` owns "broken, cause unknown". It forms one hypothesis at a time
  and questions the frame after three, but has no rule for when the symptom is a number.
  `product-management:metrics-review` lists "known data quality issues" (line 97) but has no gate,
  and it is a plugin this repo cannot edit.
- **Change:** one line in the method: when the symptom is a number that moved (a count, a rate, a
  total), the first hypothesis is that the measurement moved: the query, the event, the
  definition. Say how much of the change it explains, and chase only the rest. A sudden step and
  a slow slide point to different causes.
- **Why integrate:** live counts exist (the BalanceTRI-app console's pending count, Balance Bolt
  results). The agent owns the job; the rule is one step.
- **Reverses if:** two metric investigations go to `product-management:metrics-review` instead, so
  `investigator` never sees one.

### I3. Churn reasons need usage data beside them — `customer-insight/SKILL.md`

- **Source:** `discovery.md` §5 (churn interview limits, telemetry triangulation, biased sample).
- **What we have:** `customer-insight` triggers on "why customers churn" and runs timeline
  interviews (`SKILL.md:113-128`), but treats a leaver's stated reason like any other evidence.
- **Change:** in Customer Discovery Interviews, one rule: people who left give polite reasons and
  the ones who agree to talk are not typical. Read their usage first (last booking, last sign-in,
  where they stopped) and grade a stated reason as Inferred until the data agrees.
- **Why integrate:** the skill owns churn diagnosis; the gap is one rule. Lapsed club members are
  the likely first use.
- **Reverses if:** the club has no usage data to read, so the rule collapses to "grade it
  Inferred". Then cut it to that.

### I4. Read the product's outcomes doc first — `discovery-loop/SKILL.md`

- **Source:** `SKILL.md` §2 (Living Workspace State: load `product/strategy.md`, cite it with its
  date, warn when over 90 days old, flag a request that contradicts the stated focus).
- **What we have:** `discovery-loop` step 1 writes the outcome fresh each time. Neither app keeps
  an outcomes doc (`BalanceTRI-app/docs/` holds `permissions.md` only; `BalanceBolt/docs/` holds
  `how-to-guide.md`). `intent-audit.md` already sets the pattern for standing docs on the security
  side.
- **Change:** step 1 reads the product's outcomes doc if one exists, cites it with its date, warns
  when it is over 90 days old, and flags an idea that serves none of its outcomes. If none exists,
  the first pass writes one beside the loop log.
- **Why integrate:** the skill owns "fix one outcome"; the gap is where the outcome lives.
- **Reverses if:** two loop runs pass and no app has an outcomes doc. Then drop the step.

### I5. When a working MVP is the cheapest test — `discovery-loop/references/experiments.md`

- **Source:** `conflicts.md` §3 (Continuous Discovery against Classic MVP).
- **What we have:** the menu lists micro-tests only: fake door, concierge, Wizard of Oz, deposit,
  smoke page, task test, spike, A/B. It never says when they fall short.
- **Change:** one row or note under "Pick by risk": for a new standalone product (not a feature in
  a live app), micro-tests cannot show whether people complete the whole loop and come back. A
  minimal working version may be the cheapest honest test. Set its ranges first, as for any card.
- **Why integrate:** the reference owns method choice; the gap is one row. New apps are on the
  backlog (Tri-Momentum-app, CLACFridays-app).
- **Reverses if:** the first real `discovery-loop` run on a new product picks a micro-test and it
  answers the question.

### I6. Appetite: fix the time, flex the scope — `product-requirement-document/references/methods.md`

- **Source:** `execution.md` §1–2 (appetite, shaping, no-gos), `conflicts.md` §1,
  `artifacts-templates.md` §1 Section B.
- **What we have:** "Appetite" and "Shape Up" appear nowhere in the library. The PRD has Out of
  Scope (Section 7). `mc-planner` sets non-goals but no time budget.
- **Change:** in `methods.md`, a short pitch shape for small builds: problem, appetite (the time
  we will spend), solution sketch, rabbit holes, no-gos. One pointer in `SKILL.md` Section 7.
  `mc-planner` stays as it is.
- **Why integrate:** apps here are built in spare time, which is a fixed budget. The PRD skill owns
  spec shape; the gap is one method.
- **Reverses if:** the next two PRDs use fixed scope and never name an appetite.

## Leave

### L1. Install the skill whole

Its description triggers on PRDs, roadmaps, interviews, metrics, sprint planning and stakeholder
updates. That overlaps `product-requirement-document`, `discovery-loop`, `customer-insight`,
`project-management` and the `product-management:*` plugin. The 2026-10-18 merges removed exactly
this kind of overlap. It also writes `product/decisions.md` into the workspace after every PRD.
Take its best rules into the owning skills (I1–I6) instead.
**Reverses if:** the owner moves to B2B SaaS product work where its defaults fit, and a blind
routing test shows it beats the current split.

### L2. Strategy frameworks

`multi-actor-strategy` owns "what should we do"; `positioning` owns differentiation;
`high-output-management` owns OKRs. No recurring task this week needed DHM, GLEe or GEM. The
frameworks are study material: the PM 2.0 Library in Notion is their home.
**Reverses if:** the owner writes a product strategy doc twice in a quarter. Then fold DHM and GEM
into `multi-actor-strategy`'s Strategist as a reference.

### L3. Metrics frameworks

`product-management:metrics-review` covers the North Star, the L1/L2 hierarchy, activation and
cohort retention curves (its lines 41, 136, 150, 200). `product-tracking-skills` covers tracking
plans. The source itself puts consumer growth loops out of scope (`limitations.md` §3).
**Reverses if:** that plugin is removed from the account.

### L4. Roadmap formats and prioritisation scoring

`product-management:roadmap-update` covers Now/Next/Later, RICE, ICE and MoSCoW. The source's
best idea here, a cited source for every Impact and Effort rating, is mostly in `idea-challenger`
intake already: demand is capped at 2 on Asserted evidence, and it names its weakest score.
**Reverses if:** an intake grade proves wrong because an unsourced Effort or Income score was
trusted. Then require a source on every factor.

### L5. Shape Up operating model

Shape Up rejects backlogs. This library runs a ranked Notion backlog that `close-out.md` writes
to. For a one-person team, `project-management`'s ritual stack covers cadence. A circuit breaker
already exists in `discovery-loop`'s Stop range and the ledger's "Reverses if" lines.
**Reverses if:** the pending backlog passes 50 rows and old rows stop being picked. Then try one
betting-table cull.

### L6. Decision journal and calibration retro

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
cover updates. `business-case-builder` has a one-page format. `failure-modes.md` covers PRD
anti-patterns.
**Reverses if:** a launch slips because a staged rollout step was missing. Then add the checklist
to PRD Section 9.

### L9. Gate bypass tags, automatic stakes tiers, Boardroom mode

`cpo` already frames each request as routine or high stakes and asks only when high. The
Stakeholder Proxy in `multi-actor-strategy` and `read-the-room` cover stakeholder simulation.
**Reverses if:** routine PRDs start stalling on questions `cpo`'s frame should have assumed.

### L10. Scenario-based validation

`skills-librarian/references/upgrade-gauntlet.md` builds a benchmark with a sealed held-out set
per skill. Agents get planted-defect A/B tests (`agent-vs-house-*.md`). The source's typed gap
labels (Reasoning, Methodology, Wording, Integrity) are a nice touch, not a gap.
**Reverses if:** a skill change ships that the gauntlet would have caught, because it was not run.

## Independence and limits

- Embodied in `cpo`, one thread: it read the source, searched the library and wrote every verdict.
  Reduced independence. `watchdog` (delegated) checks it for overlap and errors below.
- Argued against: L2 could be an integrate. A moat claim with no mechanism is a common strategy
  error, and `strategy-challenger` could test for it. Left out because no strategy task ran this
  month, so no evidence says it is needed.
- Not checked: the glossary line by line, the 13 scenario files, and whether the source's numbers
  (5 interviews, 15% of users, 90 days) are sourced. I1 and I4 take the ideas, not the numbers.

## watchdog check

(Filled in after the dispatch returns.)
