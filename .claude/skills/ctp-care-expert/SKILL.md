---
name: ctp-care-expert
description: >
  Activates Claude as a resident expert on the NSW CTP Care scheme — the statutory benefits
  component of NSW compulsory third party motor accident insurance, administered under the
  Motor Accident Injuries Act 2017 and regulated by SIRA. Use this skill whenever a task
  requires reliable, traceable analysis of CTP Care — including scheme mechanics, benefit
  structure, claim lifecycle, service expectation positioning, opportunity hypothesis generation,
  cost driver analysis, executive framing, or evidence-graded research outputs. Trigger whenever
  the user references CTP Care, CTP insurance, motor accident injuries, MAI Act, minor injury
  determination, statutory benefits for motor accidents, at-fault claimants, the 26-week
  threshold, or the Navigator → Phineas migration as it applies to CTP Care. Also trigger for
  any task that requires The Playbook confidence-grading discipline (Confirmed / Inferred /
  Asserted) applied to CTP Care scheme material.
---

# CTP Care Expert Skill

## Purpose

This skill encodes the knowledge base, analytical frameworks, evidence hierarchy, and output
standards required to act as a reliable expert on the NSW CTP Care scheme. It governs how
Claude reasons about scheme mechanics, service expectations, cost drivers, and improvement
opportunities — and how it communicates findings in a way that is grounded, traceable, and fit
for executive and programme use.

---

## Part 1 — Scheme Fundamentals

### 1.1 Legislative and Governance Base

| Element | Detail | Confidence |
|---|---|---|
| Primary legislation | Motor Accident Injuries Act 2017 (NSW) — governs statutory benefits, fault framework, treatment and care entitlements, minor injury classification | Confirmed |
| Secondary legislation | Motor Accident Injuries Regulation 2017 (NSW) — prescribes procedural detail and benefit rates | Confirmed |
| Governance framework | State Insurance and Care Governance Act 2015 (NSW) — establishes icare's mandate and regulatory structure | Confirmed |
| Financial reporting obligation | Government Sector Finance Act 2018 (NSW) | Confirmed |
| Regulator | State Insurance Regulatory Authority (SIRA) — sets scheme rules, regulates insurers, publishes performance data and scheme statistics | Confirmed |
| Scheme administrators | Licensed CTP insurers (e.g. Allianz, QBE, NRMA, GIO, Suncorp) — manage statutory benefit claims under SIRA regulation | Confirmed |
| icare's role | icare is not the direct insurer for CTP Care. CTP insurance is delivered by licensed private insurers under SIRA regulation. icare's involvement is primarily through the Navigator → Phineas migration platform, which spans CTP Care, Lifetime Care, and Workers Care | Confirmed |

**Critical distinction from other icare schemes:** CTP Care is not directly administered by
icare in the same way as NI, TMF, or HBCF. The scheme is delivered by licensed private insurers
under SIRA regulation. icare's operational footprint in CTP Care is principally through technology
platform services (Navigator → Phineas) and at the portfolio/regulatory interface. This must not
be conflated with icare's direct scheme administration role in workers compensation.

### 1.2 Benefit Structure (MAI Act 2017)

The MAI Act 2017 introduced a fault-based, time-limited statutory benefits model that replaced
the prior no-fault statutory scheme.

| Phase | Duration | Entitlement | Key Gate |
|---|---|---|---|
| Statutory benefits — universal | Weeks 1–26 | Treatment and care, income support (loss of earnings), death benefits | Available to all injured people regardless of fault, including at-fault drivers |
| Statutory benefits — extended | Post week 26 | Treatment and care, income support | Available only to claimants who are **not mostly at fault** for the accident |
| Common law damages | No statutory time limit | Pain and suffering, economic loss, past and future care | Available only for **non-minor injuries**; subject to thresholds and caps |

**Minor injury determination** is the central entitlement gate in CTP Care. A "minor injury"
under the MAI Act is a soft tissue injury or a minor psychological injury. Claimants with a
minor injury are not entitled to common law damages. This determination is contested frequently
and is a known driver of legal engagement. [Confirmed — MAI Act 2017 ss. 1.6, 3.1]

**Income support** under the statutory scheme is calculated at 95% of pre-accident weekly
earnings for weeks 1–13, stepping to 80% for weeks 14–26 (for earners). Post-26-weeks income
support is available only to not-mostly-at-fault claimants. [Confirmed — MAI Act 2017 Part 3]

**Fault framework:** The MAI Act introduced a modified comparative fault model. At-fault
claimants retain access to 26 weeks of statutory benefits but lose entitlement to extended
benefits and common law damages if found mostly at fault. This creates a significant
information asymmetry — many claimants do not understand their fault exposure at the time of
claiming. [Confirmed — MAI Act 2017 ss. 3.6, 3.28]

### 1.3 Scheme Scale

Precise CTP Care claim volumes are regulated and published by SIRA. The following figures are
the best available from the project source register.

| Metric | Figure | Source |
|---|---|---|
| CTP scheme overview | Described as a benefit structure and early treatment model | SIRA CTP Insurance Overview [Confirmed — Source #8 in project register] |
| Scheme financial scale | Not disaggregated in project source register; icare Annual Reports cover portfolio level | Indicative only — requires direct SIRA CTP statistics [Inferred] |
| Navigator → Phineas migration scope | CTP Care is one of three schemes in scope (with Lifetime Care and Workers Care) | icare-expert skill / project context [Confirmed] |

**Evidence gap note:** The project source register does not include a dedicated CTP Care
financial statistics source comparable to the SIRA Annual Report 2023–24 used for NI. Before
using dollar figures or claim volumes in executive or board materials, the following should be
sourced: SIRA Motor Accidents Injury Scheme statistics (published quarterly), SIRA CTP insurer
performance reports, and the relevant actuarial summaries for CTP statutory benefit exposures.

### 1.4 Key Parties

| Party | Role |
|---|---|
| SIRA | Regulator — sets the scheme rules, licenses CTP insurers, publishes performance data, handles complaints, oversees the MAI Act |
| Licensed CTP insurers | Statutory benefit claim managers — assess, approve, and pay statutory benefits; manage treatment and care under SIRA standards |
| icare | Technology platform provider for CTP Care (Navigator → Phineas); not the direct insurer |
| Injured people / claimants | Recipients of statutory benefits — may be drivers, passengers, pedestrians, or cyclists |
| Treatment providers | Medical, allied health, rehabilitation providers — generate treatment approvals and cost |
| Legal representatives | Highly active in CTP Care, particularly around minor injury disputes and common law damages |
| Employers | Relevant where income support interacts with employment status; less central than in workers compensation |
| At-fault drivers and their insurers | Defendants in common law proceedings where non-minor injury is established |

---

## Part 2 — The 16 Service Expectations Applied to CTP Care

### 2.1 Framing Note

The 16 service expectations were developed with a workers compensation framing. In CTP Care,
the equivalent of the "claim manager" is the CTP insurer's case manager or statutory benefits
handler. The expectations apply in substance, with the following adaptations:

- "Worker" or "claimant" in CTP = the injured person (driver, passenger, pedestrian, cyclist)
- "Employer" in CTP = background party; employment status affects income support but the
  employer is not a primary claim participant in the same way as workers compensation
- "Return to work" framing is relevant but secondary; the primary goal is recovery and
  functional restoration
- "PIAWE" equivalent is pre-accident weekly earnings — income support in CTP is calculated
  on a similar basis but under MAI Act provisions, not WCA 1987

### 2.2 Expectation Impact Map for CTP Care

| Expectation | CTP Care Mechanism | Cost Driver | Evidence Grade |
|---|---|---|---|
| Clear Handover | Case manager changes during treatment phase create context loss; multiply during Navigator → Phineas migration | CHE (rework, relationship reset); compensation risk (legal engagement) | Confirmed problem; quantum Inferred |
| Empathy & Understanding | Injury from a motor accident involves trauma, shock, and often disputed fault; perceived dismissal drives legal engagement early | CHE (escalation handling); compensation (legal cost) | Inferred — mechanism consistent with CTP literature; NSW-specific data not in source register |
| Knowledgeable Case Manager | MAI Act 2017 complexity — minor injury, fault framework, 26-week threshold — requires genuine scheme literacy; gaps drive incorrect information and legal triggers | CHE (rework, legal response); compensation (minor injury dispute cost) | Confirmed problem via SIRA CTP Insurance Overview framing; quantum Inferred |
| Reliable Case Manager | Commitments not met during the 26-week statutory window — where time is the primary entitlement gate — cause disproportionate anxiety and escalation | CHE (re-contact, escalation); compensation (legal trigger) | Inferred |
| Professional Case Manager | Claimants who feel treated transactionally during a traumatic event engage legal representation sooner | CHE (legal response overhead); compensation (damages exposure) | Inferred |
| Proactive Service | The 26-week threshold is a hard deadline; claimants who are not forewarned about fault exposure, minor injury determination, or post-26-week entitlement gaps are at high legal trigger risk | CHE (escalation handling); compensation (legal cost, damages) | Confirmed mechanism; quantum Inferred |
| Timely Service | Queries about treatment approvals, income support, and fault status are time-critical; delays during the 26-week window directly affect behavioural decisions about legal engagement | CHE (contact inflation, re-contact); compensation precursor | Confirmed mechanism from cross-scheme reference packs |
| Self-Service | Simple tasks (document upload, appointment booking, status checking) currently require case manager mediation; deflection opportunity exists | CHE (case manager capacity drain) | Inferred — consistent with cross-scheme self-service analysis |
| Channel Preferences | CTP claimants include a wide demographic range; channel mismatch particularly affects CALD communities and older claimants | CHE (contact friction); experience | Inferred |
| Clear & Accurate Information | Minor injury determination, fault framework, and 26-week threshold are complex and frequently misunderstood; information failures directly trigger legal representation | CHE (rework, legal response); compensation (legal cost, damages) | Confirmed via SIRA CTP Insurance Overview and MAI Act structure; quantum Inferred |
| Easy Process | Treatment approval and income support processes involve multiple actors (insurer, provider, SIRA); friction in these processes delays recovery and triggers escalation | CHE (rework, contact inflation); treatment cost (delay effect) | Inferred |
| Clear on Process and Next Steps | The transition at week 26 is the single highest-risk process point; claimants who do not understand what happens next at week 22–26 seek legal advice | CHE (escalation); compensation (legal cost, damages pathway) | Confirmed mechanism from cross-scheme reference packs; CTP-specific data gap |
| Communicating Clear Timelines | Statutory timeframes (26 weeks, minor injury determination windows, treatment approval cycles) are opaque to most claimants; unclear timelines increase passive delay and premature escalation | CHE (contact inflation, escalation); compensation precursor | Inferred |
| Timely Decisions | Treatment approvals, income support decisions, and minor injury determinations are time-critical; late decisions directly extend treatment delays and increase legal engagement | CHE (rework); treatment cost; compensation (legal trigger) | Confirmed — minor injury determination timing is a known scheme pressure point |
| Transparency of Decisions | Minor injury determination letters citing legislation without plain-English explanation are a confirmed driver of legal engagement in CTP Care | CHE (legal response); compensation (legal cost, damages) | Confirmed problem from scheme journey analysis; quantum Inferred |
| Timely & Accurate Payments | Income support delays in the 26-week window create financial stress and accelerate legal engagement; payment accuracy governs whether claimants trust the system | CHE (rework, contact); compensation precursor | Inferred — mechanism consistent with cross-scheme payments analysis |

### 2.3 Highest-Leverage Expectations for CTP Care

Based on the scheme's structural characteristics — the 26-week entitlement gate, the minor
injury determination, and the fault framework — the following expectations carry the highest
financial leverage in CTP Care:

1. **Timely Decisions** — minor injury determination and treatment approvals are time-critical
   and directly gate entitlement and legal engagement
2. **Clear & Accurate Information** — the MAI Act's complexity creates persistent information
   asymmetry; claimants who misunderstand fault exposure or minor injury classification engage
   legal representation earlier
3. **Proactive Service** — the 26-week threshold is non-negotiable; claimants who are not
   proactively informed about the transition point face a cliff-edge entitlement experience
4. **Clear Handover** — the Navigator → Phineas migration creates elevated handover risk;
   case record transfer failures directly affect continuity of the statutory benefit journey
5. **Transparency of Decisions** — minor injury determination letters are the single most
   contested document type in CTP Care; opaque rationale is a direct legal trigger

---

## Part 3 — Cost Model

### 3.1 Cost Drivers in CTP Care

CTP Care has a different cost model from NI workers compensation. The primary cost structure is:

**Claims Handling Expense (CHE)**
- Case manager time per claim
- Internal rework (re-contact, escalation handling, legal response preparation)
- External dispute management (SIRA complaints, Dispute Resolution Service)
- Legal correspondence and file preparation

**Treatment and Care Cost**
- Medical treatment (acute, allied health, rehabilitation)
- Care costs (domestic, attendant care)
- Treatment delays increase both duration and intensity of care required

**Compensation / Damages Cost**
- Common law damages for non-minor injuries — pain and suffering, economic loss, past and
  future care
- Legal costs (both sides in common law proceedings)
- Settlement quantum

**Key difference from NI:** In NI, the dominant cost driver is **weekly benefit duration** —
time is the cost multiplier. In CTP Care, the dominant cost risk is **escalation to common law
damages** — the transition from a statutory benefit claim to a common law damages claim
multiplies cost by an order of magnitude. Service expectation failures that accelerate legal
engagement are therefore the highest-leverage cost drivers in this scheme.

### 3.2 Volatility vs Duration Framing

CTP Care sits between NI (duration-driven) and Lifetime Care (volatility-driven):

- **Statutory benefits phase (weeks 1–26):** Duration-sensitive — delays in treatment approvals
  and income support create cost within the statutory window. The cost quantum is bounded.
- **Common law damages phase:** Volatility-driven — once a claimant engages legal
  representation and pursues damages, the cost outcome is unpredictable and potentially very
  large. The transition from statutory to common law is the primary volatility event.

Service improvement work should be framed around **preventing the statutory-to-common-law
escalation** as the primary financial objective, not merely compressing statutory benefit
duration.

### 3.3 Legal Engagement as the Primary Cost Trigger

Legal representation in CTP Care is a confirmed cost amplifier. [Confirmed — mechanism
established in SIRA CTP scheme design; the MAI Act 2017's minor injury provisions are
explicitly designed to limit damages access and reduce legal cost.] The following service
expectation failures are most likely to accelerate legal engagement:

- Minor injury determination letters that are unclear or arrive late
- Lack of proactive communication about the 26-week threshold
- Income support delays in the early weeks when financial stress is highest
- Case manager changes without clear handover during the statutory benefits window
- Opaque treatment approval decisions

[I] *The specific legal engagement rate and its relationship to individual service expectation
failures has not been directly evidenced by a source in the project register. The direction is
consistent with scheme design intent and cross-scheme behavioural literature. Quantification
requires SIRA CTP insurer performance data and legal representation rate statistics.*

---

## Part 4 — Claim Lifecycle and Journey

### 4.1 Four-Stage Journey

| Stage | Description | Key Events |
|---|---|---|
| Notification & Assessment | Accident reported; CTP insurer identified; statutory benefit claim lodged; initial injury assessment | First contact with insurer; fault assessment begins; treatment plan initiated; income support applied for |
| Treatment & Rehabilitation | Ongoing treatment and care; income support payments; treatment approvals managed; recovery monitored | Treatment approval cycles; income support payment cadence; case manager relationship established; weekly review |
| Decisions & Entitlement | Minor injury determination made; fault assessment finalised; 26-week threshold reached; post-26-week entitlement decision | Minor injury letter issued; claimant understands (or does not) their entitlement position; legal engagement decision made |
| Transition / Close | Post-26-week statutory benefits continue or cease; common law pathway opened or not; claim resolves or escalates | Benefits continue/cease; legal proceedings commence or not; claim finalises |

### 4.2 The 26-Week Threshold as a System Event

The week 26 transition is the most operationally significant event in the CTP Care lifecycle:

- At-fault claimants lose all entitlement to statutory income support
- Not-mostly-at-fault claimants continue to receive treatment and income support
- All claimants with non-minor injuries retain common law rights regardless of fault

**Service expectation implication:** Any claimant who reaches week 22–26 without clear
understanding of their entitlement position — fault status, injury classification, next steps
— is at high risk of reactive legal engagement. This is not a post-26-week problem; it is a
weeks 1–22 proactive service failure that manifests at the threshold. [Confirmed — MAI Act
2017 structure; service implication is Inferred from the structural analysis]

### 4.3 Minor Injury Determination as a Dispute Driver

The minor injury determination is the highest-contested decision point in the scheme. Key
dynamics:

- Soft tissue injuries are the most common CTP claim type and are classified as minor
- Claimants who dispute minor injury classification can seek review
- The difference between minor and non-minor injury is the gateway to common law damages
- A claimant who understands this distinction early behaves very differently from one who
  receives a minor injury determination letter at week 20 without context

[Confirmed — MAI Act 2017 ss. 1.6, 3.1 establish the minor injury framework; the service
implication is Inferred from scheme design analysis]

---

## Part 5 — The Navigator → Phineas Migration

### 5.1 Scope

CTP Care is one of three schemes in the Navigator → Phineas migration:
- Lifetime Care
- Workers Care
- CTP Care

[Confirmed — icare-expert skill and project context]

### 5.2 Service Expectation Risk During Migration

The migration creates elevated risk against the following expectations:

**Clear Handover:** Case records, decision histories, and entitlement context must transfer
accurately from Navigator to Phineas. Failure to transfer creates the same handover failures
the expectation is designed to prevent — but systemically, across all affected claims
simultaneously.

**Timely Decisions:** Platform transition periods create processing delays for treatment
approvals and income support. In CTP Care, where the 26-week window is non-negotiable, any
platform-driven delay compresses the time available for legitimate entitlement assessment.

**Timely & Accurate Payments:** Payment workflow changes during migration create risk of
income support delays. Early-stage financial stress is a known legal engagement trigger.

**Self-Service:** Digital capability available to claimants and providers changes at migration
cutover. Any reduction in self-service capability during transition increases case manager
contact dependency.

**Knowledgeable Case Manager:** Case managers operating on a new platform have reduced
operational fluency during the transition period. This is a temporary but material reduction
in the knowledge and proactivity the expectation requires.

### 5.3 Analytical Principle

Any service expectation improvement initiative for CTP Care must be assessed against the
Phineas migration timeline. Initiatives that depend on functionality not yet available in
Phineas, or that run parallel to migration workstreams, carry elevated execution risk.

---

## Part 6 — Service Expectations: Opportunity Hypotheses

### 6.1 Hypothesis Format

For CTP Care, opportunity hypotheses follow the same format as other icare scheme skills:

**If [service expectation] is improved, then [claimant/provider behaviour changes], which
[reduces/prevents] [cost driver], producing [financial outcome] for the scheme.**

### 6.2 Hypotheses by Expectation

**Timely Decisions — minor injury determination**
If minor injury determinations are made earlier in the claim lifecycle (weeks 8–12 rather than
weeks 20–22), then claimants have more time to understand their entitlement position and seek
review without defaulting to legal representation, which reduces legal engagement as a reactive
response to a late determination, producing lower legal cost and lower common law damages
exposure. [Confirmed mechanism; quantum Inferred — legal engagement rate data required to
quantify]

**Clear & Accurate Information — fault framework and 26-week threshold**
If claimants receive plain-English explanation of the fault framework and 26-week threshold
at claim lodgement and again at week 13, then the proportion of claimants who are surprised
by entitlement cessation at week 26 falls, which reduces the reactive legal engagement spike
at the threshold, producing lower legal cost and a higher proportion of claims that resolve
within the statutory benefits framework. [Confirmed mechanism; quantum Inferred]

**Proactive Service — pre-threshold communication**
If case managers initiate a structured entitlement review conversation at weeks 20–22 (before
the threshold, not after), then claimants understand what will change at week 26 and what
options are available, which prevents uninformed legal engagement and allows genuine recovery
pathways to be explored, producing lower legal cost and better claimant outcomes. [Confirmed
mechanism from scheme structure; quantum Inferred]

**Clear Handover — migration period**
If the Navigator → Phineas migration includes a structured case record transfer protocol with
case manager handover briefings for in-flight claims, then context loss during migration is
minimised, which prevents the relationship resets and decision re-making that extend active
claim handling cost, producing lower CHE during the migration period. [Confirmed problem;
quantum Inferred — no migration-specific data available]

**Transparency of Decisions — minor injury determination letters**
If minor injury determination letters are rewritten in plain English with a clear explanation
of what the determination means for entitlement, what review rights exist, and what the next
steps are, then the proportion of claimants who default to legal representation upon receipt
falls, producing lower legal cost and fewer dispute referrals. [Confirmed mechanism from
scheme journey analysis; quantum Inferred]

### 6.3 Evidence Gaps

The following gaps limit the confidence grade on all CTP Care hypotheses and must be resolved
before these are used in board or regulatory submissions:

1. **SIRA CTP claim volume and legal representation rate data** — required to size the affected
   cohort for all hypotheses
2. **Minor injury determination timing distribution** — required to assess how often determinations
   arrive late (weeks 20–22) vs early (weeks 8–12)
3. **Legal engagement trigger data** — what proportion of legal representation is reactive to
   a service failure vs proactive claimant choice
4. **Post-26-week entitlement awareness data** — what proportion of claimants understand their
   entitlement position before the threshold vs after it
5. **Navigator → Phineas migration impact data** — what service disruption the migration has
   produced to date

---

## Part 7 — Reform and Regulatory Context

### 7.1 MAI Act 2017 Reform Intent

The Motor Accident Injuries Act 2017 was a significant reform of the NSW CTP scheme. Its
primary intent was to:

- Introduce a fault-based model that limits statutory benefits for at-fault drivers after 26
  weeks
- Reduce legal costs by limiting access to common law damages for minor injuries
- Improve early treatment and recovery outcomes through a no-fault statutory benefits phase

Service expectation failures that undermine this intent — particularly those that accelerate
legal engagement before the scheme's dispute resolution pathways are exhausted — represent
reform leakage. [Confirmed — MAI Act 2017 explanatory materials and scheme design intent]

### 7.2 SIRA Oversight

SIRA regulates the CTP scheme and publishes insurer performance data. SIRA's oversight
creates accountability pressure on licensed CTP insurers comparable to its oversight of CSPs
in the NI scheme. Service expectation failures that surface in SIRA performance reporting
carry reputational and regulatory consequences for insurers. [Confirmed — SIRA CTP Insurance
Overview, Source #8 in project register]

### 7.3 Navigator → Phineas as a Reform Variable

The platform migration is a live operational variable that intersects with the service
expectations programme. Any analysis of CTP Care service expectation performance must
account for whether observed failures are structural (pre-dating the migration) or
migration-induced (temporary but currently active). The distinction affects both the diagnosis
and the recommended intervention.

---

## Part 8 — Output Standards for CTP Care

### 8.1 Terminology

| Use | Replaces |
|---|---|
| Claimant or injured person | Worker (CTP Care is not a workers compensation scheme) |
| Motor accident | Workplace injury |
| Statutory benefits | Weekly benefits (NI term) |
| Income support | Weekly benefits / PIAWE-based payments |
| MAI Act 2017 | WCA 1987 |
| Minor injury / non-minor injury | Soft tissue (too narrow) or serious injury (imprecise) |
| Common law damages | Compensation (too generic) |
| CTP insurer or case manager | CSP (NI-specific term) |
| SIRA CTP statistics | SIRA Annual Report (which covers workers compensation) |

### 8.2 Scheme Boundary Rules

- Keep NI weekly benefit mechanics (PIAWE, step-downs at 13/26 weeks in workers
  compensation terms, WCA 1987 provisions) out of CTP Care outputs
- Keep the 148,000 active claims figure out of CTP Care — it is an NI metric
- Describe icare's role accurately as technology platform and portfolio oversight — CTP is
  delivered by licensed private insurers, not icare
- Keep dollar figures specific to CTP Care's own cost model — NI duration-model figures don't
  transfer; the cost model and claim volumes differ
- Always include the common law escalation risk when framing CTP Care cost drivers — it is the
  dominant financial risk in this scheme, not statutory benefit duration

### 8.3 Confidence Discipline

The project source register contains one CTP Care-specific entry (SIRA CTP Insurance Overview,
Source #8) and the MAI Act 2006 (which governs Lifetime Care, not CTP Care — the relevant
legislation for CTP Care is the MAI Act **2017**). This is a thin evidence base compared to
NI. Apply the following defaults:

- Scheme mechanics confirmed by the MAI Act 2017: **Confirmed**
- Service expectation impact directions derived from scheme structure and cross-scheme
  literature: **Inferred** — always flag
- Dollar figures or claim volume estimates not sourced from SIRA CTP statistics: **Asserted**
  — source before using in executive or board outputs

### 8.4 Inference Flagging Convention

Where a claim is Inferred, format as:

> [I] *The mechanism is directionally supported by [source / scheme structure], which confirms
> [what is confirmed]. The specific quantum — [e.g. legal engagement rate] — is not directly
> evidenced and represents a modelling assumption based on [reasoning]. To confirm, [required
> data source] would be needed.*

---

## Part 9 — Quick Reference for Common Tasks

### Generating an opportunity hypothesis for CTP Care
→ Use the format in Part 6.1. Identify the expectation, trace the mechanism through the
CTP-specific cost model (statutory-to-common-law escalation as primary risk), assign the cost
driver (CHE, treatment, or damages), grade the evidence. Keep the analysis to CTP Care's own
cost model rather than NI duration-model logic.

### Framing a CTP Care service expectation for an executive audience
→ Lead with mechanism (information asymmetry / entitlement opacity → legal engagement →
damages exposure). State the 26-week threshold as the structural risk event. Frame improvements
as legal cost reduction and statutory resolution rate improvement, not duration compression.

### Assessing a proposed intervention in CTP Care
→ Check: does it address one or more of the 16 expectations? Does it reduce legal engagement
risk? Does it operate within the MAI Act 2017 framework? Is it affected by the Navigator →
Phineas migration? What is the evidence grade?

### Checking a claim's confidence grade
→ MAI Act 2017 mechanics: Confirmed. SIRA CTP scheme design intent: Confirmed. Behavioural
mechanisms derived from cross-scheme literature: Inferred. Dollar figures without SIRA CTP
statistics source: Asserted — remove.

---

## Appendix A — Evidence Anchors for CTP Care

| Source | What it confirms for CTP Care | Confidence |
|---|---|---|
| Motor Accident Injuries Act 2017 (NSW) | Benefit structure, fault framework, minor injury classification, 26-week threshold, income support calculation, common law access rules | Confirmed |
| Motor Accident Injuries Regulation 2017 (NSW) | Procedural detail, benefit rates | Confirmed |
| SIRA CTP Insurance Overview (Source #8, project register) | Benefit structure and early treatment model validation | Confirmed |
| State Insurance and Care Governance Act 2015 | icare's portfolio mandate including CTP oversight role | Confirmed |
| icare Annual Reports 2023–24 and 2024–25 | Portfolio financial scale; Navigator → Phineas migration scope | Confirmed |
| icare-expert skill (project) | CTP Care in portfolio context; Navigator → Phineas scope confirmed | Confirmed |
| Cross-scheme service expectation reference packs (project) | Behavioural mechanisms for all 16 expectations — directionally applicable to CTP Care | Inferred application to CTP Care |
| SIRA CTP Motor Accident Injury scheme statistics | Claim volumes, legal representation rates, treatment cost data | Not in project register — evidence gap |
| SIRA CTP insurer performance reports | Insurer-level service performance | Not in project register — evidence gap |

### Priority Sources to Add to the Register

Before CTP Care outputs are used in board or regulatory contexts, the following sources should
be added to the project source register:

1. SIRA — Motor Accident Injury Scheme Statistics (quarterly publication)
2. SIRA — CTP Insurer Performance Reports
3. NSW MAI Act 2017 Explanatory Memorandum
4. icare technology programme documentation for Navigator → Phineas migration (CTP Care scope)
5. Any internal icare analytical work on CTP Care service expectation performance baselines

---

## Appendix B — CTP Care vs Other Schemes: Key Differences

| Dimension | CTP Care | Nominal Insurer (NI) | Lifetime Care |
|---|---|---|---|
| Primary cost driver | Legal escalation to common law damages | Weekly benefit duration | Care plan volatility |
| Primary entitlement gate | Minor injury determination + fault | Provisional liability | MAIV Act catastrophic threshold |
| Time structure | Hard 26-week statutory window | Step-downs at 13/26/130 weeks | Lifelong |
| Legal involvement | Structural feature of the scheme; high | Growing; a cost risk | Low; mainly care plan disputes |
| icare's direct role | Technology platform; not the insurer | Scheme owner; CSP contractor | Scheme owner; direct administration |
| Scale | Not quantified in project register | ~148,000 active claims | ~9,000 participants |
| Service expectation framing | Legal cost reduction; entitlement clarity | Duration compression | Volatility dampening |
| Key transition event | 26-week threshold | Step-downs; RTW milestones | Care plan reviews |
