# Section Prompts — PRD Generation

Use these prompts to generate each PRD section from structured inputs. Provide the answers, then ask Claude to draft the section.

---

## Section 1: Context and Problem

**Prompt:**
> "Give me: (1) What situation or trend led to this work being scoped? (2) In one or two sentences: who is affected, what is broken or missing, and why does it matter? (3) Why is this being addressed now rather than earlier or later? (4) What evidence — data, research, support tickets, user interviews — exists that this is a real problem? I'll draft the context and problem section."

**Quality bar:** After reading the draft, someone who was not in any prior meeting should be able to describe the problem — and why it matters — in their own words.

---

## Section 2: Goals and Success Metrics

**Prompt:**
> "Give me: (1) What business outcome does this contribute to? (2) What does success look like for the user — what will they be able to do or feel that they can't today? (3) Name 2–4 measurable indicators. For each, what is the current baseline and what is the target? (4) What metric should *not* get worse as a result of this work? I'll draft the goals and metrics section."

**Quality bar:** Every metric has a baseline, a target, and a timeframe. No metric contains the word "improve," "increase," or "better" without a number.

---

## Section 3: User and Customer Context

**Prompt:**
> "Give me: (1) Who is the primary user — be specific about role, context, and what they're trying to accomplish. (2) What are the top 3 things they are trying to get done in this context? (3) What are the top 3 things making that hard today? (4) What would success feel like for them — what changes in their experience? (5) Is there a secondary user or someone else affected by this product? I'll draft the user context section. If you have a completed Value Proposition Canvas, share the top pains and gains and I'll import them directly."

---

## Section 4: Solution Overview

**Prompt:**
> "Give me: (1) In 2–4 sentences, what will be built? (2) What are the 2–3 core things a user will be able to do that they can't do today? (3) What is this solution explicitly *not* doing — what is out of scope in the experience itself? (4) Are there any known design constraints — accessibility requirements, consistency with existing patterns, specific interaction principles? I'll draft the solution overview."

**Quality bar:** Engineering and design could independently sketch a rough approach and their sketches would not contradict each other.

---

## Section 5: Functional Requirements

**Prompt:**
> "For each requirement you want to capture, give me: (1) What must be true — describe it from the user's perspective. (2) Given [what context], when [what action], what should happen? (3) Is this a must-have, should-have, or could-have? I'll format each as a requirement with an acceptance criterion and a MoSCoW priority."

**Tip:** Do requirements one at a time if there are fewer than 10. For larger sets, group by user flow first, then generate.

---

## Section 6: Non-Functional Requirements

**Prompt:**
> "Tell me which of these apply to your product, and at what level: (1) Performance — how many concurrent users, what response time is acceptable? (2) Accessibility — what standard must this meet? (3) Security — what data is handled, what authentication is required? (4) Compliance — any regulatory or policy constraints? (5) Browser or device support — what environments must this work in? I'll draft the non-functional requirements section."

---

## Section 7: Out of Scope

**Prompt:**
> "Give me: (1) A list of features or capabilities that stakeholders asked for but are not in this PRD. (2) For each: why is it out of scope — is it deferred, out of product scope entirely, or dependent on something else? (3) Is there anything the team decided not to do that wasn't explicitly requested but might be assumed? I'll format the out-of-scope section."

---

## Section 8: Dependencies and Risks

**Prompt:**
> "Give me: (1) What other work, decisions, or inputs must be in place before this can be built or launched? For each: who owns it, and when is it needed? (2) What could prevent successful delivery — technical, organisational, or external risks? (3) For each risk: how likely is it, how severe would the impact be, and what is the proposed response — mitigate, accept, or escalate? I'll draft the dependencies and risks section."

---

## Section 9: Rollout and Measurement

**Prompt:**
> "Give me: (1) How will this reach users — full launch, staged rollout, feature flag, pilot group? (2) What needs to be true before launch — support readiness, communications, training, legal sign-off? (3) What metrics will you track in the first 30, 60, and 90 days? What tool will you use to track them, and who reviews the data? (4) How will you collect user feedback after launch, and who acts on it? I'll draft the rollout and measurement section."

---

## Section 10: Open Questions

**Prompt:**
> "Give me a list of things that are unresolved and need to be decided before the team can proceed with confidence. For each: (1) What is the question? (2) Why does it matter — what breaks if it isn't answered? (3) Who should own resolving it? (4) By when does it need to be resolved? I'll format the open questions log."

---

## Full PRD Generation Prompt

Use when you want to generate a complete PRD draft in a single pass:

> "I'm going to answer a series of questions. Use them to generate a complete PRD draft following the team's PRD structure. Ready?
>
> 1. What is the product or feature name?
> 2. What stage are we at — discovery, definition, or delivery?
> 3. What is the problem being solved, for whom, and why now?
> 4. What evidence supports this being real?
> 5. What business and user goals should this achieve?
> 6. Who is the primary user and what are their top jobs, pains, and gains?
> 7. What will be built — briefly?
> 8. What are the 3–5 most important functional requirements?
> 9. What is explicitly out of scope?
> 10. What dependencies or risks exist?
> 11. How will success be measured post-launch?
> 12. What is still unresolved?
>
> Flag any section where my answers were insufficient to draft with confidence, and list the additional inputs needed."
