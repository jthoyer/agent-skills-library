---
name: ni-scheme-expert
description: >
  Activates Claude as a resident expert on the NSW Workers Compensation Nominal Insurer (NI)
  scheme as administered by icare NSW. Use this skill whenever a task requires reliable,
  traceable analysis of the NI scheme — including service expectation positioning, opportunity
  hypothesis generation, cost and duration modelling, executive framing, reform context, or
  evidence-graded research outputs. Trigger whenever the user references icare, NI, Nominal
  Insurer, SIRA, CSP performance, weekly benefits, claim duration, service expectations, or
  any of the 16 named service expectations. Also trigger for any task that requires The Playbook
  confidence-grading discipline (Confirmed / Inferred / Asserted) applied to NI scheme material.
---

# NI Scheme Expert Skill

## Purpose

This skill encodes the knowledge base, analytical frameworks, evidence hierarchy, and output standards required to act as a reliable expert on the NSW Workers Compensation Nominal Insurer (NI) scheme. It governs how Claude reasons about scheme mechanics, service expectations, cost drivers, and improvement opportunities — and how it communicates findings in a way that is grounded, traceable, and fit for executive and programme use.

---

## Part 1 — Scheme Fundamentals

### 1.1 Legislative and Governance Base

| Element | Detail | Confidence |
|---|---|---|
| Primary legislation | Workers Compensation Act 1987 (NSW) — governs weekly benefits, liability, step-downs, treatment approvals | Confirmed |
| Governance framework | State Insurance and Care Governance Act 2015 (NSW) — establishes icare's mandate and regulatory structure | Confirmed |
| Financial reporting obligation | Government Sector Finance Act 2018 (NSW) | Confirmed |
| Regulator | State Insurance Regulatory Authority (SIRA) — sets standards, audits compliance, publishes CMR findings | Confirmed |
| Scheme administrator | Insurance and Care NSW (icare) — collects premiums, manages the NI, contracts CSPs | Confirmed |
| Claims delivery | Claims Service Providers (CSPs) — contracted agents who manage claims on behalf of the NI | Confirmed |

### 1.2 Benefit Structure (WCA 1987)

| Phase | Duration | Weekly Benefit Rate | Key Mechanic |
|---|---|---|---|
| Early phase | Weeks 1–13 | 95% of PIAWE | Provisional liability decisions govern this period |
| Mid phase | Weeks 14–130 | 80% of PIAWE | Step-down at week 14 is a behavioural trigger point |
| Long tail | Post week 130 | Lower rate; varies by WPI and capacity | Psychological injury claims dominate this cohort |

**PIAWE** (Pre-Injury Average Weekly Earnings) is the calculation base for all weekly benefits. PIAWE disputes are a known source of rework and duration extension. [Confirmed — SIRA NI Audit March 2023 directly identified PIAWE communication template failures.]

### 1.3 Scheme Scale

| Metric | Figure | Source |
|---|---|---|
| Active claims pool | ~148,000 | SIRA Annual Report 2023–24 [Confirmed] |
| Workers insured | ~3.9–4.0 million | icare Annual Report 2024–25 [Confirmed] |
| Businesses covered | ~340,000 | icare Annual Report 2024–25 [Confirmed] |
| Service fee revenue (FY25) | $1.316bn | icare Financial Statements 2024–25 [Confirmed] |
| Agent remuneration (FY25) | $741m | icare Financial Statements 2024–25 [Confirmed] |
| Indicative average weekly benefit | ~$1,500 per active claim | Indicative only — not verified against icare actuarial reports [Asserted; must be sourced before use in board materials] |

**Critical note on the 148,000 figure:** This is the active claims pool, not the weekly-benefit-bearing subset. Not all active claims receive weekly benefits at any point in time — some are medical-only, some are in dispute, some are in a return-to-work phase. Applying $1,500 × 148,000 overstates the weekly-benefit exposure. The weekly-benefit-active count must be sourced from icare actuarial reports before dollar figures are used in regulatory or reserve submissions.

### 1.4 Key Parties

| Party | Role |
|---|---|
| icare | Scheme owner, premium collector, CSP contract manager, regulator interface |
| CSPs (e.g. Allianz, QBE, GIO, EML) | Claims delivery agents — manage liability decisions, case management, RTW, payments |
| SIRA | Regulator — audits CSPs, sets Standards of Practice, publishes CMR findings |
| Injured workers | Claimants — primary recipients of weekly benefits and treatment approvals |
| Employers | Premium payers, RTW plan participants, WPI process participants |
| Treatment providers | Medical, allied health, and rehabilitation providers — generate approvals and cost |
| Legal representatives | Increasingly involved in psychological injury and disputed claims |

---

## Part 2 — The 16 Service Expectations

These are the worker-facing expectations that anchor the programme. Each expectation has a cost and behavioural mechanism. They are not CX aspirations — they are duration and volatility controls.

### 2.1 Full List

1. Clear Handover — new case manager communicated clearly when a change occurs
2. Empathy & Understanding — case manager acknowledges lived experience of injury
3. Knowledgeable Case Manager — navigates scheme with competence and clarity
4. Reliable Case Manager — does what they say they will do
5. Professional Case Manager — treats the claimant as a person, not a number
6. Proactive Service — anticipates needs and acts early to prevent delay
7. Timely Service — responds to queries within a timeframe that preserves claim momentum
8. Self-Service — enables simple tasks online without case manager dependency
9. Channel Preferences — communication delivered through the claimant's preferred channel
10. Clear & Accurate Information — information that is correct, understandable, and actionable
11. Easy Process — claim interactions are simple and do not require excessive effort
12. Clear on Process and Next Steps — claimant knows where they are and what happens next
13. Communicating Clear Timelines — timelines are stated and updated if delayed
14. Timely Decisions — liability, treatment, and benefit decisions made within appropriate timeframes
15. Transparency of Decisions — reasons behind decisions are clear and understood
16. Timely and Accurate Payments — weekly benefits and reimbursements paid correctly and on time

### 2.2 Behavioural Mechanism (Universal)

All 16 expectations operate through the same mechanism:

**Uncertainty → Delay → Duration → Cost**

- Uncertainty (from unclear information, slow decisions, poor handover) increases cognitive load
- Cognitive load increases defensive or passive behaviour (avoidance, re-contact, escalation)
- Defensive behaviour extends claim duration
- Duration extension in a weekly benefit scheme compounds cost directly

This mechanism is the analytical spine for all opportunity hypothesis generation.

### 2.3 Expectations Mapped to Financial Levers

| Expectation | Mapped Financial Lever | Evidence Grade |
|---|---|---|
| Timely Decisions | Lever 1 — Timely Liability & Treatment Decisions | Confirmed (mechanism); Inferred (quantum) |
| Clear & Accurate Information; Transparency of Decisions | Lever 2 — Clear & Accurate Information | Inferred (mechanism plausible; no direct week-duration study in NSW NI) |
| Proactive Service; Timely Service | Lever 3 — Proactive Case Management | Inferred (SIRA CMR supports direction; quantum unanchored) |
| Clear Handover; Reliable Case Manager | Lever 4 — Continuity of Ownership | Confirmed (problem — QBE NI Audit May 2025); Inferred (quantum) |
| Empathy, Knowledgeable CM, Professional CM, Reliability | Not mapped in current duration model | Gap — affect RTW motivation and engagement; not yet modelled financially |
| Self-Service; Channel Preferences; Easy Process | Not mapped to duration model | Primarily affect cost-to-serve and contact volumes |

---

## Part 3 — Duration Sensitivity Model

### 3.1 Framework

The model estimates how improvements in specific service expectations translate into claim duration reductions (in weeks) and the corresponding impact on weekly benefit exposure.

**Core formula:** Benefit weeks avoided × average weekly benefit rate = directional cost impact

**Base assumptions (as verified):**

| Assumption | Status |
|---|---|
| 148,000 active claims | Confirmed — SIRA Annual Report 2023–24 |
| ~$1,500 average weekly benefit | Indicative only — not verified; treat as illustrative |
| All 148,000 are weekly-benefit-bearing | Not confirmed — overstates denominator; correct before board use |
| Service improvements apply uniformly | Not operationally credible — affected-cohort proportions required |

### 3.2 Four Levers — Summary

**Lever 1 — Timely Decisions**
- Mechanism: liability decision delays extend weekly benefit continuation unnecessarily
- Directional impact: $110m–$333m (0.5–1.5 week average delay reduction)
- Grade: Mechanism Confirmed; quantum Inferred; affected-cohort proportion Asserted
- Key limit: 1-week delay cut across all 148,000 claims is extreme — liability decisions are made once at claim commencement, not continuously. Reframe as targeted reduction on the late-decision cohort only.

**Lever 2 — Clear & Accurate Information**
- Mechanism: unclear information creates rework cycles (e.g. disputed PIAWE) that extend administrative active period
- Directional impact: $55m–$111m (1-week rework reduction on 25% of claims)
- Grade: Mechanism Inferred; quantum Asserted
- Key limit: no NSW NI study directly links documentation improvement to week-duration reduction; rework rate baseline does not exist in cited sources

**Lever 3 — Proactive Case Management**
- Mechanism: early intervention reduces drift into high-duration long-tail cohort
- Directional impact: $88m–$350m (4-week reduction on 10% of mid-phase claims)
- Grade: Mechanism Confirmed by SIRA CMR and SOP 34; quantum Inferred; upper bound internally inconsistent
- Key limit: 4-week saving on 10% of mid-phase claims is indicative; psychological claims have disproportionate leverage but are hardest to manage proactively

**Lever 4 — Continuity of Ownership**
- Mechanism: reducing handovers prevents duration resets caused by context loss and re-establishing trust
- Directional impact: $111m–$333m (25% handover reduction, 2-week saving per avoided handover)
- Grade: Problem Confirmed (QBE NI Audit May 2025); quantum Asserted — handover frequency not published
- Key limit: 2-week saving per handover is operationally plausible but not directly measured; requires CSP operational data

### 3.3 Aggregate Sensitivity Band

| Lever | Sensitivity (weeks) | Directional Impact ($m) |
|---|---|---|
| Timely Decisions | -0.5 to -1.5 weeks | $110m–$333m |
| Clear & Accurate Info | -0.5 to -1 week | $55m–$111m |
| Proactive CM | -1 to -4 weeks (mid-phase) | $88m–$350m |
| Continuity of Ownership | -1 to -3 weeks per affected claim | $111m–$333m |

**Scale insight:** In a scheme with ~148,000 active claims, even a fraction-of-a-week average duration shift produces material cashflow exposure change. The leverage of small behavioural improvements is structural, not marginal.

### 3.4 Known Model Limitations (Playbook-grade)

1. **Additive stacking without deduplication** — levers overlap across claim populations; aggregate cannot be summed linearly
2. **No time-value discounting** — weeks avoided in year 3 are worth less than weeks avoided in week 2; cashflow timing must be specified for reserve-impact analysis
3. **$1,500 rate unverified** — all dollar figures are illustrative until confirmed from actuarial reports
4. **Behavioural lag not modelled** — service improvements affect newly lodged claims first; legacy active pool changes gradually
5. **Psychological vs physical claims not separated** — psychological claims have materially higher durations, lower RTW rates, and require separate modelling

---

## Part 4 — Evidence Hierarchy for the NI

### 4.1 Source Authority Tiers

**Tier 1 — Primary regulatory and statutory sources (Confirmed)**
- SIRA Annual Reports (most recently 2023–24) — scheme performance, claim volumes, dispute trends
- icare Annual Reports (2023–24; 2024–25) — NI financial performance, RTW rates, psychological injury data, cost drivers
- SIRA Claims Management Review Report (September 2025) — person-centred reform agenda, early intervention recommendations
- SIRA NI Audit Reports (series: Jan 2023, Mar 2023, May 2025 QBE NI) — compliance findings, PIAWE failures, handover risk, early intervention gaps
- Workers Compensation Act 1987 — benefit structure, step-downs, provisional liability timeframes
- State Insurance and Care Governance Act 2015 — icare mandate, governance
- Independent Review of icare and SICG Act — systemic context, governance reform

**Tier 2 — icare operational and financial data (Confirmed where cited)**
- icare Financial Statements — service fee revenue, agent remuneration, operating expenses
- CSP Quarterly Performance Dashboards — liability decision timeliness by CSP, RTW rates

**Tier 3 — Analytical artefacts (Internal; High confidence as internally developed)**
- Duration Sensitivity Scenario Model — this project
- Playbook verification document — this project
- Service expectation reference packs (16 packs) — this project
- 90-day embedment plan — this project
- 16×16 influence matrix — this project

**Tier 4 — Secondary sources (Medium confidence; use for context, not primary evidence)**
- NIBA press releases on SIRA CMR findings
- APRA Quarterly General Insurance Statistics (industry benchmarking)
- International workers compensation literature on early intervention

### 4.2 Source Access Notes

- SIRA CMR Report PDF returned a 403 access error during verification in February 2026. Summary findings accessed via SIRA and NIBA press releases (secondary sources). Full report should be consulted directly before any primary citation.
- icare Annual Reports are accessible at: https://www.icare.nsw.gov.au/about-us/annual-reports
- SIRA Annual Report 2023–24: https://www.sira.nsw.gov.au/__data/assets/pdf_file/0004/1336999/SIRA_Annual-Report-2023-24.pdf

---

## Part 5 — Output Standards

### 5.1 The Playbook Confidence-Grading Discipline

All material claims in any NI scheme output must carry one of three grades:

| Grade | Definition | Display convention |
|---|---|---|
| **Confirmed** | Directly supported by a cited Tier 1 or Tier 2 source; the source says what the claim says | No flag needed; cite source |
| **Inferred** | Logically derived from evidence but not directly stated in a source; the reasoning chain is explicit | Flag as [I] and state the derivation |
| **Asserted** | Present in the output but unsupported by evidence or explicit reasoning | Must be removed, reclassified, or explicitly labelled as assumption before any output reaches stakeholders |

**Rule:** Never allow well-written prose to upgrade an Inferred claim to Confirmed. Never allow an Asserted claim to pass into a document without being labelled.

### 5.2 Opportunity Hypothesis Format

When generating improvement opportunity hypotheses for the NI scheme, structure each as follows:

```
Opportunity: [Name]
Expectation(s): [Which of the 16 service expectations this addresses]
Mechanism: [How the service failure causes duration or cost extension — trace the behavioural chain]
Lever: [Which of the four financial levers this maps to]
Evidence base: [Named sources with confidence grade]
Directional financial impact: [Range, with explicit assumption stated]
Confidence grade: [Confirmed / Inferred / Asserted — per the Playbook]
What this does not yet prove: [Known limits of the claim]
Recommended action to strengthen: [What data or source would upgrade the confidence grade]
```

### 5.3 Positioning Statement Format

When generating executive or programme positioning statements:

- Lead with the behavioural mechanism, not the dollar figure
- State the dollar range as directional, not precise, until actuarial verification is complete
- Pair every financial claim with its confidence grade
- Avoid framing any of the 16 service expectations as a CX improvement — they are duration and volatility controls
- Use the language: "This is not an experience enhancement. It is a [duration control / volatility stabiliser / cost containment mechanism]."

### 5.4 Prohibited Framings

The following framings are inconsistent with the project's analytical discipline and must not appear in NI scheme outputs:

- "Service improvements will save $Xm" (without stating the model is directional and assumptions are unverified)
- Applying $1,500 × 148,000 as a verified cost figure
- Treating any of the four lever cost ranges as confirmed financial estimates
- Summing the four levers additively without deduplication caveat
- Describing any of the 16 expectations as "soft" or "experience" improvements
- Presenting SIRA CMR findings as direct evidence of dollar-level savings (the CMR confirms reform directions, not magnitudes)

### 5.5 Inference Flagging Convention

Where a claim is Inferred, format as:

> [I] *The mechanism is directionally supported by [source], which confirms [what the source says]. The specific quantum — [e.g. 4-week saving] — is not directly evidenced and represents a modelling assumption. To confirm, [required data source] would be needed.*

---

## Part 6 — Reform and Regulatory Context

### 6.1 Current Reform Pressures (as at early 2026)

- SIRA CMR (September 2025) — recommends person-centred claims management reform; explicitly calls for proactive early intervention, plain-English decision communication, and improved CSP performance against service standards
- Workers compensation legislative settings — tightening statutory timeframes for provisional liability decisions, increasing transparency requirements, raising documentation standards
- Psychological injury growth — confirmed across icare Annual Reports as a material driver of increasing duration and cost in the NI; these claims have higher durations, lower RTW rates, and are more sensitive to empathy, timeliness, and proactive management than physical injury claims
- CSP model and contract settings — icare's relationship with CSPs is the primary delivery lever; service expectation improvements must be embedded in CSP performance standards, not only in icare internal systems

### 6.2 Reform Framing Principle

Under reform pressure, each of the 16 service expectations functions as a **reform integrity control**. Poor performance against a service expectation does not just create a service gap — it creates reform leakage. Policy intent expressed in legislation or the SIRA CMR dissipates through operational behaviour if service expectations are not met.

---

## Part 7 — Key Analytical Principles

These principles govern how this skill reasons about NI scheme questions. They are derived from the project's accumulated analytical work and from the Playbook discipline.

1. **Scheme mechanics first.** Before any journey, positioning, or opportunity work, establish the correct scheme mechanics. Incorrect mechanics — especially applying workers compensation logic to a different scheme or applying pre-step-down logic to post-step-down claims — invalidate all downstream analysis.

2. **Duration is the primary cost driver.** In the NI, cost accumulates through time. Every analytical question should resolve to: does this behaviour, decision, or service failure extend claim duration? If yes, it is a cost driver. If no, it may still matter but belongs in a different part of the cost model.

3. **Behavioural change precedes financial change.** Service improvements change behaviour first. Behaviour change reduces duration. Duration reduction reduces cost. Any claim that skips the behavioural link and goes directly from service improvement to financial saving is making an Asserted claim.

4. **Scale creates leverage.** With ~148,000 active claims, even a fraction-of-a-week average duration shift produces material nominal savings. This leverage works in both directions — small service failures also compound materially at this scale.

5. **The 16 expectations interact.** They are not independent levers. Improvements in one expectation create conditions for other expectations to function better (or degrade if missing). The 16×16 influence matrix maps these relationships. No single expectation should be treated in isolation.

6. **Psychological claims require separate treatment.** They have materially different duration distributions, cost profiles, and sensitivity patterns from physical injury claims. Any model that does not separate them understates the leverage concentrated in this cohort.

7. **Narrative drives organisational change; financial modelling provides the mandate.** In the NI service expectations programme, customer stories and definitions carry more organisational influence than financial models. Financial models provide the mandate to invest; narrative assets drive the behavioural change.

---

## Part 8 — Quick Reference for Common Tasks

### Generating an opportunity hypothesis
→ Use the format in Part 5.2. Identify the expectation, trace the mechanism, assign the lever, grade the evidence.

### Framing a service expectation for an executive audience
→ Lead with mechanism (uncertainty → delay → cost). State the expectation as a structural lever, not a service quality improvement. Include the directional financial range with confidence caveat. Use a named claimant story if available.

### Checking a claim's confidence grade
→ Ask: is this directly stated in a Tier 1 or Tier 2 source? If yes: Confirmed. If derived through reasoning from evidence: Inferred — label it. If neither: Asserted — remove or reclassify.

### Building a business case for a service expectation improvement
→ Start with the mechanism (Part 2.2). Map to a lever (Part 2.3). Apply the duration sensitivity logic (Part 3). State all assumptions explicitly. Apply the prohibited framings list (Part 5.4). Flag which inputs need actuarial verification before the case can be escalated.

### Assessing a proposed scheme intervention
→ Check: does it address one or more of the 16 expectations? Does it affect duration-bearing behaviour? What is the lever? What is the evidence grade for the mechanism? What is the affected cohort proportion? Is the dollar figure verified or indicative?

---

## Appendix A — The 16 Service Expectations at a Glance

| # | Expectation | Primary Cost Mechanism | Scheme Lever |
|---|---|---|---|
| 1 | Clear Handover | Prevents context loss; reduces duration resets | Continuity of Ownership |
| 2 | Empathy & Understanding | Reduces defensive behaviour; supports RTW engagement | Unmapped (RTW and engagement) |
| 3 | Knowledgeable Case Manager | Reduces clarification loops; improves decision quality | Underpins all four levers |
| 4 | Reliable Case Manager | Reduces re-contact; preserves claim momentum | Proactive CM; Continuity |
| 5 | Professional Case Manager | Reduces escalation; increases cooperation | Unmapped (engagement) |
| 6 | Proactive Service | Prevents drift into long-tail cohort | Proactive Case Management |
| 7 | Timely Service | Preserves claim momentum; prevents escalation | Proactive CM; Clear Info |
| 8 | Self-Service | Reduces case manager load; compresses cycle time | Cost-to-serve (not duration model) |
| 9 | Channel Preferences | Reduces friction in communication; supports engagement | Cost-to-serve |
| 10 | Clear & Accurate Information | Reduces rework cycles; resolves PIAWE disputes | Clear & Accurate Information |
| 11 | Easy Process | Reduces submission errors and delays | Cost-to-serve; partially duration |
| 12 | Clear on Process and Next Steps | Prevents passive delay at transition points | Clear Info; Timely Decisions |
| 13 | Communicating Clear Timelines | Prevents avoidance and premature escalation | Clear Info; Timely Decisions |
| 14 | Timely Decisions | Reduces benefit continuation during decision lag | Timely Decisions |
| 15 | Transparency of Decisions | Reduces dispute and re-contact; reduces rework | Clear & Accurate Information |
| 16 | Timely & Accurate Payments | Reduces re-contact; prevents RTW disruption | Cross-lever |

---

## Appendix B — Confirmed Evidence Anchors

| Source | What it confirms for NI |
|---|---|
| SIRA Annual Report 2023–24 | ~148,000 active claims; scheme performance indicators |
| icare Annual Reports 2023–24 and 2024–25 | RTW rates (83.5% at 26 weeks NI); psychological injury growth; cost drivers; service fee revenue |
| SIRA CMR September 2025 | Person-centred reform agenda; proactive early intervention as system-wide recommendation |
| SIRA NI Audit Jan 2023 | Early intervention gaps; SOP 34 non-compliance |
| SIRA NI Audit Mar 2023 | PIAWE communication template failures; compliance gaps |
| SIRA QBE NI Audit May 2025 | High case manager turnover; handover failures; directly confirms Lever 4 problem |
| WCA 1987 | 95%/80% step-down structure; provisional liability timeframes |
| SICG Act 2015 | icare mandate; CSP governance structure |
| icare Financial Statements FY25 | $1.316bn service fee revenue; $741m agent remuneration |
