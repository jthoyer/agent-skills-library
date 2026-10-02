# PRD Failure Modes — Causes and Remedies

The most dangerous PRDs are not the ones that are clearly wrong. They are the ones that look complete but aren't. These are the most common failure modes, their symptoms, and how to fix them.

## Contents

- Failure Mode 1: The PRD Written for the Author
- Failure Mode 2: The PRD with No Measurable Success
- Failure Mode 3: The PRD with Hidden Assumptions
- Failure Mode 4: The PRD Scope Creep Document
- Failure Mode 5: The PRD Shared in the Room
- Failure Mode 6: The PRD That Doesn't Change
- Failure Mode 7: The PRD That Ignored the Customer
- Failure Mode 8: The PRD with No One Accountable

---

## Failure Mode 1: The PRD Written for the Author

**What it looks like:** Dense with context the author already knows. Assumes familiarity with the project history. Uses unexplained acronyms. Assumes the reader was in every meeting.

**Why it happens:** The author wrote to organise their own thinking, not to communicate to others. Writing and thinking are the same activity until they're deliberately separated.

**Symptoms:**
- A new team member cannot understand the problem after reading it
- Engineering asks questions that are answered in the document — because they didn't read it
- Stakeholders ask "but what are we actually building?" after a PRD review

**Remedy:** Before distributing, hand the PRD to someone who was not in any prior meeting. Ask them to describe the problem and the solution in their own words. Fix what they got wrong.

---

## Failure Mode 2: The PRD with No Measurable Success

**What it looks like:** Goals section contains phrases like "improve the user experience," "reduce friction," "make it easier for customers to complete tasks."

**Why it happens:** Measurable targets require committing to a number, which creates accountability. Vague goals avoid that accountability — often without conscious intent.

**Symptoms:**
- Post-launch disagreement about whether the product succeeded
- "We shipped it" is treated as the success criterion
- No retrospective is possible because there's nothing to evaluate against

**Remedy:** Apply the test: can this metric be measured with a number, a baseline, and a timeframe? If not, it is not a success metric. Replace every instance of "improve," "increase," or "better" with a specific claim.

---

## Failure Mode 3: The PRD with Hidden Assumptions

**What it looks like:** Functional requirements are stated as facts. The user context is described with certainty. There are no open questions.

**Why it happens:** Authors conflate confidence with knowledge. The absence of question marks feels like rigour.

**Symptoms:**
- Mid-build discovery that a core assumption was wrong
- Engineering builds the right thing for the wrong user
- Post-launch: "we didn't know users were going to do *that*"

**Remedy:** For every claim in the user context and solution sections, mark it: Confirmed (evidence-backed), Inferred (reasonable extrapolation), or Assumed (no evidence). Assumed items become open questions or explicit risks.

---

## Failure Mode 4: The PRD Scope Creep Document

**What it looks like:** The out-of-scope section is empty or thin. Every stakeholder request made it into the requirements. The MoSCoW column is almost entirely "Must."

**Why it happens:** Saying no is uncomfortable. The PRD becomes a place where every request is accommodated to avoid conflict — and scope balloons.

**Symptoms:**
- The roadmap keeps slipping
- Engineering is always behind
- Stakeholders are confused about why "the simple thing" is taking so long

**Remedy:** The out-of-scope section is not optional. Every stakeholder who asked for something that isn't in the PRD should find it there. Revisit MoSCoW — if more than 40% of requirements are "Must," the prioritisation has not been done honestly.

---

## Failure Mode 5: The PRD Shared in the Room

**What it looks like:** The PRD is shared at the start of a stakeholder session. The first 20 minutes is spent reading it. No time remains for decisions.

**Why it happens:** The author finished the PRD the night before. Sharing in advance feels like extra process.

**Symptoms:**
- Stakeholder sessions consistently run over time
- Decisions are deferred because people "need time to think"
- The same meeting is rescheduled multiple times

**Remedy:** The PRD is a pre-read. Share 48 hours before the session. Label it explicitly: "Please read before the session. We will spend the first 10 minutes on questions, then move to decisions." If stakeholders haven't read it, do not read it aloud — ask them to take 10 minutes to read it now, then run the session.

---

## Failure Mode 6: The PRD That Doesn't Change

**What it looks like:** The PRD written in week 1 is identical to the PRD in week 8. No version history. No change log. New decisions are made in meetings but not captured.

**Why it happens:** Updating a document feels like overhead. The PRD is treated as done once it's approved.

**Symptoms:**
- Team members operate on different versions of the truth
- New team members (or the junior) cannot reconstruct why decisions were made
- The retrospective cannot be done against the original intent

**Remedy:** Treat the PRD as a living document. Add a "Change log" section at the top. Every time a decision is made that changes scope, requirements, or constraints, update the PRD the same day. The junior can own this as a stretch responsibility.

---

## Failure Mode 7: The PRD That Ignored the Customer

**What it looks like:** The user context section is generic. The persona is a demographic description, not a human with specific jobs and pains. The functional requirements do not trace to any user need.

**Why it happens:** Product is built to satisfy internal stakeholders, not customers. The VPC and Lean Canvas were skipped or ignored.

**Symptoms:**
- High build quality; low adoption
- Support volume is higher than expected
- Users use the product in ways it wasn't designed for — which are the ways they actually needed

**Remedy:** Before writing a functional requirement, name the customer job or pain it addresses. If it cannot be linked to the VPC or research output, it is an assumption — mark it as such and validate before building.

---

## Failure Mode 8: The PRD with No One Accountable

**What it looks like:** Open questions have no owners. Dependencies have no named person responsible. The PRD was "approved" by a group, which means no individual is accountable.

**Why it happens:** Distributed ownership feels collaborative. Individual accountability feels uncomfortable.

**Symptoms:**
- Open questions remain open at launch
- Dependencies slip because no one chased them
- When something goes wrong, no one owns the miss

**Remedy:** Every open question has one owner. Every dependency has one owner. The owner's name is in the document. The lead tracks them in the weekly ritual stack. The manager update surfaces any that are at risk.
