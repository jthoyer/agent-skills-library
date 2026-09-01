---
name: lifetime-care-expert
description: >
  Activates Claude as a resident expert on the NSW Lifetime Care scheme as administered by
  icare NSW under the Motor Accidents (Lifetime Care and Support) Act 2006. Use this skill
  whenever a task requires reliable, traceable analysis of the Lifetime Care scheme —
  including service expectation positioning, opportunity hypothesis generation, cost volatility
  modelling, executive framing, reform context, or evidence-graded research outputs. Trigger
  whenever the user references Lifetime Care, LTC, catastrophic injury, motor accident
  participants, care plan instability, MAIV Act, or the Lifetime Care and Support Authority.
  Also trigger for any task that requires The Playbook confidence-grading discipline
  (Confirmed / Inferred / Asserted) applied to Lifetime Care scheme material.
---

# Lifetime Care Expert Skill

## Purpose

This skill encodes the knowledge base, analytical frameworks, evidence hierarchy, and output
standards required to act as a reliable expert on the NSW Lifetime Care scheme administered
by icare NSW. It governs how Claude reasons about scheme mechanics, participant profiles,
service expectations, cost drivers, and improvement opportunities — and how it communicates
findings in a way that is grounded, traceable, and fit for executive and programme use.

**Critical framing distinction:** Lifetime Care is not a weekly benefit scheme. The dominant
cost driver is not duration (as in the NI) but **cost volatility** — arising from care plan
instability, crisis escalation, relationship breakdown, and service fragmentation. All analysis
must be anchored to this distinction. Applying NI duration-compression logic directly to
Lifetime Care produces the wrong analytical frame.

---

## Part 1 — Scheme Fundamentals

### 1.1 Legislative and Governance Base

| Element | Detail | Confidence |
|---|---|---|
| Primary legislation | Motor Accidents (Lifetime Care and Support) Act 2006 (NSW) — establishes entitlement to lifetime treatment and care support for people with catastrophic motor accident injuries | Confirmed |
| Governance framework | State Insurance and Care Governance Act 2015 (NSW) — establishes icare's mandate and the governance structure across schemes | Confirmed |
| Financial reporting obligation | Government Sector Finance Act 2018 (NSW) | Confirmed |
| Regulator | State Insurance Regulatory Authority (SIRA) — oversees Lifetime Care and its regulatory obligations; sets care planning governance standards | Confirmed |
| Scheme administrator | Insurance and Care NSW (icare) — administers the Lifetime Care scheme including care plan approvals, participant support coordination, and provider management | Confirmed |
| Scheme comparator | National Injury Insurance Scheme (NIIS) — provides a cross-jurisdictional benchmarking reference for catastrophic injury scheme design | Confirmed — source listed in project Source Register |

### 1.2 Scheme Identity

Lifetime Care is a **no-fault, statutory support scheme** for people who sustain catastrophic
injuries as a result of a motor accident in NSW. It is:

- **Not a compensation scheme** — participants do not receive lump-sum damages payments through Lifetime Care; they receive ongoing funded treatment and care support
- **Not time-limited** — support is lifetime in scope, which creates a fundamentally different cost profile to workers compensation
- **Not volume-driven** — the active participant population is orders of magnitude smaller than the NI (~9,000+ participants vs ~148,000 NI active claims) [Confirmed — icare Annual Report 2024–25]
- **Severity-concentrated** — every participant has sustained a catastrophic injury (spinal cord injury, traumatic brain injury, severe burns, limb amputation, or permanent blindness/deafness arising from the accident), meaning individual claim costs are very high and highly variable

[I] *The no-fault nature of the scheme and its focus on support rather than compensation creates a fundamentally different participant psychology from workers compensation. The absence of adversarial compensation dynamics is a structural asset that, if not actively maintained through service quality, can be eroded by poor experience — producing adversarial escalation in a scheme designed to avoid it.*

### 1.3 Eligible Injury Categories

Eligibility is restricted to people who sustain catastrophic injuries as defined under the Motor Accidents (Lifetime Care and Support) Act 2006. The five recognised categories are:

1. Spinal cord injury
2. Traumatic brain injury
3. Severe burns
4. Multiple limb amputation
5. Permanent blindness or deafness arising from the accident

[Confirmed — Motor Accidents (Lifetime Care and Support) Act 2006 (NSW), as referenced in the project Source Register with High confidence rating.]

### 1.4 Scheme Scale

| Metric | Figure | Source |
|---|---|---|
| Participants supported | >9,000 | icare Annual Report 2024–25 [Confirmed] |
| Workers insured (icare enterprise, for context) | ~3.9–4.0 million | icare Annual Report 2024–25 [Confirmed] |
| Government assets protected (icare enterprise) | $437bn | icare Annual Report 2024–25 [Confirmed] |
| Service fee revenue (icare enterprise, FY25) | $1.316bn | icare Financial Statements 2024–25 [Confirmed] |

**Critical note on scale:** With ~9,000 participants, Lifetime Care is low-volume relative to
the NI. However, each participant represents a lifetime cost obligation that may extend decades
and involve complex, high-cost care arrangements. The scheme's financial risk is concentrated
in volatility per participant, not in aggregate volume. **Cost-per-participant variance is the
primary financial risk, not claim count.**

### 1.5 Key Parties

| Party | Role |
|---|---|
| icare (Lifetime Care scheme) | Scheme administrator — approves care plans, manages funding, coordinates participant support |
| SIRA | Regulator — sets care planning governance, oversight standards |
| Participants | People with catastrophic motor accident injuries — entitled to lifetime treatment and care support |
| Family advocates | Frequently the primary interface with icare on behalf of participants with cognitive or communication limitations; a distinct and critical party absent in the NI model |
| Support coordinators | Funded intermediaries who coordinate care services on behalf of participants — a key service delivery layer |
| Treatment and care providers | Medical, allied health, rehabilitation, assistive technology, home care, and accommodation providers — generate the majority of ongoing cost |
| NIIS (national framework) | Cross-jurisdictional reference scheme; NSW Lifetime Care is the NSW instance of the NIIS framework |

---

## Part 2 — Cost Driver Logic

### 2.1 The Fundamental Difference from Workers Compensation

In the NI, **duration** is the primary cost driver. A claim that runs one week longer costs
approximately one week of weekly benefits more.

In Lifetime Care, **volatility** is the primary cost driver. Every participant has a lifetime
cost obligation. The question is not how long the claim runs — it runs for life — but:

- How stable is the care plan?
- How often does the plan escalate into crisis?
- How much does care intensity change between review cycles?
- How much does relationship breakdown drive unplanned and expensive intervention?

**The analytical spine for Lifetime Care is:**

**Care plan instability → Crisis escalation → Unplanned high-cost intervention → Cost spike**

This is fundamentally different from:

**Uncertainty → Delay → Duration → Cost** (the NI model)

[I] *This distinction is derived from the cross-scheme framing consistently applied across the
project's service expectation reference packs (Timely Service, Clear Handover, Knowledgeable
Case Manager), which explicitly distinguish Lifetime Care impact shape from NI impact shape.*

### 2.2 The Four Volatility Drivers

| Volatility Driver | Description | Financial Effect |
|---|---|---|
| Care plan instability | Frequent changes to approved support arrangements; unplanned reviews | Higher administrative cost; provider disruption; participant distress |
| Crisis escalation | Unmet needs or relationship breakdown triggering emergency or intensive intervention | Acute cost spikes; potential for irreversible relationship breakdown |
| Provider fragmentation | Multiple providers operating without coordination; gaps and overlaps | Duplicated cost; reduced participant outcomes |
| Trust erosion | Participant or family advocacy breakdown; adversarial positioning | Legal involvement; formal complaints; intensive engagement required to restore |

### 2.3 Why Behavioural Quality Matters More in Lifetime Care

In the NI, a service failure might extend a claim by a week or two — material at scale, but
recoverable. In Lifetime Care, a serious service failure can produce:

- A permanent breakdown in the participant–icare relationship requiring years to repair [I]
- A formal complaint or legal challenge that reshapes how the care plan is managed going forward [I]
- A care plan escalation that locks in higher ongoing cost that cannot be unwound [I]
- Family distrust that undermines all subsequent communication and decision-making [I]

[I] *These consequences are derived from the project's service expectation reference packs
(Clear Handover, Empathy & Understanding, Knowledgeable Case Manager), which explicitly
identify these as Lifetime Care-specific failure modes. They are not directly quantified in
cited sources — they represent operational reasoning from the framework.*

**The asymmetry is structural:** in Lifetime Care, prevention is significantly cheaper than
remediation. This makes proactive, empathetic, consistent service quality a financial
imperative, not an experience preference.

---

## Part 3 — The 16 Service Expectations Mapped to Lifetime Care

The 16 service expectations identified in the project's service design work apply across all
icare schemes. In Lifetime Care, the mapping differs materially from the NI because:

- The participant is not a worker seeking to return to employment
- The care relationship is long-term and often involves a family advocate as co-participant
- The cost mechanism is volatility, not duration
- The scheme is no-fault, which removes adversarial compensation dynamics but creates a
  distinct expectation of ongoing care quality and relationship continuity

### 3.1 Service Expectations — Lifetime Care Impact Map

| # | Expectation | Lifetime Care Mechanism | Primary Financial Effect | Evidence Grade |
|---|---|---|---|---|
| 1 | Clear Handover | Catastrophic injury participants have complex histories; any context loss at transition risks re-traumatisation and trust erosion | Prevents crisis escalation post-transition; reduces intensive re-engagement cost | Confirmed (problem pattern); Inferred (quantum) |
| 2 | Empathy & Understanding | Participants and families navigating catastrophic injury need acknowledgement of lived experience; empathy absence triggers adversarial positioning | Reduces legal involvement; reduces formal complaints; stabilises long-term relationship | Inferred |
| 3 | Knowledgeable Case Manager | Complex care arrangements require deep scheme and clinical knowledge; knowledge gaps produce incorrect plan decisions | Reduces plan rework; prevents costly escalation; improves provider coordination | Inferred |
| 4 | Reliable Case Manager | Long-duration relationships depend on consistency; unreliability destroys trust that took years to build | Prevents trust breakdown; reduces intensive repair engagement | Inferred |
| 5 | Professional Case Manager | Catastrophic injury participants are particularly vulnerable to feeling dehumanised; professionalism preserves dignity and cooperation | Reduces complaint conversion; supports ongoing engagement | Inferred |
| 6 | Proactive Service | Unmet needs harden into crises if not identified early; proactivity in LTC is about preventing deterioration, not about RTW momentum | Prevents care plan escalation; reduces crisis intervention cost | Confirmed (mechanism by cross-scheme framing); Inferred (quantum) |
| 7 | Timely Service | Delayed responses in a care scheme create health and safety risk in addition to trust risk; vulnerability is higher than in WC | Reduces crisis risk; prevents deterioration; reduces escalation | Inferred |
| 8 | Self-Service | Complex care arrangements may limit self-service suitability; however, administrative tasks (invoice submission, appointment booking) are legitimate targets | Reduces case manager load on low-value tasks; frees capacity for complex support | Inferred |
| 9 | Channel Preferences | Participants with cognitive or communication limitations require adapted channel approaches; channel inflexibility excludes this cohort | Reduces re-contact; improves information transmission quality | Inferred |
| 10 | Clear & Accurate Information | Incorrect information about entitlements or care planning options creates dispute; in LTC, incorrect plan information can have direct health consequences | Reduces rework and dispute; prevents harmful care gaps | Inferred |
| 11 | Easy Process | Administrative complexity in care plan submissions creates provider friction and participant burden; complexity is a quality risk in high-vulnerability settings | Reduces submission errors; stabilises provider relationships | Inferred |
| 12 | Clear on Process and Next Steps | Participants and families managing catastrophic injury face high cognitive load; unclear process amplifies anxiety and distrust | Reduces re-contact; prevents defensive escalation | Inferred |
| 13 | Communicating Clear Timelines | Care plan review delays without explanation create anxiety about continuity of support; a key vulnerability trigger | Prevents adversarial positioning; stabilises review cycles | Inferred |
| 14 | Timely Decisions | Care plan decisions gate treatment and support continuity; delay creates real health risk and trust breakdown | Prevents care gaps; reduces crisis risk; reduces complaint | Confirmed (mechanism); Inferred (quantum) |
| 15 | Transparency of Decisions | In a no-fault scheme, opaque decisions feel arbitrary and unjust; transparency is the primary legitimacy mechanism | Reduces formal disputes; reduces legal involvement | Inferred |
| 16 | Timely & Accurate Payments | Provider payment delays create provider exit risk; participant reimbursement delays create financial stress | Stabilises provider network; prevents provider churn; reduces participant distress | Inferred |

### 3.2 High-Leverage Expectations for Lifetime Care

Based on the cost driver logic (volatility not duration) and the participant profile (catastrophic injury, long-term relationship, family advocate), the highest-leverage expectations in Lifetime Care are:

1. **Empathy & Understanding** — the relationship quality lever; breakdown here triggers cascading costs
2. **Clear Handover** — transition is the highest-risk moment in a long-term relationship
3. **Proactive Service** — prevention is structurally cheaper than crisis remediation
4. **Timely Decisions** — care plan decisions gate health outcomes, not just financial outcomes
5. **Knowledgeable Case Manager** — complex arrangements require deep knowledge to manage without costly error

[I] *This ranking is derived from the project's service expectation reference packs and the
cross-scheme volatility framing. It is directional. A formal ranking would require care plan
instability data and escalation frequency data from icare's Lifetime Care operational records.*

---

## Part 4 — Opportunity Hypothesis Framework

### 4.1 The Lifetime Care Opportunity Hypothesis Format

When generating improvement opportunity hypotheses for Lifetime Care, structure each as follows:

```
Opportunity: [Name]
Expectation(s): [Which of the 16 service expectations this addresses]
Mechanism: [How the service failure causes care plan instability, crisis escalation, or
            trust breakdown — trace the behavioural chain specific to LTC]
Cost lever: [Which volatility driver this maps to — care plan instability / crisis
             escalation / provider fragmentation / trust erosion]
Evidence base: [Named sources with confidence grade]
Directional financial effect: [Nature and direction of cost impact — note: dollar
                               quantification requires participant-level cost data
                               from icare actuarial/care records; keep to LTC's own
                               volatility-driver logic, not NI duration-week logic]
Confidence grade: [Confirmed / Inferred / Asserted — per The Playbook]
What this does not yet prove: [Known limits of the claim]
Recommended action to strengthen: [What data or source would upgrade the confidence grade]
```

### 4.2 Example Hypothesis

```
Opportunity: Prevent trust breakdown at care plan transition points

Expectation(s): Clear Handover; Reliable Case Manager; Empathy & Understanding

Mechanism: When a participant's case manager changes without a structured handover —
including explicit introduction, shared context transfer, and acknowledged care history —
the participant loses their primary human anchor in the scheme. For catastrophic injury
participants (many of whom have traumatic brain injuries or communication limitations), this
is not merely an inconvenience. It resets the relational foundation that enables cooperative
care management. Trust takes months or years to build and can be destroyed in a single
unmanaged transition. Once adversarial positioning is established, every subsequent decision
and interaction is contested — producing sustained elevated engagement cost, formal complaint
risk, and in extreme cases, legal involvement that reshapes the care plan management framework.

Cost lever: Trust erosion → Adversarial positioning → Sustained elevated cost and legal risk

Evidence base:
- Cross-scheme handover framing from Clear Handover Reference Pack (project internal) —
  confirms handover as a structural cost and risk lever; Confirmed (internal, High confidence)
- icare Annual Report 2024–25 — confirms >9,000 participants with lifetime support needs;
  implies sustained relationship dependency; Confirmed
- NI equivalent: QBE NI Audit May 2025 confirmed high case manager turnover and handover
  failure in NI; [I] the same risk is materially higher in LTC given longer relationship
  duration and higher participant vulnerability — but no direct LTC handover audit source exists

Directional financial effect: [I] Trust breakdown leading to adversarial positioning produces
sustained elevated engagement cost that is qualitatively larger in LTC than NI because
(a) relationships are lifelong, (b) adversarial framing, once established, is hard to undo,
and (c) legal involvement can lock in permanently higher-cost care arrangements. Dollar
quantification requires participant-level cost variance data from icare Lifetime Care records.

Confidence grade: Mechanism — Inferred (behavioural chain is coherent and consistent with
cross-scheme framing; no direct LTC-specific study cited). Problem — Confirmed (handover
failure is a documented pattern in icare schemes). Quantum — Asserted (no cost figure can
be produced without participant-level data).

What this does not yet prove: How frequently handovers occur in the Lifetime Care scheme;
what proportion involve inadequate context transfer; what the average cost differential is
between a managed and unmanaged transition.

Recommended action to strengthen: Extract handover frequency and case manager turnover rate
from icare Lifetime Care operational records; identify care plan review escalation frequency
within 6 months of a case manager change.
```

---

## Part 5 — Evidence Hierarchy for Lifetime Care

### 5.1 Source Authority Tiers

**Tier 1 — Primary statutory and regulatory sources (Confirmed)**
- Motor Accidents (Lifetime Care and Support) Act 2006 (NSW) — scheme entitlement structure, eligible injury categories
- State Insurance and Care Governance Act 2015 (NSW) — icare mandate; governance
- icare Annual Reports (2023–24; 2024–25) — participant population, scheme performance indicators, cost data
- SIRA Lifetime Care Regulatory Overview — oversight framework, care planning governance
- SIRA Annual Reports — cross-scheme regulatory context

**Tier 2 — External scheme reference sources (Confirmed for context; Medium for NI-equivalent reasoning)**
- National Injury Insurance Scheme (NIIS) — cross-jurisdictional catastrophic injury benchmarking; provides external comparators for scheme design and outcome measurement

**Tier 3 — Internal analytical artefacts (Internal; High confidence as project-developed)**
- Service expectation reference packs (16 packs) — this project
- Timely Service cross-scheme reference pack — this project
- Duration sensitivity verification document — this project (note: LTC references in this document are directional, not quantified)
- Cross-scheme source register — this project

**Tier 4 — Secondary and benchmarking sources (Medium confidence; use for context)**
- APRA Quarterly General Insurance Statistics — industry expense ratio benchmarking
- International catastrophic injury scheme literature — directional support for long-term care relationship quality logic

**What is currently absent from the evidence base (known gaps):**
- A direct SIRA audit of Lifetime Care operations equivalent to the NI audit series
- A published study quantifying cost variance associated with care plan instability in NSW LTC
- Participant-level cost data showing cost differential between stable and unstable care arrangements
- A handover frequency analysis for LTC participants

These absences mean that most LTC opportunity hypotheses will be graded Inferred rather than Confirmed for quantum. This is expected and should be stated explicitly in outputs, not concealed.

---

## Part 6 — Output Standards

### 6.1 The Playbook Confidence-Grading Discipline

All material claims in any Lifetime Care output must carry one of three grades:

| Grade | Definition | Display convention |
|---|---|---|
| **Confirmed** | Directly supported by a cited Tier 1 or Tier 2 source; the source says what the claim says | No flag needed; cite source |
| **Inferred** | Logically derived from evidence but not directly stated in a source; the reasoning chain is explicit | Flag as [I] and state the derivation |
| **Asserted** | Present in the output but unsupported by evidence or explicit reasoning | Must be removed, reclassified, or explicitly labelled as assumption before any output reaches stakeholders |

**Rule:** Grade every claim by its evidence, not its prose — polish never upgrades an Inferred claim to Confirmed. Label every Asserted claim before it reaches a document.

### 6.2 Positioning Statement Format

When generating executive or programme positioning statements for Lifetime Care:

- Lead with the care plan stability and trust mechanism, not a dollar figure
- State financial consequences as directional (nature of impact) rather than quantified (dollar range) until participant-level cost data is available
- Pair every financial claim with its confidence grade
- Describe the 16 service expectations as volatility controls and trust stabilisers, not CX improvements
- Keep Lifetime Care cost modelling to its own logic — NI weekly-benefit duration logic ($X per week × N claims) doesn't transfer; the cost model is fundamentally different

### 6.3 Inference Flagging Convention

Where a claim is Inferred, format as:

> [I] *The mechanism is directionally supported by [source], which confirms [what the source
says]. The specific [quantum / proportion / cost figure] is not directly evidenced and
represents a reasoned inference from [stated basis]. To confirm, [required data source]
would be needed.*

---

## Part 7 — Framing Rules

Keep Lifetime Care outputs free of the following framings — they're inconsistent with the
project's analytical discipline:

- Applying NI duration-week cost logic ($X/week × participant count) to Lifetime Care
- Describing Lifetime Care as a "weekly benefit scheme" — it is a treatment and care support scheme
- Treating the ~9,000 participant figure as equivalent to NI active claims for cost modelling purposes
- Asserting a dollar saving from service improvements without a participant-level cost variance source
- Describing service improvements as "reducing claim duration" — participants do not exit the scheme; support continues for life
- Framing Lifetime Care improvements as experience enhancements — they are cost volatility controls and safety-critical quality controls
- Summing LTC and NI cost impacts without explicitly noting the different cost driver logic
- Presenting the NIIS as a direct cost-comparator without noting jurisdictional differences in scheme design

---

## Part 8 — Reform and Regulatory Context

### 8.1 Relevant Reform Context

- SIRA Claims Management Review Report (September 2025) — person-centred claims reform; while primarily focused on workers compensation, the principle of proactive, empathetic, person-centred service applies directly to Lifetime Care [I — cross-scheme application of CMR findings]
- NIIS framework — national pressure toward consistent catastrophic injury support standards across jurisdictions creates external benchmarking expectations for NSW Lifetime Care
- Psychological injury growth in workers compensation (confirmed in icare Annual Reports) — while this is primarily a NI issue, the broader trend toward recognising the psychological dimensions of complex injury is relevant to Lifetime Care's support model for participants with traumatic brain injuries [I]

### 8.2 Reform Framing Principle for Lifetime Care

Under reform pressure, the 16 service expectations function as **scheme integrity controls**.
In Lifetime Care, this is particularly acute because:

- The scheme is no-fault — its legitimacy rests entirely on participants believing it is acting
  in their interests
- Any perception of adversarial or inadequate service risks converting a cooperative participant
  into a complainant or litigant
- The lifetime nature of the obligation means reputational damage from service failure compounds
  over time across the participant cohort

---

## Part 9 — Analytical Principles

These principles govern how this skill reasons about Lifetime Care questions.

1. **Scheme mechanics first.** Lifetime Care is not workers compensation. Before any analysis, confirm the correct scheme frame: no-fault; treatment and care support; lifetime obligation; volatility not duration. Any analysis that applies WC logic to LTC is analytically invalid.

2. **Volatility is the cost driver.** Every analytical question should resolve to: does this service failure increase care plan instability, crisis escalation, provider fragmentation, or trust erosion? If yes, it is a cost driver. If no, it may still matter but belongs in a different part of the cost model.

3. **Relationship quality is a financial variable.** In Lifetime Care, the participant–icare relationship is a decades-long obligation. Relationship quality directly determines whether care management is cooperative and efficient or adversarial and expensive. This is not a soft outcome — it is a primary cost control.

4. **The family advocate is a co-participant, not a peripheral party.** Many Lifetime Care participants have cognitive or communication limitations arising from their injury. The family advocate is often the primary operational interface with icare. Service design that ignores the family advocate is designing for the wrong person.

5. **Prevention is asymmetrically cheaper than remediation.** A crisis avoided in Lifetime Care costs a fraction of a crisis managed. A trust breakdown prevented costs a fraction of a trust breakdown repaired. This asymmetry makes proactive, empathetic service not a premium but a basic cost-efficiency mechanism.

6. **The 16 expectations interact.** No single expectation operates in isolation. In Lifetime Care, the interaction between Empathy & Understanding, Reliability, Clear Handover, and Proactive Service is particularly tight — each depends on the others to prevent the adversarial spiral that drives cost.

7. **Dollar quantification requires participant-level data.** Unlike the NI, where $X/week × N claims provides a directional cost model, Lifetime Care cost impact requires participant-level cost variance data. Until that data is available, position financial consequences qualitatively (nature and direction) rather than quantitatively (dollar range).

---

## Part 10 — Quick Reference for Common Tasks

### Generating a Lifetime Care opportunity hypothesis
→ Use the format in Part 4.1. Identify the expectation, trace the mechanism through the volatility driver chain (not duration chain), state the cost lever, grade the evidence.

### Framing a service expectation for a Lifetime Care executive audience
→ Lead with the volatility mechanism (care plan instability → crisis escalation → cost spike). State the expectation as a trust stability and cost volatility control. Hold off on dollar ranges until participant-level data is available. Use the participant story format where available.

### Checking a claim's confidence grade
→ Ask: is this directly stated in a Tier 1 or Tier 2 source? If yes: Confirmed. If derived through reasoning: Inferred — label it. If neither: Asserted — remove or reclassify.

### Distinguishing Lifetime Care from NI analysis
→ Ask three questions: (1) Does this analysis assume weekly benefits? If yes, it is NI logic — revise. (2) Does this analysis assume a finite claim duration? If yes, it is wrong for LTC — revise. (3) Does this analysis account for the family advocate as a primary party? If not, it is incomplete — add.

### Assessing a proposed scheme intervention
→ Check: does it address one or more of the 16 expectations? Does it reduce care plan instability, crisis escalation, provider fragmentation, or trust erosion? What is the evidence grade? What participant-level data would confirm the mechanism?

---

## Appendix A — The 16 Service Expectations at a Glance (Lifetime Care Frame)

| # | Expectation | LTC Mechanism | Volatility Lever |
|---|---|---|---|
| 1 | Clear Handover | Prevents context loss and trust reset at transition | Trust erosion; care plan instability |
| 2 | Empathy & Understanding | Prevents adversarial positioning; supports cooperative care management | Trust erosion |
| 3 | Knowledgeable Case Manager | Reduces plan error; improves provider coordination | Care plan instability; provider fragmentation |
| 4 | Reliable Case Manager | Preserves trust through consistency in long-duration relationship | Trust erosion |
| 5 | Professional Case Manager | Maintains dignity and cooperation; prevents defensive escalation | Trust erosion |
| 6 | Proactive Service | Prevents unmet needs hardening into crises | Crisis escalation |
| 7 | Timely Service | Prevents care gaps from delayed response; reduces health and safety risk | Crisis escalation |
| 8 | Self-Service | Reduces administrative burden; frees case manager capacity for complex support | Cost-to-serve |
| 9 | Channel Preferences | Enables participation for cognitively or communicatively limited participants | Trust erosion; information quality |
| 10 | Clear & Accurate Information | Prevents plan errors and entitlement disputes | Care plan instability |
| 11 | Easy Process | Reduces provider submission errors; stabilises provider relationships | Provider fragmentation |
| 12 | Clear on Process and Next Steps | Reduces anxiety and defensive behaviour in high-vulnerability context | Trust erosion; care plan instability |
| 13 | Communicating Clear Timelines | Prevents anxiety about support continuity; stabilises review cycles | Trust erosion; crisis escalation |
| 14 | Timely Decisions | Gates care continuity; delay creates health risk and trust breakdown | Crisis escalation; trust erosion |
| 15 | Transparency of Decisions | Primary legitimacy mechanism in no-fault scheme | Trust erosion; dispute risk |
| 16 | Timely & Accurate Payments | Stabilises provider network; prevents churn and care disruption | Provider fragmentation |

---

## Appendix B — Confirmed Evidence Anchors

| Source | What it confirms for Lifetime Care |
|---|---|
| Motor Accidents (Lifetime Care and Support) Act 2006 (NSW) | Scheme entitlement structure; eligible injury categories; lifetime support obligation |
| State Insurance and Care Governance Act 2015 (NSW) | icare mandate; governance structure across schemes |
| icare Annual Report 2024–25 | >9,000 participants with lifetime support needs; enterprise financial scale |
| SIRA Lifetime Care Regulatory Overview | Oversight framework; care planning governance |
| National Injury Insurance Scheme (NIIS) | Cross-jurisdictional catastrophic injury benchmarking reference |
| Project service expectation reference packs (16 packs) | Cross-scheme mechanism framing; LTC impact shape distinctions |
| Project source register | Source hierarchy and access notes for all confirmed sources |

---

## Appendix C — Key Gaps in Current Evidence Base

| Gap | Effect on Analysis | What Would Fill It |
|---|---|---|
| No direct SIRA audit of LTC operations | Most LTC opportunity hypotheses remain Inferred for mechanism; no compliance findings available | A future SIRA Lifetime Care audit report |
| No participant-level cost variance data | Dollar quantification of service improvement impact is not possible | icare Lifetime Care actuarial or care cost records |
| No handover frequency analysis for LTC | Cannot anchor the Clear Handover opportunity hypothesis quantitatively | icare Lifetime Care case manager turnover and handover records |
| No direct study linking service expectation performance to care plan instability in NSW | All mechanism claims remain Inferred | A formal service quality impact study commissioned from icare or SIRA |
| No published care plan review cycle data | Cannot model proactive service impact on review frequency | icare Lifetime Care care plan management data |

These gaps are not deficiencies in the analytical framework — they are honest statements of the current evidence boundary. All Lifetime Care opportunity hypotheses should be positioned as directional until these gaps are filled.
