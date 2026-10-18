---
name: pre-mortem
description: "Imagine the project has already failed, then work backward to find why. Applies Gary Klein's prospective-hindsight technique to surface risks before they land. Use before launching a product, campaign or initiative; before an important decision (a hire, an investment, a partnership); at a project's start, to find risks the team has not considered; when everyone agrees the plan is great; or before committing significant resources. Trigger on: \"pre-mortem\", \"imagine this failed\", \"what will kill this\", \"prospective hindsight\". For an adversarial attack on an argument, use red-team. For strategic options appraisal, use multi-actor-strategy."
license: MIT
metadata:
  author: ClawFu
  version: 1.1.0
  mcp-server: "@clawfu/mcp-skills"
---

# Pre-Mortem

> Imagine your project has failed spectacularly — then work backward to identify why. Apply Gary Klein's "prospective hindsight" technique to catch failures before they happen.

## When to use this — and when not to

Use before a plan is executed and resources are committed: before launching, before an important decision (hiring, investment, partnership), starting a project, or when the team is unanimously confident (a warning sign in itself).

**Don't use it on something that already happened.** A pre-mortem interrogates a *pending* decision so the plan can still change cheaply. If the thing in question already shipped, or a decision is already executed, there's nothing left to pressure-test — that's a design/security review or a post-mortem, not this. See *Pre-Mortem vs Post-Mortem* below; getting this distinction right is the actual differentiator this skill has to earn over a shorter framework that also claims "pre-mortem" as a trigger (`six-thinking-hats`' Black Hat module — see *Related Skills*).

## Why it works

Klein's research (1989) shows imagining an event has *already happened* dramatically improves the ability to explain why — the future feels distant, the past feels concrete. Framing failure as an already-true fact, not a possibility, unlocks concerns people hesitate to raise in a forward-looking planning session. Klein's own data shows roughly 30% more failure reasons identified this way than with a plain "what might go wrong" question.

## Running it, solo or with a team

**1. Set the scenario.** State it as a fact, not a hypothetical: *"It is [a date well past this decision]. This has failed — not underperformed, failed. Looking back, why?"* No one defends the original plan in this exercise; the job is to explain the failure, not prevent it.

**2. Generate causes independently, in silence, before anyone talks.** Each person (or you, running multiple angles solo) writes 3–5 causes alone first. This isn't ceremony — the first person to speak anchors everyone after them, and silence is what surfaces the causes people wouldn't otherwise volunteer. Prompt across genuinely different failure categories so the list doesn't collapse into one theme: execution (what did we do poorly despite knowing the risk), assumptions (what "fact" turned out wrong), external/market (competitor, regulator, timing), people/team (capacity, skill, coordination), resources (budget, runway, a dependency that ran out).

**3. Share and cluster.** One cause at a time, no debate yet, until everyone's list is exhausted — then group into themes together.

**4. Prioritize.** For each cluster, rate Likelihood, Impact, and Detectability (early/late/never). High-likelihood + high-impact + late-or-never-detected is what actually deserves a mitigation plan; don't spread effort evenly across everything raised.

**5. Convert the top clusters into mitigations, with owners and tripwires.** For each: what reduces the *probability*, what reduces the *damage* if it happens anyway, who owns it, and a stated tripwire ("if we see X, we immediately do Y"). A pre-mortem that changes nothing in the plan wasn't done rigorously enough — write the top mitigations into the actual project plan before the exercise ends, not into a doc that never gets reopened.

**Running it as a live team workshop** adds facilitation mechanics worth being explicit about: 45–90 minutes depending on group size; silent writing stays silent (sticky notes or a shared doc, one cause per note, no talking) for the reason in step 2; dot-voting (a few votes per person) surfaces what the group actually fears faster than debating every cluster to consensus; and if the room can't agree on an owner or a date for a mitigation, that's itself a finding worth naming, not something to gloss over. Close by reconnecting to the actual decision on the table — "given this, do we still commit, adjust, or need more information" — a pre-mortem that never returns to that question hasn't actually informed anything.

## Pre-Mortem vs Post-Mortem

**Pre-mortem** is before: nothing has happened yet, so the question is "what *could* happen" — unlimited imagination, because it's still hypothetical. **Post-mortem** is after: something already happened, so the question is "what *did* happen" — limited to actual events, used to capture lessons for next time. If a request describes something already shipped, running, or decided, that's a signal to say so and redirect — either to a post-mortem (if something concluded, well or badly) or to naming what *upcoming* decision would actually be the right pre-mortem target.

## Skill Boundaries

**Does well:** structuring the exercise solo or as a team facilitation; prompting for specific, varied failure modes instead of vague risk statements; turning what's raised into an owned, prioritized mitigation plan; recognizing when a request doesn't actually call for this technique.

**Can't do:** supply the real domain-specific risks — it structures the exercise, you and your team supply the content; replace running it with actual stakeholders, since a solo pass misses what only other people in the room would raise; guarantee a risk gets caught — it raises the odds, per Klein's research, it doesn't make them certain.

## References

- Klein, Gary. "Performing a Project Premortem." *Harvard Business Review* (2007)
- Klein, Gary. *Sources of Power: How People Make Decisions* (1998)
- Kahneman, Daniel. *Thinking, Fast and Slow* (2011) — includes Klein's research
- Heath, Chip & Dan. *Decisive* (2013) — pre-mortem applications

## Related Skills

- [first-principles](../first-principles/) - Challenge assumptions surfaced in pre-mortem
- [six-thinking-hats](../six-thinking-hats/) - Already includes Pre-Mortem as an Extended Black Hat module (own SKILL.md, "Extended Black Hat: Pre-Mortem"), so both skills claim the same trigger ("pre-mortem", "what could go wrong"). A 2026-09-05 blind test (see `CHANGELOG.md`) found no clean winner between the two on ordinary use, but this skill was the only one of three conditions tested that correctly recognized when a request *didn't* call for the technique at all — keep both for now on that evidence, not on the length either one carries.
