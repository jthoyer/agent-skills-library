# PRD Framework Relationships

Moved verbatim from `SKILL.md` on 2026-10-20 to keep the body short.

## Part 2: Framework Relationships

### The Lean Canvas, Value Proposition Canvas, and PRD — Where Each Applies

These three frameworks address different questions at different stages. A PRD written without the prior two is a document built on assumptions.

```
STAGE:        Problem         Solution          Build
              Validation      Definition        Delivery

FRAMEWORK:    Lean Canvas  →  Value Prop    →  PRD
                              Canvas

QUESTION:     Is there a      Does our         What exactly
              problem worth   solution fit      are we building
              solving?        the customer?     and for whom?
```

### What the PRD Inherits from Each Framework

**From the Lean Canvas:**
- The *problem* section (top 3 customer problems)
- The *unique value proposition* — PRD's value statement should not contradict this
- The *unfair advantage* — informs which solution constraints are non-negotiable
- The *key metrics* — PRD success metrics should trace back here

**From the Value Proposition Canvas:**
- Customer jobs, pains, and gains — the PRD's user context section is built from these
- Pain relievers and gain creators — the PRD's feature set should map explicitly to these
- FIT assessment — if VPC fit is unvalidated, the PRD should flag this as a risk

**What the PRD Adds:**
- Functional specificity: *exactly* what gets built
- Acceptance criteria: how the team knows the requirement is met
- Constraints and non-scope: what is explicitly out
- Dependencies: what else must be true for this to work
- Rollout and measurement: how success will be tracked post-launch

### First-Principles Check: Framework Alignment

Before finalising a PRD, run this check:

| Check | Question |
|-------|----------|
| Lean Canvas link | Does every PRD success metric trace to a Lean Canvas metric? |
| VPC link | Does every major feature map to at least one customer pain or gain from the VPC? |
| Contradiction check | Does anything in the PRD contradict the value proposition? |
| Assumption exposure | Which PRD assumptions were validated by prior research, and which are untested? |
