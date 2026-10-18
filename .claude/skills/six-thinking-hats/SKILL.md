---
name: six-thinking-hats
description: >
  Apply Edward de Bono's parallel thinking framework (1985) to examine decisions from six distinct perspectives simultaneously rather than through adversarial debate. Use when making complex decisions that require multiple viewpoints, evaluating strategies or plans before committing, running structured thinking sessions with a team, breaking out of analysis paralysis, or stress-testing an idea before launch. Also includes the Pre-Mortem technique (Gary Klein) as an extended Black Hat module. Trigger on: "six thinking hats", "parallel thinking", "stress-test this plan", "pre-mortem", "imagine this failed", "prospective hindsight", "what will kill this", "what could go wrong", "examine this from all angles", or "help me think through this decision". For a pre-mortem on its own, go straight to the Extended Black Hat module. For an adversarial attack on an argument or decision, use red-team. For strategic options appraisal with recommended action, use multi-actor-strategy instead.
---

# Six Thinking Hats + Pre-Mortem

Structured parallel thinking for decisions, plans, and ideas. Everyone examines the same perspective at the same time — no adversarial debate, no defended positions.

---

## The Six Hats

| Hat | Focus | Core question |
|-----|-------|---------------|
| Blue | Process and control | What are we trying to decide, and how will we think about it? |
| White | Facts and information | What do we know? What are we missing? |
| Red | Emotions and intuition | What does our gut say, without justification? |
| Black | Risks and caution | What could go wrong? Where are the logical flaws? |
| Yellow | Benefits and value | Why will this work? What is the upside? |
| Green | Creativity and alternatives | What else could we do? What assumptions can we challenge? |

---

## Hat Playbooks

### Blue — Process
Start and end every session here. Define the problem and the thinking agenda at the open; summarise findings and name next steps at the close.

Questions: What exactly are we deciding? Which hats do we need, in what order? How long per hat? What is the output?

### White — Facts
Neutral and factual only. No opinions, no judgments — those belong in other hats.

Questions: What data do we have? What facts are confirmed vs assumed? What information is missing? What has happened in comparable situations?

Rule: "Sales were flat last quarter" is White. "The market is declining" is Black. "I think the market is shifting" is Red.

### Red — Emotions
Feelings are valid data. No justification required.

Questions: What is your gut reaction? What excites you? What worries you, even if you can't explain why? If you had to decide right now, what would you do?

Rule: Keep it brief. "Something feels off" is enough — no explanation needed.

### Black — Caution
The most important hat. Protective, not negative. Must be logical, not vague.

Questions: What could go wrong? What are the logical flaws? What constraints or risks have we underestimated? What have we overlooked? What would need to be true for this to fail?

Rule: "This could fail because X" is valid. "I just don't like it" is Red, not Black.

**Extended Black Hat: Pre-Mortem** — see below.

### Yellow — Benefits
Constructive optimism, grounded in logic. Not wishful thinking.

Questions: What are the genuine benefits? Why will this work? What is the best-case scenario and how likely is it? What value does this create?

Rule: Yellow without Black is naive. Black without Yellow is paralysis. Run both.

### Green — Creativity
No judgment during Green. Quantity over quality. Wild ideas welcome.

Questions: What alternatives exist? What is the opposite approach? What would we do if cost were no constraint? How can we solve the Black Hat risks? What assumptions can we reverse?

---

## Standard Hat Sequences

**Evaluating an idea or strategy:**
Blue → White → Red → Yellow → Black → Green → Red → Blue

**Solving a problem:**
Blue → White → Green → Yellow → Black → Red → Blue

**Quick decision (under 10 minutes):**
White (facts only) → Red (gut) → Yellow (upside) → Black (risk) → Blue (decide)

**Planning a project:**
Blue → White → Green (options) → Yellow → Black → Green (mitigations) → Blue

---

## Extended Black Hat: Pre-Mortem

*Gary Klein's prospective hindsight technique. Run this when a plan has been agreed but before resources are committed — or whenever the team is overconfident.*

### Why it works

Imagining that an event has already happened dramatically improves the ability to identify why it happened. The future feels distant; the past feels concrete. By placing the team inside a failure scenario, you unlock concerns people might hesitate to raise in a forward-looking planning session.

Research by Mitchell, Russo and Pennington (1989), which Klein builds on, found prospective hindsight raised the ability to identify reasons for an outcome by about 30%.

### When to run it

- Before launching any significant initiative
- Before committing budget or team capacity
- When the team is unanimously confident (a warning sign)
- When risks feel vague rather than named

**Not for something that already happened.** A pre-mortem interrogates a *pending* decision while the plan can still change cheaply. If the thing has shipped or the decision is executed, say so and redirect: to a design or security review if it is live, to a post-mortem ("what *did* happen", limited to real events) if something concluded, or to the *upcoming* decision that is the right target. Assumptions the pre-mortem surfaces can go to `first-principles`.

### How to run it

**Step 1 — Set the scenario**

> "It is [date 12 months from now]. This project has failed — not just underperformed, but failed badly. The results are in and they are clearly bad. We are now looking back and asking: what happened?"

Failure is not a possibility in this exercise — it is a fact. The team's job is to explain it.

**Step 2 — Generate failure causes**

Each person writes down independently, without discussion, their top 3–5 causes of the failure. Allow 5–10 minutes. Silence is essential — social contagion from the first person to speak will suppress divergent causes. **Running it solo:** write causes from each failure category below in turn, as if each were a different person, before you rank any of them.

Failure mode prompts:
- What assumptions turned out to be wrong?
- What dependencies did we underestimate?
- What did the team avoid discussing because it was uncomfortable?
- What external event made everything harder?
- What did we execute poorly even though we knew the risk?
- What did a competitor, regulator, or stakeholder do that we didn't anticipate?
- Where did team capacity, skills, or coordination fail?

**Step 3 — Aggregate and cluster**

Share causes without attribution, one at a time, no debate yet. Group into themes. Rate each cluster on Likelihood, Impact and Detectability (early, late or never). High likelihood, high impact and late-or-never detection is what earns a mitigation; don't spread effort evenly.

**Step 4 — Convert to mitigations**

For each high-priority cluster: what would reduce its probability, what would reduce its impact if it occurs anyway, who owns it, and a tripwire ("if we see X, we immediately do Y").

**Step 5 — Update the plan**

Add the top 3 mitigations to the project plan with owners and timelines. A pre-mortem that produces no plan changes was not done rigorously enough. Close by returning to the decision: given this, do we commit, adjust, or need more information?

**As a live workshop:** allow 45–90 minutes. Keep the silent writing silent (one cause per sticky note or line in a shared doc). Dot-vote clusters rather than debating each to consensus. If the room can't agree an owner or a date for a mitigation, name that as a finding.

**Limits:** it structures the exercise; the people in the room supply the real risks. A solo pass misses what only others would raise. Sources: Klein, "Performing a Project Premortem", *HBR* (2007); Klein, *Sources of Power* (1998); Kahneman, *Thinking, Fast and Slow* (2011); Heath & Heath, *Decisive* (2013).

---

## Facilitation Notes

**In a group session:**
- Everyone wears the same hat at the same time — parallel thinking, not debate
- Announce hat switches explicitly: "We're moving to Black Hat now"
- Redirect off-hat comments: "That's a Black Hat observation — let's hold it until we get there"
- Red Hat feelings need no justification from the speaker — the group's job is to listen, not challenge
- Keep time per hat visible

**Common failure modes:**
- Skipping Red Hat (emotions surface anyway — better to name them)
- Too long on Black Hat (useful caution becomes spiralling negativity — move to Green)
- Mixing hats (evaluating during Green Hat kills creative momentum)
- Pre-mortem without silence in Step 2 (group-think produces surface-level causes)

---

## Quick Reference Prompts

```
Apply Six Thinking Hats to: [decision / plan / idea]
Go through each hat systematically with specific questions for our context.

Run a Pre-Mortem on: [project / plan]
Assume it is 12 months from now and this has failed. What went wrong?

Focus on Black Hat + Pre-Mortem for: [plan]
I want to surface every way this could go wrong before we commit.

Run a quick 5-hat decision on: [choice]
I need a decision in under 10 minutes.
```
