---
name: research-to-ideas
description: >
  Turn research that already exists (forum scans, interviews, desk research, competitor pages)
  into a ranked, evidence-graded shortlist of ideas, one decision, and a cheap test of the top
  pick. Fixed pipeline: scope, then cluster, frame the job, generate ideas, grade evidence, cost
  and score, stress-test, decide, test and learn. Four agents (source scout, cluster analyst,
  blind evidence auditor, blind idea challenger) and a checking script back the stages. Re-runs
  update an earlier run instead of starting over. Trigger on: "turn this research into ideas",
  "what should I do with this research", "shortlist these options", "rank these ideas", "which
  of these should I try", "give me a 30-day plan from this", "re-run the shortlist", "we got the
  test result", or any request to get from a pile of findings to a call. Not for gathering
  research from scratch (use deep-research or recent-pulse first), and not for evidence
  synthesis with no options to choose between (use multi-actor-research).
---

# Research → Ideas Pipeline

Research piles up. Decisions don't. This skill gets from one to the other: a short ranked list,
one call, and a test that tells you within weeks whether the call was right.

Each stage stacks a skill already in the library. This skill owns the sequence, the evidence
rules, the ranking, the decision block, the test loop and the write-back. It does not own the
thinking inside each stage.

Stages 1–3 find the jobs and the ideas. Stages 4–5 grade and rank. Stage 6 stress-tests. Stage 7 decides. Stage 8
tests, and its result feeds the next run.

Order matters: each stage reads the one before. Copy this checklist into your reply at the
start of the run and tick each line as it closes. Start a stage only when the line above it
is ticked.

```
- [ ] 0 Scope and coverage set; missing source classes scouted
- [ ] 1 Clustered; thin groups sent to Revisit-if
- [ ] 2 One job per cluster, with push and anxiety quoted
- [ ] 3 Two to four ideas per job; load-bearing claims marked
- [ ] 4 Claims graded; auditor's grades diffed against mine
- [ ] 5 Scored, confidence rated, ranked; check_brief.py clean (Full)
- [ ] 6 Top three stress-tested; drops re-ranked
- [ ] 7 Decision block written; check_brief.py clean again
- [ ] 8 Test plan with gap-free decision rule; write-back done
```

Read before you write any output:

- [`references/templates.md`](references/templates.md): idea card, decision block, test plan,
  and a worked example.
- [`references/agent-workflow.md`](references/agent-workflow.md): before dispatching any agent.

## When this fires, and when it hands off

Fires when research material exists (pasted, attached, on a Notion page, or gathered earlier in
this turn) and the ask is to turn it into ideas, options, a shortlist, a call or a plan.

- **No corpus yet.** Gather it first with `deep-research` (broad) or `recent-pulse` (what people
  say right now). Then run the pipeline. A shortlist built on a hunch is a hunch with a table.
- **Findings, no choice to make.** Use `multi-actor-research`. This skill needs options.
- **One quick question.** Answer it directly. No pipeline.
- **An earlier run exists on the same topic.** This is a re-run. Read "Re-runs" first.

## Stage 0: Scope and coverage

Two minutes. These five lines open the parent page.

1. **Decision.** What gets decided, who decides, by when.
2. **Limits.** Budget in AUD, hours per week, hard constraints. All money is AUD. Note the FX
   rate and date beside any converted figure.
3. **Priority weights.** Name the two criteria that matter most for this decision. They count
   double in Stage 5. Everything else counts once.
4. **Coverage plan.** List the source classes the decision needs (forums, first-hand case
   studies, verified revenue data, expert interviews, competitor pages). Mark each Reached,
   Partial or Not reached. Only Reached counts as reached. Anything else caps confidence at
   Medium (Stage 5).
5. **Depth.** *Full* by default. *Lite* when the corpus has under ten sources or the budget at
   risk is under AUD 100: work inline with no agents, skip `red-team` in Stage 6, and write only
   the parent page. A Lite run grades its own evidence, so it caps at Medium like an embodied
   run. Say which depth you chose.

On Full depth, dispatch one `source-scout` per Not-reached or Partial class before Stage 1.

## Agents behind the stages

On Full depth, four agents and one script take the jobs the main thread does badly for itself.
The main thread stays the conductor and makes every call. Agents return evidence and objections.

| Stage | Agent or script | Blind to |
|---|---|---|
| 0 | `source-scout`, one per missing class, in parallel. Two rounds at most | Ideas, scores |
| 1–3 | `cluster-analyst`, one per cluster, in parallel | Other clusters, grades |
| 4 | `evidence-auditor`, alongside your own draft grades | **Your draft grades** |
| 5, 7, 8 | `scripts/check_brief.py` on the brief as JSON. Fix every FAIL | — |
| 6 | `idea-challenger`, one per leading idea, in parallel | **Score, rank, your reasoning** |

If this session has no Agent tool, run each role yourself in order, reading its agent file first.
Label the run **embodied**. An embodied audit is self-graded, so every idea caps at Medium
confidence, and the decision block says "stress-tested by author", not "stress-tested".

## Stages

**1. Cluster: `issue-tree`.** Sort the raw research into MECE groups by the problem or desire
it describes, not by the solution it mentions. Tag every source with its class, platform and
date. Stage 4 needs the tags.

A group with three or more independent first-hand sources is a **cluster**. A thinner group is
**thin**. Thin groups skip Stages 2–6. They go straight to the "Revisit if" list in Stage 7,
with the trigger "Revisit if [N] more independent sources confirm it."

**2. Frame the job: `customer-insight` (Part 1, JTBD).** Write one job per cluster: *when
[situation], I want to [motivation], so I can [outcome].* Add the strongest push (what makes the
current way painful) and the strongest anxiety (what stops people switching), each with a
quoted source. If the job reads as a feature or tactic ("sell PDFs") rather than progress
("prove I did the research so a buyer doesn't have to"), rewrite it before moving on.

**3. Generate ideas.** For each job, write two to four ideas that would do it. At least one
per job must fit inside the Stage 0 limits as they stand. Name each idea verb first, in plain
words. Drop ideas that break a hard constraint, and list them with the reason. For each idea,
mark its **load-bearing claims**: the facts it fails without.

Carry at most **eight** ideas into Stage 4. If more survive, keep those with the strongest
evidence behind their job and park the rest with a "Revisit if" trigger.

**4. Grade the evidence.** Grade each claim. Give it the highest grade whose rule it meets in
full. If you're unsure between two, take the lower.

| Grade | Rule |
|---|---|
| **Tested** | Your own result, from a Stage 8 test. |
| **Confirmed** | Three or more independent accounts agree, from two or more source classes, and at least one account carries proof (payout screenshot, platform-verified revenue, third-party data). |
| **Inferred** | Two or more independent accounts agree, but the claim misses a Confirmed rule. |
| **Asserted** | One account, or accounts that are not independent. |

Three rules override the table:

- **Self-reports are not proof.** Three people saying they earned $500 is three accounts, not
  proof. Proof is something a third party produced.
- **Sellers' claims are Asserted.** A source that profits if you believe it (course sellers,
  affiliate posts, "how I made $10k" funnels) grades Asserted, however many copies exist. Its
  claims can suggest ideas. They cannot support one.
- **Contested beats consensus.** If an independent account of equal or higher grade says the
  opposite, mark the claim **Contested** and show both sides. Don't average them.

Accounts are independent only if they have different authors and none quotes another. An
idea's grade is the grade of its **weakest load-bearing claim**. Never round a grade up for a
cleaner story.

On Full depth, send the evidence table to `evidence-auditor` without your grades. Where its
grade differs from yours, the lower one stands until you write down why. Log every difference
on the page.

Add one **denominator** line per idea: how many people tried this, and how many succeeded?
Success stories show it can work. They don't show how often. Give a count with its source, a
labelled estimate, or "Unknown".

**5. Cost, score, rate confidence and rank.** Record three numbers per idea first:

- **Cost** in AUD to reach first signal.
- **Weeks to first signal**: how soon you learn whether it works, not how soon it launches.
- **Outcome range**: low, base and high, in the unit that fits, each with its source.

Score each idea 1–5 on five criteria. **5 is always the best end.**

| Criterion | 5 means | 1 means |
|---|---|---|
| Reach | Many people have the job and can be reached | Few, or unreachable |
| Cost | Well inside the budget | Uses all of it, or more |
| Speed to signal | Signal within 2 weeks | Signal after 8+ weeks |
| Fit | Uses skills and assets you already have | Needs skills you lack |
| Upside | Base case clears the goal | Even the high case misses it |

Double the two priority-weight criteria from Stage 0, then add up. The maximum is 35.

Then rate confidence. Work out each check below, then take the **lowest** tier any check gives.

| Check | High | Medium | Low |
|---|---|---|---|
| Idea grade (Stage 4) | Tested or Confirmed | Inferred | Asserted or Contested |
| Independent sources | 5+ | 3–4 | 1–2 |
| Denominator | Known | Estimated | Unknown |
| Coverage | Every needed class Reached, none over half the sources | A class not Reached, or one class over half | — |
| Blockers | None | One, with a workaround | One with no workaround |
| Run | Dispatched audit | Embodied audit or Lite run | — |

State in one line what would lift the rating one tier.

**Ranking rule.** Sort by confidence tier first, then by score within the tier. Write this rule
on the page. The grade judges one claim. Confidence judges the whole idea. Keep them visibly
apart.

On Full depth, write the brief as JSON and run `scripts/check_brief.py` on it. It checks totals,
caps and rank. Fix every FAIL before Stage 6.

Requires: Python 3.8+, standard library only. Nothing to install. Run
`python3 scripts/test_check_brief.py` to self-test the checker.

**6. Stress-test the leaders: a pre-mortem (`six-thinking-hats`, Extended Black Hat), plus `red-team` on Full depth.** Take the top
three. On Full depth, dispatch one `idea-challenger` per idea, with the idea and its evidence
only, never the score or rank. For each, assume it has already failed. Name the most likely
reason: a failure story from the research if one exists, otherwise the most plausible cause.
That is the **catch**. An idea with no catch has not been stress-tested.

Then size the worst case in one line each. Can it lose more than the budget or take more hours
than the limit? Can you undo it within a week?

Feed the result back into the rank:

- Worst case breaks a Stage 0 limit, can't be undone, or the challenger rates it **Blocks** →
  drop the idea to Low confidence.
- The catch hits a load-bearing claim → re-grade that claim in Stage 4 and re-rate.
- Re-sort. If the leader changed, stress-test the new top three. Stop after two passes, and say
  so if the rank still moved.

**7. Decide and land it: `scr-pyramid-communicator`.** Answer first: which idea to back and why,
in one sentence. Then the **decision block**: decision, decider, decide-by date,
recommendation, the one assumption that would reverse it, and the review date (the date the
Stage 8 test reports).

"Back nothing yet" is a valid call. Make it when no idea reaches Medium confidence. The top
pick then becomes the cheapest research step that would lift the leading idea one tier.

For each idea not chosen, and each thin group, add one line: *Revisit if [measurable
trigger].* Run `check_brief.py` again before you publish.

**8. Test and learn: top pick only.** Turn the pick into a test:

- **Hypothesis:** we believe [who] will [do what] because [evidence, with grade]. We will know
  when [measurable signal].
- **Cheapest test** that fits the Stage 0 limits, and the one metric it reads.
- **Decision rule:** a range each for Continue, Change and Stop. Every possible result lands in
  exactly one. Write the ranges so they meet with no gap (for example Stop < 3, Change 3 to
  under 10, Continue 10+). `check_brief.py` proves it.
- **Review date:** the decision block's review date.

The plan page holds day-1 actions, weekly checkpoints, spend, risks and the decision rule. When
the result arrives, record it as Tested evidence and start a re-run.

## Re-runs

A re-run updates the last run. It never starts over.

1. Find the latest parent page on the same topic (in Notion: Category Research, same topic in
   the Name). Read it and its idea pages.
2. Create a new parent page. Link the old one in its first line. Set the old parent to Done.
3. Open with **What changed**: new sources, grades that moved, test results, and any "Revisit
   if" triggers that fired.
4. Add **Calibration** once any Stage 8 result exists: predicted confidence and range against
   the actual result (table in `references/agent-workflow.md`).
5. Update existing idea pages in place: re-grade, re-score, re-rank. Create a page only for an
   idea that is new. Point each carried page's Parent item at the new parent.
6. Mark any idea with a Stage 8 result as Tested. Promote parked ideas whose trigger fired.
7. On Full depth, have `watchdog` sweep the new parent against the old one for drift.

## Output shape

Parent page, in this order:

1. Scope and coverage (Stage 0), with the depth and whether the run was embodied
2. What changed, and Calibration (re-runs only)
3. Decision block, answer first (Stage 7)
4. Ranked idea cards, one per idea past Stage 5 (template in `references/templates.md`)
5. Revisit-if list: parked ideas, thin groups, dropped ideas with reasons
6. **What the research could not verify.** Never drop this section. A run that admits no gap is
   hiding one.
7. Method: the ranking rule, the priority weights, grade differences from the audit

## Write-back

Write the result somewhere durable. A run that lives only in chat gets redone from scratch.

**Inside the first $100 online project** (Notion data source
`collection://37acfee1-ca18-8058-8046-000b4ee3c73b`):

| Page | Category | Phase | Status | Other fields |
|---|---|---|---|---|
| Parent | Research | Strategy | In Progress; Done once the decision is made | Notes: top pick and its confidence |
| One per idea past Stage 5 | Market Analysis | Strategy | Research; In Progress for the top pick | Budget $ = cost to first signal; Notes: confidence, grade, source count, range; Parent item = the parent |
| Plan for the top pick | Plan | Strategy | Not Started | Budget $; Due Date = review date; Parent item = the parent |

When a test reports, set the plan page to Done and put any money earned in **Revenue $**. It
displays in USD format but holds AUD like every other figure.

Before creating any page, search the data source for a page with the same Name and update it
instead. Lite runs write only the parent page.

Reply in chat with a three-line summary (top pick, confidence, review date) and the links. Don't
paste the full brief.

**Anywhere else,** ask where the result should land before writing a long inline answer.

## Related Skills

- `deep-research`, `recent-pulse`: gather the corpus before Stage 1
- `issue-tree`: Stage 1 clustering
- `customer-insight`: Stage 2 job framing (Part 1, JTBD). `.claude/skills/customer-insight/references/jtbd-deep.md` goes deeper
  if a single job needs full discovery-interview treatment
- `multi-actor-research`: when the output is findings, not a choice between options
- `multi-actor-strategy`: an alternative to Stage 5 when the decision turns on real
  stakeholders, not a scoring table
- `six-thinking-hats` (pre-mortem module), `red-team`: Stage 6 stress-test
- `scr-pyramid-communicator`: Stage 7 structure
- `source-scout`, `cluster-analyst`, `evidence-auditor`, `idea-challenger`: the agents behind
  Stages 0–4 and 6. `watchdog`: the re-run drift sweep
- `cpo`: routes one request to the right skill or agents. This skill routes a body of research
  through a fixed sequence of skills
