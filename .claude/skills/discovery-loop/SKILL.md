---
name: discovery-loop
description: >
  Weekly product-discovery loop for a live product or feature idea: one outcome, the
  opportunities under it, the riskiest assumptions behind a chosen solution, and the cheapest
  test that measures behaviour, with the pass mark set before it runs. Builds and updates an
  Opportunity Solution Tree and a short loop log. Use when Justin says "should we build this",
  "test this idea first", "what's the riskiest assumption", "opportunity solution tree", "design
  an experiment", "fake door", "how do we validate this", "continuous discovery", or before an
  idea goes to `mc-planner` or a PRD. NOT for turning a body of finished research into ranked
  ideas (use research-to-ideas), understanding customer motivation (use customer-insight),
  attacking a finished plan (use red-team), or choosing between strategic options (use
  multi-actor-strategy).
license: MIT
metadata:
  author: Justin
  version: 1.0.0
---

# Discovery loop

The step between "we've decided this matters" and "build it". It exists because the coding
pipeline builds whatever it is handed, very well, whether or not anyone needs it. One pass of this
loop costs an hour; a feature nobody uses costs weeks and stays in the codebase.

One pass: **outcome → opportunities → solutions → assumptions → test → decide.** Run it weekly
on a live product, or once on a single idea.

---

## When to use / when NOT to use

**Use it when** there is a product or a feature idea and the question is whether, or which, to
build: a club-app feature, a work product change, a new service.

| Intent | Use instead |
|---|---|
| A pile of research to turn into ranked, evidence-graded ideas | `research-to-ideas` (its Stage 8 tests only its top pick, once; this loop is the light, repeatable version) |
| Why customers act as they do; jobs, pains, gains; interview method | `customer-insight` |
| Tear apart a plan or artefact | `red-team` |
| Choose between strategic directions | `multi-actor-strategy` |
| The test passed; now write the requirements | `product-requirement-document`, then `mc-planner` |

---

## 1. Fix one outcome

Write the outcome as one measurable change in behaviour, with a number and a date: "40% of
members book a session through the app by 31 March". Not a feature, not an output.

- **One outcome per tree.** Two outcomes means two trees.
- If no number exists yet, the first test is to get the baseline. Say so.

## 2. Map opportunities, not features

An opportunity is a need, pain or desire, said in the customer's words: "I don't know if the
swim is on when it's windy." Draw them from evidence: interviews, support messages, usage data.

- List 3–7. Group the ones that are the same need in different words.
- Tag each with its source. An opportunity with no source is a guess; mark it **Assumed**.
- Pick the top 2–3 by size (how many people, how often) and fit with the outcome.

For interviews, use `customer-insight` (timeline method). Don't ask people what they want.

## 3. Generate at least three solutions per opportunity

The first idea is rarely the best. For each chosen opportunity, write three or more solutions,
from three angles: what the user sees (design), what it costs to build (engineering), and what it
does for the outcome (product). Include one that needs no code at all.

## 4. Find the riskiest assumptions

For the leading solution, list what must be true for it to work. Check all four risks:

| Risk | The question |
|---|---|
| **Value** | Will people use it, or pay for it? |
| **Usability** | Can they work out how? |
| **Feasibility** | Can we build it with what we have? |
| **Viability** | Does it work for the club or business: cost, rules, volunteers, brand? |

Then place each assumption on two axes:

- **Impact:** if this is false, does the solution fail?
- **Evidence:** how much do we already know? (none / some / strong)

| | Little evidence | Strong evidence |
|---|---|---|
| **High impact** | **Test now.** These are the leap-of-faith assumptions | Proceed; note the evidence |
| **Low impact** | Park it; revisit if it grows | Ignore |

Test the top one or two only. Testing everything is how discovery turns into delay.

## 5. Design the cheapest test that measures behaviour

People are poor judges of what they will do. A test reads what they **do**: a click, a sign-up,
a booking, money. A survey asking "would you use this?" is not a test of value.

Read `references/experiments.md` for the menu of methods by risk type, the cost of each, and the
traps.

Write every test as a card, **before** it runs:

```
Assumption:   <what we believe, in one line>
Method:       <what we will do>
Metric:       <the one behaviour we will count>
Pass mark:    <the number that means "true", set now>
Kill mark:    <the number that means "false", set now>
Duration:     <how long, or how many people>
Decision:     <what we do on pass / on kill / in between>
```

Two rules hold every card honest:

- **Set the pass and kill marks before the test starts.** A mark chosen after seeing the data
  will always be met.
- **Name the decision it changes.** If both results lead to the same action, don't run it.

## 6. Decide, then log it

When the test ends, compare the result with the card. Record one of three outcomes:
**Pass** (build, or test the next assumption), **Kill** (drop the solution, try the next one),
**Unclear** (the test was too small or too noisy; say what to change, don't round up).

Keep a loop log so next week's pass starts from this one, not from memory:

```
## YYYY-MM-DD — <outcome>
- Tree: <outcome> → <opportunity> → <solution>
- Assumption tested: <one line>
- Result: <metric value> vs pass <x> / kill <y> → Pass | Kill | Unclear
- Decision: <what changes>
- Next: <the next riskiest assumption, or "ready for PRD">
```

Save it next to the product's other docs (for an app, in its repo). The log is the evidence a
later PRD cites.

---

## Output

For a first pass, return:

1. The tree, as an indented list: outcome → opportunities (with source tags) → solutions.
2. The assumption table for the leading solution, with the test-now cell named.
3. One or two test cards, complete, with marks set.
4. The loop log entry to save.

Keep it to one screen where you can. A tree that needs scrolling has too many branches; prune.

## Checks before returning

- [ ] One outcome, with a number and a date (or a baseline test).
- [ ] Every opportunity has a source tag or is marked Assumed.
- [ ] At least three solutions for each chosen opportunity, one with no code.
- [ ] All four risks considered for the leading solution.
- [ ] Every test reads behaviour, has pass and kill marks, and names the decision it changes.

---

## Related Skills

- `customer-insight`: interviews and jobs that feed step 2.
- `research-to-ideas`: the heavy pipeline. Once it has picked an idea, bring that idea here at step 4.
- `product-requirement-document`: what to write once a test passes.
- `red-team`: attack the tree itself when the stakes are high.

*Structure adapted from the `pm-product-discovery` plugin in `phuryn/pm-skills` (MIT, © Paweł
Huryn), drawing on Teresa Torres' Opportunity Solution Tree and Marty Cagan's four risks. Text
rewritten for this library.*
