---
name: value-proposition-canvas
description: "Use Osterwalder's Value Proposition Canvas to systematically achieve product-market fit by matching your products and services to customer jobs, pains, and gains Use when: **Launching a new product or service** and need to validate the value proposition; **Struggling with product-market fit** and need to diagnose why customers aren't buying; **Repositioning an existing offering** to better meet customer needs; **Entering a new market segment** with different customer requirements; **Developin..."
license: MIT
metadata:
  author: ClawFu
  version: 1.1.0
  mcp-server: "@clawfu/mcp-skills"
---

# Value Proposition Canvas — Design Offerings Customers Actually Want

> Match what you build to what customers are actually trying to do, using Osterwalder's Value Proposition Canvas.

## When to use this

- Launching a new product or service and needing to validate the value proposition
- Diagnosing why an existing offering isn't selling — the canvas locates the mismatch
- Repositioning an offering, or entering a segment with different requirements
- Pricing based on value delivered rather than cost
- Prioritising an MVP feature list against what customers actually value

## Methodology

Alexander Osterwalder, Yves Pigneur, Greg Bernarda, Alan Smith — *Value Proposition Design* (2014), Strategyzer.

Core claim: most new products fail not for lack of functionality, but because they miss what customers actually want. The canvas has two halves that must be built in a specific order.

**Customer Profile** (what customers need): Jobs, Pains, Gains.
**Value Map** (how you create value): Products & Services, Pain Relievers, Gain Creators.
**Fit** is when the second half genuinely addresses the first.

**Golden rule: always build the Customer Profile before the Value Map.** Understand the customer before designing the solution. Doing it the other way round produces a canvas that justifies whatever you already planned to build.

## How to use

```
Help me create a Value Proposition Canvas for my [product/service]. My target customer
is [description]. Walk me through the customer profile first, then the value map.
```

```
My product isn't selling. Use the VPC framework to diagnose why. Here's what we offer:
[product]. Here's who we're targeting: [customer]. Help me find the fit gaps.
```

```
Help me prioritise features for my MVP using the VPC. Potential features: [list].
My target customer's main jobs/pains/gains are: [describe].
```

## The seven steps

### Customer Profile — build this first

**1. Map customer jobs.** The tasks customers are trying to complete, problems they're solving, needs they're satisfying. Three types, and most analysis only catches the first:

| Type | What it is | Ask |
|---|---|---|
| Functional | A practical task with a tangible outcome | "What task are they trying to complete?" |
| Social | How they want to be perceived | "How do they want others to see them?" |
| Emotional | A feeling or state they want | "How do they want to feel?" |

Context changes the job: "manage finances" means different things to a student, a retiree, and a business owner. Rank jobs by importance to the customer, not by how interesting they are to you.

**2. Identify pains.** Anything that annoys customers before, during, or after getting a job done — undesired outcomes ("produces poor results"), obstacles ("I don't have time"), risks ("I could look foolish"), and frustrations ("this is too complicated"). Useful prompts: what do they find too costly in time, money or effort; what current solutions underperform; what risks do they fear; what barriers stop them adopting anything. Rank by severity, extreme to moderate.

**3. Define gains.** The outcomes and benefits customers want. **Gains are not simply the inverse of pains** — this is where most canvases go thin. Four levels:

| Level | Definition | Example |
|---|---|---|
| Required | Must-have or the solution doesn't work | A phone makes calls |
| Expected | Basic expectation | A hotel room is clean |
| Desired | Would love, doesn't expect | Personalised recommendations |
| Unexpected | Beyond imagination — the delighters | A surprise free upgrade |

Ask what savings would make them happy, what would make their life easier, how they measure success, what they dream about. Rank by relevance, essential to nice-to-have.

### Value Map — build this second

**4. List products and services.** Physical, intangible, digital, financial. **These create no value on their own** — only in relation to a specific segment's jobs, pains, and gains. Rank by importance to the proposition.

**5. Design pain relievers.** State exactly how each product kills a specific pain: "takes too long" → how do you save time; "too risky" → how do you eliminate the risk; "makes me look bad" → how do you make them look good. Focus on the *extreme* pains. A reliever for a minor annoyance is not a value proposition.

**6. Create gain creators.** State how each product produces a specific gain, quantified where possible: "save money" → reduce cost by X%; "feel confident" → provide X support; "make life easier" → automate X. Focus on gains that create real difference, not every gain you can name.

**7. Assess fit.** Fit exists when your strongest relievers and creators land on the customer's most important pains and gains. A reasonable bar: you address **50–70% of the top pains and gains**, not all of them.

Three levels, in order — each needs different evidence, and skipping ahead is the classic mistake:

| Level | Definition | Evidence that proves it |
|---|---|---|
| Problem-Solution Fit | Customers care about these jobs/pains/gains | Interviews and surveys confirm the need |
| Product-Market Fit | The product actually creates the value | Traction, sales, retention |
| Business Model Fit | It is profitable and scalable | Unit economics work |

## Red flags that the fit isn't real

- Building features customers never asked for
- Addressing low-priority pains while the severe ones stay unaddressed
- Creating gains customers don't actually value
- No clear differentiation from the alternative they use today
- Pains and gains that were assumed rather than heard from a real customer

## Customer interview questions

The canvas is only as good as the input. These get at each half without leading the witness:

**Jobs** — Walk me through your typical week related to [context]. What are you ultimately trying to achieve? What would you need to accomplish to call this a success?

**Pains** — What's the hardest part about [job]? What frustrates you most about how you do it now? What do you wish you could stop doing? What could go wrong that you worry about?

**Gains** — What would an ideal solution look like? What would make your life significantly easier? How do you measure success here? What would make you look good to [boss/clients/peers]?

**Validation** — How important is solving this, 1 to 10? How are you handling it today? What have you tried that didn't work? Would you pay for a solution, and how much?

## Skill Boundaries

### What This Skill Does Well
- Structuring the customer profile (jobs/pains/gains) against the value map (products/pain relievers/gain creators)
- Testing for fit — whether the value map actually addresses the customer profile it's paired with
- Diagnosing why an existing offering isn't landing, by locating the mismatch

### What This Skill Cannot Do
- Know the real customer without research — it structures the canvas, you (or `customer-insight`) supply the validated insight
- Replace running the value proposition past actual customers
- Guarantee product-market fit — it improves the odds of building the right thing, it doesn't test the market for you

## References

- **Book**: *Value Proposition Design* — Osterwalder, Pigneur, Bernarda, Smith (2014)
- **Related**: *Business Model Generation* (2010)
- **Tools**: Strategyzer.com official canvas templates

## Related Skills

- **jobs-to-be-done-jtbd** - Deep dive into understanding customer jobs
- **positioning** - Position your value proposition in the market
- **customer-insight** - Combines this canvas with JTBD for full discovery-through-design work
