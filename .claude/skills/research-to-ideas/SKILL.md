---
name: research-to-ideas
description: >
  Turn completed research (forum scans, interviews, desk research) into a small set of ranked,
  evidence-graded ideas via a fixed 5-stage pipeline. Use for turning a pile of research into
  ideas, options, or a decision.
---

# Research → Ideas Pipeline

Five fixed stages turn a pile of research into a short, ranked, decision-ready list. Each stage
stacks an existing skill rather than reinventing it — this skill's job is the sequence, the
evidence rubric, and the write-back, not the thinking each stage does.

## When this fires, and when it hands off

Fires when research material already exists — pasted, attached, or just gathered in the same
turn — and the ask is to turn it into ideas, options, a shortlist, or a call. Does not fire for a
single quick question with no corpus behind it; answer that directly instead.

If the research does not exist yet, gather it first (web search, forum search, interviews) and
only then run the pipeline — don't skip straight to Stage 2 on a hunch.

## Stage sequence

**1. Cluster — `issue-tree`.** Break the raw research into MECE groups. A group needs at least
three independent, first-hand sources; label anything thinner "thin evidence" and keep it
separate rather than padding a cluster to make weight.

**2. Frame the job — `jobs-to-be-done-jtbd`, stacked with `customer-insight`.** For each cluster,
state the job people are actually hiring the idea to do, using the JTBD form: *when [situation], I
want to [motivation], so I can [outcome]*. An idea framed as a feature or a tactic ("sell PDFs")
instead of a job ("prove I did the research so a buyer doesn't have to") is a sign the cluster
needs another pass.

**3. Grade the evidence.** Grade every claim inside a cluster:
   - **Confirmed** — payout proof, or three or more independent, consistent accounts.
   - **Inferred** — consistent accounts, no proof.
   - **Asserted** — one claim, no proof.
   Treat all self-reported outcomes as Asserted until something backs them up. This grade travels
   with the idea into every later stage — never round it up for a cleaner story.

**4. Score and rate confidence.** Score each idea 1–5 against the criteria the decision actually
turns on (reach, cost, time, fit, viability — adjust the five to the decision at hand). Add the
scores, then rate confidence separately as **High / Medium / Low**:
   - High — Confirmed evidence, five or more independent sources, no blocking constraint, strong
     fit on the criteria that matter most.
   - Medium — Inferred evidence, three to four sources, or one blocker with a workaround.
   - Low — Asserted or thin evidence, or a blocker with no clear workaround.
   State in one line what would move the rating. Confidence judges the whole idea; the evidence
   grade judges one claim — keep them visibly separate in the output.

**5. Stress-test the leaders — `pre-mortem`, stacked with `red-team` for anything high-stakes.**
Take the top two or three by score and confidence. For each, assume it already failed and name
the most likely reason why — a failure story from the research if one exists, otherwise the most
plausible mechanism. This is the "catch" that goes in the final brief; an idea with no catch has
not been stress-tested yet, not one that is genuinely risk-free.

**6. Land the shortlist — `scr-pyramid-communicator`.** Governing thought first: which idea to
back and why, in one sentence. Beneath it, the ranked list, each with the job, evidence grade,
confidence rating, the catch, and one first step small enough to finish this week. Close with
what the research could not verify — never omit this line; a pipeline that never admits a gap is
hiding one.

## Output shape

For every idea carried past Stage 3:

- Name (verb first, plain)
- The job (JTBD form)
- Evidence: grade, source count
- Confidence: High / Medium / Low, one line why, one line on what would change it
- Score and the criteria behind it
- The catch (from Stage 5)
- First step (under two hours)

Close with: the top pick and why, and what remains unverified.

## Write-back

Default to writing the shortlist somewhere durable rather than leaving it in the reply — a
research pass that only lives in chat gets re-run from scratch next time.

Inside the **first $100 online** project (Notion data source
`collection://37acfee1-ca18-8058-8046-000b4ee3c73b`): create one parent page (Category Research,
Phase Strategy) holding the method and the ranked list, one sub-item per idea (Category Market
Analysis, Phase Strategy, Budget $ set to start-up cost, Notes carrying the confidence rating and
evidence grade), and — for the highest-confidence idea — a plan page (Category Plan) rather than
pasting the plan inline. Reply in chat with a short summary and the links, not the full brief.

Outside that project, ask where the shortlist should land (a doc, a tracker, a reply) before
defaulting to a long inline dump.

## Related Skills

- `issue-tree` — Stage 1 clustering
- `jobs-to-be-done-jtbd`, `customer-insight` — Stage 2 framing
- `multi-actor-strategy` — an alternative to Stage 4 when the decision has genuine strategic
  actors to model, not just a scoring rubric
- `pre-mortem`, `red-team` — Stage 5 stress-testing
- `scr-pyramid-communicator` — Stage 6 structure
- `prompt-refiner` — routes a single prompt to the right skill; this skill routes a body of
  research through a fixed sequence of skills instead