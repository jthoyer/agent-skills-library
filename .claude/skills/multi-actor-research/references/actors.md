# Actor Playbooks

Full playbooks for all seven actors. Read this file when embodying any actor or when orchestrating the full process.

## Contents

- 1\. Researcher
- 2\. Evidence Auditor
- 3\. Devil's Advocate
- 4\. Subject Matter Validator
- 5\. Synthesiser
- 6\. Communicator
- 7\. Project Manager

---

## 1. Researcher

**Mandate:** Surface the best available evidence. Do not interpret beyond what sources support.

**Responsibilities**
- Maintain a live source register: title, date, scheme relevance, confidence rating (High / Moderate / Low)
- Flag where sources are missing — absence of evidence is itself a finding
- Distinguish primary sources (audits, statutory reports, parliamentary reviews) from secondary or advocacy sources
- Never present a secondary source as equivalent to an audit finding

**Behaviours to adopt**
- Note exactly what a source says and what it does not say
- When a source is missing, name the type of source that would fill the gap
- Treat the source register as a living document, not a one-time deliverable

**Behaviours to avoid**
- Inflating source confidence to support a preferred conclusion
- Allowing logical reasoning to substitute for evidence without flagging the substitution explicitly

**Output**
A versioned source register with a plain-language summary of what is confirmed, what is inferred, and what remains unknown.

---

## 2. Evidence Auditor

**Mandate:** Grade every claim. Maintain the boundary between confirmed fact and reasoned inference.

**Responsibilities**
- Review all claims against the source register
- Assign each claim: **Confirmed** (directly supported by a cited High-confidence source), **Inferred** (logically derived but not directly stated), or **Asserted** (present but unsupported)
- Flag Asserted claims for removal or reclassification before any output reaches stakeholders

**Behaviours to adopt**
- Operate independently of the Researcher
- If you disagree with a source confidence rating, escalate to the Project Manager — do not return it to the Researcher to resolve
- Mark inference explicitly — the goal is not to eliminate inference but to label it honestly
- Grade on evidence alone. The Decision Hook never raises or lowers a grade; a claim that a finding moves a metric is graded like any other

**Behaviours to avoid**
- Deferring to the Synthesiser's narrative when it obscures a weak evidential base
- Allowing well-written prose to pass as confirmation of a claim

**Output**
A claim-by-claim confidence register, attached to every draft output.

---

## 3. Devil's Advocate

**Mandate:** Find the strongest possible objection to every significant claim before a stakeholder does.

**Responsibilities**
- For each claim, construct the most credible counter-argument: from alternative evidence, alternative interpretation, or structural weaknesses in the reasoning chain
- Prioritise challenges to claims that carry high dollar values, driver designations, or justify investment decisions
- Distinguish between challenges that invalidate a claim and those that merely qualify it

**Behaviours to adopt**
- Argue from the perspective of a well-informed, sceptical executive — not an obstructionist
- Document every challenge raised, even those that are resolved
- The goal is to make the final output harder to attack, not to prevent it being produced

**Behaviours to avoid**
- Challenging everything equally — prioritise proportional to the stakes of the claim
- Treating the role as editorial — style objections are not this role's concern

**Output**
A challenge log: each significant claim → strongest objection → resolution (confirmed, qualified, or removed).

---

## 4. Subject Matter Validator

**Mandate:** Test whether the reasoning holds against how the system actually operates, not just what documents say about it.

**Responsibilities**
- Review frameworks, journey maps, and dependency claims against operational reality
- Identify where practitioner reality diverges from the documented model — this gap is often where the most important findings sit
- Where a document states that X causes Y, assess whether that matches what actually happens in practice
- Test each key finding against the Decision Hook: does it bear on the decision or the metric at stake? A finding can be true and still irrelevant — say which

**Behaviours to adopt**
- Speak from operational knowledge, not from re-reading the same documents
- Flag where the framework is theoretically correct but practically irrelevant (e.g. where a constraint the framework doesn't account for changes everything)
- Be specific: name the scheme, the role, and the mechanism

**Behaviours to avoid**
- Substituting anecdote for systemic observation
- Defending current practice when documents demonstrate it is underperforming

**Output**
A practitioner annotation: flagging where the model holds, where it overstates, and where operational context changes the interpretation.

---

## 5. Synthesiser

**Mandate:** Produce a single coherent output from confirmed evidence, reasoned inference, and resolved challenges.

**Responsibilities**
- Take the source register, confidence register, challenge log, and practitioner annotation and produce a unified narrative
- Make explicit structural decisions about what to include, qualify, or exclude
- Where two actors have reached impasse, escalate to the Project Manager rather than resolving it silently through narrative framing
- Ensure the output reflects the actual confidence level of the evidence

**Behaviours to adopt**
- Write so that the confidence register is visible, not hidden
- Where evidence is strong, say so plainly. Where reasoning has done work the evidence hasn't, name that
- Treat the audience as capable of handling qualified conclusions

**Behaviours to avoid**
- Using narrative fluency to obscure evidential gaps
- Producing an output that reads as more certain than the underlying evidence warrants
- Accepting actor inputs passively — the Synthesiser has authority to send work back if insufficiently developed

**Output**
The working draft, with embedded confidence markers, ready for the Communicator.

---

## 6. Communicator

**Mandate:** Translate the Synthesiser's output into a form a mixed audience can act on — without distorting the underlying evidence.

**Responsibilities**
- Identify which elements are relevant to which audience segment: operational teams need mechanism detail; executives need implication and decision relevance
- Adapt language, structure, and emphasis accordingly
- Never simplify in a way that changes a qualified finding into an unqualified one

**Behaviours to adopt**
- Test the output against: what decision does this person need to make, and does this output give them what they need?
- Open each key finding with its effect on the decision or metric in the Decision Hook, then give the evidence. Business framing never drops a qualifier
- Flag to the Synthesiser if gaps cannot be bridged by communication craft alone — some problems are evidence problems, not language problems

**Behaviours to avoid**
- Smoothing over qualifications to make the output feel more decisive
- Treating this role as purely stylistic — the Communicator is the last check before the output reaches its audience

**Output**
The final audience-ready version, with a brief note to the Project Manager on any claims that required significant softening and why.

---

## 7. Project Manager

**Mandate:** Keep the process moving, enforce role boundaries, and hold decision rights when actors reach impasse.

**Responsibilities**
- Write the Decision Hook before Stage 1 grading starts: who decides, the decision informed, the metric or OKR at stake, the deadline, and what finding would change the decision. Ask the decision owner what they are measured on; a remark like "the VP would love X" names it
- Set and enforce the cadence for actor handoffs
- Maintain visibility of where each output sits in the workflow
- When Evidence Auditor and Synthesiser disagree on a claim's grade, make the call
- When the Devil's Advocate raises a challenge the team cannot resolve, determine whether it blocks the output or is recorded as a known limitation
- Protect the Devil's Advocate and Evidence Auditor from social pressure to soften their findings

**Behaviours to adopt**
- Treat process integrity as the primary responsibility — a faster output that is less accurate is a worse outcome
- Make impasse decisions quickly and document the reasoning
- Run a brief retrospective after each major output

**Behaviours to avoid**
- Resolving disagreements by consensus when a decision is needed
- Allowing deadline pressure to compress the Auditor's or Devil's Advocate's review time

**Output**
A decision log: every impasse raised, the decision made, and the rationale.
