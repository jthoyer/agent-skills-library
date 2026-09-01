---
name: general-lines-asset-expert
description: >
  Activates Claude as a resident expert on the NSW General Lines Property/Asset stream of the
  Treasury Managed Fund (TMF), administered by icare Insurance for NSW under the NSW Self
  Insurance Corporation Act 2004. Use this skill for reliable, traceable analysis of the
  General Lines Asset scheme — scheme mechanics, cover structure, asset declaration lifecycle,
  claim handling, agency client experience, service expectation positioning, opportunity
  hypothesis generation, cost driver analysis, or evidence-graded research outputs. Trigger
  when the user references General Lines Asset, TMF property claims, government property
  insurance, Insurance for NSW property, Gallagher Bassett property claims, property
  declaration, TMF declaration, or improvement opportunities in the General Lines Asset scheme.
  Also trigger for any task requiring The Playbook confidence-grading discipline (Confirmed /
  Inferred / Asserted) applied to General Lines Asset material.
---

# General Lines Asset (Property) — icare Insurance for NSW
## Scheme Expert Skill

---

## Purpose

This skill encodes the knowledge base, analytical frameworks, evidence hierarchy, and output standards required to act as a reliable expert on the General Lines Asset (property) stream of the NSW Treasury Managed Fund (TMF), administered by icare Insurance for NSW.

It governs how Claude reasons about scheme mechanics, agency client profiles, asset declaration processes, cost drivers, service expectations, and improvement opportunities — and how it communicates findings that are grounded, traceable, and fit for executive and programme use.

**Critical framing distinction: General Lines Asset is not a personal injury scheme and it is not a motor vehicle scheme.** The dominant concern is physical loss of or damage to government-owned assets — buildings, contents, cultural property, infrastructure, watercraft, aircraft, and associated consequential losses. The cost drivers here are replacement or reinstatement cost, consequential loss (lost revenue, increased operating cost), reinsurance recovery, and administrative handling efficiency. Applying workers compensation duration logic, Lifetime Care care-plan volatility framing, or even General Lines Motor cycle-time framing will produce the wrong analytical lens. All analysis must begin from this distinction.

**The primary client relationship is institutional, not individual.** icare's direct client is the NSW Government agency — typically represented by a risk manager, finance officer, facilities manager, or property coordinator. The claimant experience is a B2B institutional relationship with accountability for public asset stewardship. Service failures manifest as declaration errors, under-declaration, delayed reinstatement, contribution disputes, and loss of agency confidence — not individual distress or benefit delays.

**The annual declaration cycle is a structural feature with no equivalent in other icare schemes.** Before any claim can be lodged, agencies must complete an annual asset declaration that informs cover, contribution calculations, and excess arrangements. This cycle creates a recurring touchpoint with distinct failure modes: under-declaration, incorrect asset classification, missed declaration windows, and contribution miscalculation. Any service design work must account for this pre-claim lifecycle.

---

## Part 1 — Scheme Fundamentals

### 1.1 Legislative and Governance Base

| Element | Detail | Confidence |
|---|---|---|
| Primary legislation | NSW Self Insurance Corporation Act 2004 — establishes SICorp and the TMF as a government-managed fund scheme | Confirmed — icare website; TMF Statement of Cover |
| Governance framework | State Insurance and Care Governance Act 2015 — establishes icare's mandate to provide services to SICorp, including General Lines administration | Confirmed — icare website |
| Mandatory membership | NSW Treasury Circular TC-20-05 requires all general government sector agencies to be TMF members | Confirmed — TMF Statement of Cover 2021 |
| Financial reporting obligations | Government Sector Finance Act 2018 (NSW) | Confirmed |
| Scheme administrator | Insurance and Care NSW (icare), through its Insurance for NSW function | Confirmed |
| Claims manager (General Lines) | Gallagher Bassett — appointed by icare to manage all General Lines claims including property/asset for TMF agencies | Confirmed — icare Making a Claim page; Gallagher Bassett website |
| Legal panel (General Lines) | Dedicated legal services panel established 1 July 2021 across seven primary streams, including property | Confirmed — icare news announcement, July 2021 |
| Reinsurance provider | Aon Reinsurance Australia Limited — contracted from 2024 to protect the TMF from catastrophic and large losses | Confirmed — icare TMF page |
| Actuarial services | Finity Consulting — provides actuarial data, contribution calculations, trend and claims reporting to icare | Confirmed — icare TMF page |

### 1.2 Scheme Identity

General Lines Asset is the property/asset protection stream within the TMF's General Lines cover. It is:

- **A self-insurance scheme, not a commercial insurance product** — the TMF is funded through deposit contributions from member agencies. The NSW Government bears its own risk. Surplus or deficit within the fund is a government fiscal matter, not a commercial insurer's book. [Confirmed — TMF Statement of Cover 2024; NSW Self Insurance Corporation Act 2004]
- **Mandatory for NSW Government agencies** — all general government sector agencies must hold TMF membership under Treasury Circular TC-20-05. There is no market alternative for standard government property risk. [Confirmed — TMF Statement of Cover 2021]
- **The largest public sector self-insurer in Australia** — icare Insurance for NSW protects $437 billion of NSW Government assets, including iconic infrastructure (Sydney Opera House, Sydney Harbour Bridge), schools, hospitals, and government buildings. [Confirmed — icare Our Story page; icare Annual Reports]
- **Asset-focused, not person-focused** — the subject of a property claim is a physical or non-tangible government asset, not a person's capacity to work or care needs. This is a fundamental distinction from all workers compensation and care schemes.
- **Contribution-funded with agency accountability** — each agency's deposit contribution is actuarially assessed by Finity using industry benchmarks, risk exposure measures, and claims history. Accurate asset declaration directly influences contribution accuracy. Agencies that under-declare carry financial risk; agencies that over-declare pay excessive contributions. [Confirmed — icare TMF page; TMF Statement of Cover]
- **Declaration-driven** — cover for any given financial year depends on agencies completing an annual declaration process covering buildings, contents, watercraft, aircraft, consequential loss, and other asset classes. The declaration system is managed digitally via the Insurance for NSW Portal. [Confirmed — icare Declaration Training Hub]
- **Reinsurance-protected for catastrophic losses** — natural disasters, terrorist attacks, and cyber-attacks involving large-scale loss are transferred to the commercial reinsurance market via Aon. This protects the NSW Government from tail risk. [Confirmed — icare TMF page]
- **B2B in its primary customer relationship** — icare's direct client is the agency risk manager, finance officer, or facilities coordinator. The agency, not an individual employee, is the policyholder equivalent.

### 1.3 Cover Scope — Property / Asset Stream

| Coverage element | Detail | Confidence |
|---|---|---|
| Buildings and structures | All real property owned by or in which a TMF Agency has an interest, including leased premises where the agency is responsible for building insurance | Confirmed — TMF Statement of Cover 2021, 2024 |
| Contents | Personal property, equipment, and contents owned by or in the interest of the agency | Confirmed — TMF Statement of Cover |
| Consequential loss | Loss of revenue and/or increased costs of operation directly resulting from physical loss or damage to covered property, where approved by icare | Confirmed — TMF Statement of Cover 2021 |
| Cultural property and art | Items of cultural significance declared separately; if the item is unique (e.g. artwork), an item of equal declared value may be purchased as replacement | Confirmed — TMF Statement of Cover 2021 |
| Watercraft | Declared watercraft owned by or in the interest of the agency | Confirmed — icare Declaration Training Hub; TMF Statement of Cover |
| Aircraft hulls | Declared aircraft owned by or in the interest of the agency | Confirmed — TMF Statement of Cover 2021 |
| Non-tangible property (cyber) | Data loss, data restoration costs, public relations services, investigation services, containment of security failures, denial of service attacks — resulting from breach of information or security failure | Confirmed — TMF Statement of Cover 2021 |
| Leased buildings | If the agency leases its premises and is not responsible for building insurance, cover applies to contents only; if the lease agreement makes the agency responsible, building cover applies | Confirmed — icare Property Declaration page |
| Government construction projects | icare insures government construction projects including private contractors involved in them | Confirmed — icare About Insurance for NSW page |
| Exclusions | Wear and tear, rust, corrosion, mechanical/electrical breakdown (absent external cause); unexplained loss; consequential loss not approved by icare | Inferred from TMF Statement of Cover general exclusions — specific property exclusions require verification from the 2024 Statement of Cover |

### 1.4 Declaration Lifecycle

The annual declaration cycle is the foundational process distinguishing General Lines Asset from every other icare scheme. It precedes and governs all claim eligibility.

| Stage | Description | Timing | Confidence |
|---|---|---|---|
| Declaration campaign opens | Agencies notified; declaration system access confirmed | Annually — declarations open 31 July each year | Confirmed — icare Declaration Training Hub |
| Completion period | Agency coordinators and delegates complete property, watercraft, aircraft, cyber, liability, and other forms via the Insurance for NSW Portal Declaration System | 7 weeks from opening (closes approximately 19 September) | Confirmed — icare Declaration Training Hub |
| Submission and approval | Coordinators submit completed forms; approvers review and approve within agency; icare receives final submissions | Within declaration window | Confirmed — icare Declaration Training Hub |
| Actuarial assessment | Finity processes declared asset values and exposure data; contribution amounts are calculated | Following close of declaration window | Confirmed — icare TMF page (Finity role); Inferred for exact timing |
| Contribution notification | Agencies notified of their deposit contribution for the coming financial year | Inferred — specific timing not publicly documented | Inferred |
| Cover activation | TMF cover applies for the declared financial year based on the submitted declaration | Annually from 1 July | Confirmed — TMF Statement of Cover |

**Key declaration failure modes** (these are structural risk areas, not individual performance issues):
- **Under-declaration**: assets not listed or declared at values below true replacement cost — creates a coverage gap at claim time and actuarial underestimation of the fund's exposure [Confirmed — TMF Statement of Cover notes the importance of declaring all assets; Inferred for frequency of under-declaration]
- **Incorrect asset classification**: assets placed in the wrong category (e.g. watercraft declared as general property) — affects cover terms and contribution accuracy [Inferred from declaration form structure]
- **Missed declaration window**: agencies that fail to complete by the close date — cover uncertainty, contribution estimation errors, operational risk [Confirmed — declaration close date is a firm deadline per icare Declaration Training Hub]
- **Stale asset registers**: agencies using outdated or incomplete asset registers at declaration time — compounding under-declaration over multiple years [Inferred from operational context; no direct source quantifies this]

### 1.5 Claims Handling Model

| Element | Detail | Confidence |
|---|---|---|
| Claims manager | Gallagher Bassett (GB) — appointed by icare to manage property, motor, liability, and other General Lines claims for TMF agencies | Confirmed — icare Making a Claim page |
| Lodgement channel | Insurance for NSW Portal (online); phone notification | Confirmed — icare Making a Claim page; icare portal |
| Agency portal functions | Lodge and notify claims; access Qlik Sense data and reporting; download Certificates of Currency; complete TMF declarations; access REX education | Confirmed — icare About Insurance for NSW page |
| Legal panel | General Lines legal services panel, active from 1 July 2021 — covers seven primary streams including property and liability | Confirmed — icare July 2021 announcement |
| Risk education | Risk Education Express (REX) — complimentary online education for agency staff on TMF cover, claims management, asset protection, and emerging risks; delivered via Insurance for NSW Portal | Confirmed — icare REX page |
| icare oversight role | Scheme design, agency relationship management via Client Engagement Managers (CEMs), actuarial oversight (Finity), reinsurance management (Aon), Gallagher Bassett performance oversight | Confirmed for scheme design and CEM role; Inferred for the specific mechanics of GB performance management in property stream |
| New asset declaration platform | icare issued an RFP in late 2024 (prj_1202) for a new TMF Asset Declaration Platform — indicating the current declaration system is under review or replacement | Confirmed — buy.nsw.gov.au procurement record, November 2024 |

---

## Part 2 — Client Profile and Stakeholder Map

### 2.1 Primary Client: The Agency Risk/Property Manager

Unlike workers compensation schemes where the claimant is an injured worker, the primary service relationship in General Lines Asset is with the **NSW Government agency** — most commonly represented by:

| Role | Responsibilities in the Scheme | Service Expectations Most Relevant |
|---|---|---|
| Risk Manager / Risk Coordinator | Responsible for overall TMF membership, declaration accuracy, and claims management across the agency | Knowledgeable Case Manager; Proactive Service; Timely Decisions; Transparency of Decisions |
| Finance Officer | Manages contribution payments, recovery of claim proceeds, consequential loss accounting | Timely & Accurate Payments; Clear & Accurate Information; Communicating Clear Timelines |
| Facilities / Property Manager | Responsible for building condition, maintenance records, reinstatement oversight | Easy Process; Clear on Process & Next Steps; Proactive Service |
| IT / Cyber Security Manager | Manages cyber declaration and any cyber-related incident claims | Knowledgeable Case Manager; Timely Decisions; Clear & Accurate Information |
| Declaration Coordinator | Agency-designated person responsible for completing and submitting TMF declarations | Easy Process; Clear on Process & Next Steps; Self-Service; Communicating Clear Timelines |
| Gallagher Bassett (as intermediary) | Claims manager — sits between icare and the agency on individual property claims | Reliability; Clear Handover; Professional Case Manager |

### 2.2 Institutional Client Dynamics

The agency client relationship differs structurally from individual claimant relationships:

- **Multiple contacts within a single agency** — a large agency (e.g. NSW Health, Department of Education) may have hundreds of facilities, multiple risk coordinators, and several declaration delegates. A service failure with one contact does not mean all contacts are affected, but systemic issues compound across large agencies.
- **Accountability for public assets** — agency staff are accountable for public property stewardship. Errors in declaration or claim management can have audit and governance consequences, not just financial ones.
- **Budget sensitivity** — contribution amounts affect agency budgets. Under-declaration that results in a coverage gap at claim time, or over-declaration that inflates contributions, creates direct budget impact. Agencies are therefore sensitive to contribution accuracy and timeliness of payment.
- **Sophistication varies by agency size** — large agencies with dedicated risk teams interact very differently from small agencies where the risk role is a secondary duty. Service design must account for this range.
- **Annual touchpoint rhythm** — unlike continuous personal injury claims, the primary regular touchpoint is the annual declaration cycle. Between declarations, agencies interact via claims and ad hoc queries. The declaration period is the highest-intensity engagement window.

---

## Part 3 — Cost Model and Financial Drivers

### 3.1 Dominant Cost Drivers in General Lines Asset

General Lines Asset costs are structurally different from all personal injury schemes. The dominant cost drivers are:

| Cost Driver | Mechanism | Confidence |
|---|---|---|
| Replacement and reinstatement cost | The primary claim cost — the cost to repair, rebuild, or replace damaged or destroyed property at current market rates. High-value assets (hospitals, heritage buildings, major infrastructure) produce very large individual claims. | Confirmed — TMF Statement of Cover |
| Consequential loss | Loss of revenue and/or increased operational costs resulting from physical damage — e.g. a school closed for repairs incurs costs for alternative accommodation; a government facility closed after a flood loses revenue from services. This is covered where approved by icare. | Confirmed — TMF Statement of Cover 2021 |
| Reinsurance recovery complexity | For large or catastrophic claims, recovery from the reinsurance programme (via Aon) involves a separate process and timeline. Incorrect asset valuation at declaration affects the recoverable amount. | Confirmed (reinsurance programme exists); Inferred (recovery complexity as a cost driver) |
| Administrative handling cost | GB's claim management fees; legal panel costs; internal icare administration; declaration management overhead | Inferred — specific fee structure not publicly disclosed |
| Under-declaration leakage | Where an asset is under-declared, the TMF may cover only a proportion of the loss (subject to the policy terms), leaving the agency exposed. This creates a financial gap for the agency and a dispute risk for icare. | Confirmed (under-declaration risk noted in Statement of Cover); Inferred for frequency and scale |
| Declaration error correction rework | When declarations are incorrect, icare and GB must process corrections, potentially adjusting contributions and cover retrospectively — a material administrative cost at scale. | Inferred — no direct source quantifies this |
| Legal and dispute cost | Where agencies dispute settlement amounts, coverage decisions, or contribution calculations, legal panel costs increase. Transparent and accurate initial decisions reduce this. | Inferred — consistent with General Lines legal panel's purpose |

### 3.2 Scale Context

- icare protects $437 billion of NSW Government assets, including the Sydney Opera House, the Sydney Harbour Bridge, schools and hospitals. [Confirmed]
- In the 2024 financial year, icare paid $1.3 billion in NSW Government claims (across all General Lines streams). The property/asset stream's share of this figure is not separately disclosed in publicly available sources. [Confirmed for total; Inferred for stream disaggregation]
- The TMF covers approximately 187 NSW public sector agencies for property and other General Lines risks. [Confirmed — icare Our Story page]

### 3.3 How This Differs from Personal Injury Cost Models

| Dimension | General Lines Asset | Workers Compensation / Lifetime Care |
|---|---|---|
| Primary cost driver | Replacement / reinstatement / consequential loss | Weekly benefits / care plan cost |
| Duration concept | Claim resolution timeline (weeks to months per claim) — not a duration-as-cost lever | Duration directly drives cost (every week = benefit payments) |
| Volume | Moderate — episodic claims driven by incidents (weather, fire, theft, accident) | High (NI: 148,000 active claims) or ongoing (LTC: 9,000 participants) |
| Compounding mechanism | Consequential loss and delayed reinstatement compound administrative cost; weather events create clustered claims | Time × weekly benefit rate = escalating liability |
| Key leverage point | Declaration accuracy; claim assessment speed; reinstatement management; reinsurance recovery | Case management quality; RTW planning; treatment approval speed |
| Volatility driver | Weather events (bushfire, flood, storm); builder insolvency affecting construction projects; cyber incidents | Psychological injury growth; long-tail claim drift; care plan instability |

---

## Part 4 — Service Expectation Analysis

### 4.1 Applying the 16 Service Expectations to General Lines Asset

The 16 service expectations must be interpreted through the institutional client and asset-focused lens, not the individual worker lens. The following analysis maps each expectation to the General Lines Asset context.

| # | Expectation | General Lines Asset Mechanism | Primary Lever | Confidence |
|---|---|---|---|---|
| 1 | Clear Handover | When GB case managers change mid-claim, context about the asset, damage assessment, and reinstatement progress must transfer completely. For complex multi-building or multi-asset claims, handover failure means restarting assessment — extending reinstatement timelines. | Handling efficiency; reinstatement speed | Inferred |
| 2 | Empathy & Understanding | In the institutional context this means understanding the agency's operational urgency — a hospital ward unavailable, a school closed, a heritage asset damaged. "Empathy" here is operational awareness of the asset's public service function, not personal distress management. | Agency confidence; operational continuity | Inferred |
| 3 | Knowledgeable Case Manager | Accurate interpretation of TMF cover; correct assessment of damage scope; understanding of heritage, cultural property, and consequential loss rules; correct reinsurance threshold awareness. Knowledge gaps produce under-settlement, over-settlement, or disputes. | Leakage control; cost accuracy; dispute prevention | Inferred |
| 4 | Reliable Case Manager | Following through on assessment commitments and reinstatement milestones. Agencies managing public infrastructure need predictable timelines. Missed commitments delay reinstatement and increase consequential loss exposure. | Handling efficiency; consequential loss control | Inferred |
| 5 | Professional Case Manager | Institutional relationship quality appropriate for a B2B government context. Agencies expect professional engagement consistent with public sector accountability expectations. | Agency confidence | Inferred |
| 6 | Proactive Service | Early engagement after an incident report; proactive updates on assessment progress; anticipating evidence requirements (building reports, valuations, contractor assessments). Prevents agencies from having to chase progress on reinstatement. | Cycle time; consequential loss reduction | Inferred |
| 7 | Timely Service | Prompt response to agency queries about claim status, settlement progress, or cover questions. Delays in response slow reinstatement decisions and extend consequential loss exposure. | Operational continuity; handling efficiency | Inferred |
| 8 | Self-Service | Portal-based claim lodgement, document upload, claim tracking, and declaration completion. Reduces GB contact dependency for routine tasks. At declaration time, the declaration system is the primary self-service interface. | Cost-to-serve; agency efficiency | Confirmed (portal and declaration system exist); Inferred for improvement opportunity |
| 9 | Channel Preferences | Matching to agency communication preference — email, portal, phone, or account manager contact. Large agencies with dedicated risk teams prefer structured account management; small agencies may prefer simpler channels. | Handling efficiency; relationship quality | Inferred |
| 10 | Clear & Accurate Information | Accurate cover guidance at declaration time and claim time; clear explanation of what is and is not covered (e.g. consequential loss approval conditions; cyber coverage scope); clear excess and exclusion communication. Reduces disputes at settlement and under-declaration errors. | Leakage control; declaration accuracy; dispute prevention | Inferred |
| 11 | Easy Process | Streamlined declaration completion; minimal re-submission at claim time; clear evidence requirements upfront (damage reports, valuations, contractor quotes). The declaration process is specifically complex — the buy.nsw 2024 RFP for a new declaration platform signals this is a known friction point. | Cycle time; declaration accuracy; administrative cost | Confirmed (declaration complexity is a known issue — RFP prj_1202 issued Nov 2024); Inferred for claim process friction |
| 12 | Clear on Process & Next Steps | Agencies know: how to complete their declaration, what happens after lodgement, what evidence is needed for their specific asset type, when to expect an assessment outcome. Particularly critical at declaration time and following a major weather event. | Cycle time; compliance; declaration accuracy | Inferred |
| 13 | Communicating Clear Timelines | Reinstatement timelines for operational planning; expected claim assessment milestones; declaration completion windows. Agencies need timeline clarity to manage operational disruption (e.g. temporary accommodation, service continuity). | Operational continuity; consequential loss control | Inferred |
| 14 | Timely Decisions | Assessment and settlement decisions directly control reinstatement timelines. Delayed decisions extend consequential loss exposure (lost revenue, increased operational cost). For weather-event clusters, decision speed affects multiple agencies simultaneously. | Cycle time; consequential loss control; cost containment | Inferred |
| 15 | Transparency of Decisions | Clear rationale for coverage decisions, settlement amounts, or declinatures. Agencies with accountability for public asset stewardship need to understand and explain decisions internally and to auditors. Opaque decisions increase legal panel referral. | Dispute prevention; legal cost; agency confidence | Inferred |
| 16 | Timely & Accurate Payments | Correct settlement amount paid promptly after assessment. Correct consequential loss payment where approved. Inaccurate payments — over or under — create rework, contribution disputes, and agency budget disruption. | Financial accuracy; agency trust | Inferred |

*All 16 mechanisms are graded Inferred pending General Lines Asset-specific evidence review. The service expectations framework is well-evidenced for workers compensation schemes; its application to the property/asset institutional context is derived by analogy.*

### 4.2 High-Priority Expectations for General Lines Asset

Based on scheme mechanics and available evidence, the following expectations carry the highest structural leverage in General Lines Asset:

**Tier 1 — Highest leverage (scheme-structural)**

- **Easy Process / Self-Service** — the declaration process is confirmed as a complexity point (buy.nsw RFP prj_1202, November 2024 procurement); a new declaration platform is actively being procured. Any improvement here has annual impact across all 187 member agencies.
- **Timely Decisions** — reinstatement of government infrastructure cannot commence without settlement decisions; delay directly extends consequential loss exposure which is itself a covered cost driver.
- **Clear & Accurate Information** — under-declaration is a confirmed risk in the scheme; information quality at declaration time directly governs whether assets are correctly declared and whether agencies understand coverage limits.

**Tier 2 — High leverage (operationally material)**

- **Communicating Clear Timelines** — agencies managing public service continuity need reinstatement milestones for operational planning; timeline uncertainty prolongs disruption.
- **Knowledgeable Case Manager** — cover complexity (cyber, consequential loss, cultural property, reinsurance thresholds) means case manager knowledge errors produce material settlement errors.
- **Transparency of Decisions** — agencies with audit accountability need to understand and explain settlement decisions; opacity creates internal governance risk and dispute escalation.

**Tier 3 — Standard operational relevance**

All remaining expectations apply and are relevant; their leverage in this scheme is lower than Tier 1 and 2 because they affect handling efficiency rather than primary cost drivers.

---

## Part 5 — Opportunity Hypothesis Framework

### 5.1 How to Generate and Grade Opportunity Hypotheses

All opportunity hypotheses for General Lines Asset must:

1. **Name the specific mechanism** — how does the service improvement change an agency behaviour, a claim outcome, or an administrative process? Be specific: "improving declaration guidance reduces under-declaration errors" not "improving information quality".

2. **Identify the cost lever** — which of the scheme's cost drivers does this affect? (Replacement/reinstatement cost; consequential loss; reinsurance recovery; administrative handling; leakage; dispute/legal cost)

3. **Grade the evidence** — using The Playbook standard: Confirmed (directly cited source), Inferred (logically derived), Asserted (not yet grounded — flag and remove from stakeholder-facing outputs)

4. **Flag the data gap** — what operational data would confirm the hypothesis? (e.g. declaration error rates; under-declaration incidence; claim cycle time disaggregated by asset type; consequential loss claim frequency)

5. **Avoid workers compensation framing** — do not express impact as "weeks of weekly benefits avoided". Express it as "days to reinstatement reduced", "consequential loss exposure shortened", "declaration error rate reduced", "legal panel referrals avoided".

### 5.2 Live Opportunity Hypotheses (Current Evidence Base)

The following hypotheses are generated from available public evidence. All are graded Inferred unless noted otherwise.

---

**Hypothesis 1: Declaration system usability improvements reduce under-declaration errors and contribution inaccuracies**

*Mechanism:* The annual declaration process requires agencies to declare all asset values across multiple form types (property, watercraft, aircraft, cyber, liability). Declaration errors — under-declaration, incorrect asset classification, missed assets — create coverage gaps and inaccurate contribution calculations. A new declaration platform is actively being procured (RFP prj_1202, buy.nsw, November 2024), signalling icare has identified this as a known friction point.

*Cost lever:* Under-declaration leakage; contribution accuracy; administrative rework from corrections; consequential recovery shortfall at claim time.

*Evidence grade:* Confirmed that declaration complexity is a known institutional concern (buy.nsw procurement record); Inferred that simplification reduces error rates; declaration error rates are not publicly disclosed.

*Data gap:* Under-declaration incidence rate; correction request volume per declaration cycle; contribution adjustment frequency.

---

**Hypothesis 2: Faster post-incident assessment decisions reduce consequential loss exposure for government agencies**

*Mechanism:* Consequential loss (lost revenue and increased operating costs following physical damage) is a covered cost under the TMF. The longer it takes to assess and settle a claim, the longer the agency continues to incur consequential loss costs. For high-service assets (hospitals, schools), each day of delayed assessment is a day of additional covered consequential loss.

*Cost lever:* Consequential loss quantum; reinstatement timeline; operational continuity.

*Evidence grade:* Confirmed that consequential loss is covered by the TMF (Statement of Cover 2021); Inferred that decision delay extends covered consequential loss exposure; no data quantifying average assessment cycle time is publicly available.

*Data gap:* Average days from incident notification to settlement decision by asset type; consequential loss claim volume and average cost; assessment cycle time disaggregated by GB handler.

---

**Hypothesis 3: Proactive agency engagement during the declaration window reduces missed and late declarations**

*Mechanism:* The declaration window runs for 7 weeks from late July to mid-September. Agencies that miss the window or submit incomplete declarations create administrative burden for icare (corrections, estimates, contribution adjustments) and carry uncovered exposure risk. Proactive communication — reminders, webinar support, direct engagement from Client Engagement Managers — during the window reduces late and incomplete submissions.

*Cost lever:* Declaration accuracy; administrative rework; contribution calculation accuracy.

*Evidence grade:* Confirmed that the declaration window has firm dates and icare conducts declaration training webinars (icare Declaration Training Hub); Inferred that proactive engagement reduces late/incomplete rates; late declaration incidence is not publicly reported.

*Data gap:* Late declaration rate by agency; incomplete declaration rate; correction request volume per cycle; CEM engagement frequency during declaration period.

---

**Hypothesis 4: Clear guidance on consequential loss approval conditions reduces post-claim disputes**

*Mechanism:* Consequential loss is covered only where approved by icare. The conditions for approval are described in the Statement of Cover but may not be well understood by agency finance and property staff. If agencies incur consequential costs without prior icare approval, those costs may be declined. Unclear understanding at claim lodgement creates disputes post-settlement and legal panel referral risk.

*Cost lever:* Dispute and legal cost; consequential loss claim accuracy; agency trust.

*Evidence grade:* Confirmed that consequential loss requires icare approval (Statement of Cover 2021); Inferred that clarity gaps produce post-settlement disputes; dispute rate for consequential loss claims is not publicly reported.

*Data gap:* Consequential loss approval rate; dispute rate on consequential loss decisions; legal panel referral rate for property stream.

---

**Hypothesis 5: REX education programme participation improves agency declaration and claims capability, reducing administrative friction**

*Mechanism:* REX (Risk Education Express) offers complimentary education to NSW Government agency employees on TMF cover, claims management, and risk management. Agencies with higher REX participation rates should theoretically produce more accurate declarations, manage incidents more effectively, and require less case manager time per claim. This is a prevention and capability lever rather than a claims handling lever.

*Cost lever:* Administrative handling cost; declaration accuracy; claim volume (through better risk management).

*Evidence grade:* Confirmed that REX exists and is complimentary (icare REX page); Inferred that participation improves outcomes; no published correlation between REX participation rates and claims or declaration quality.

*Data gap:* REX participation rate by agency size; claim frequency correlation with REX participation; declaration error rate by REX engagement level.

---

**Hypothesis 6: Improved cover communication at key transition points reduces cyber-related under-declaration**

*Mechanism:* Cyber coverage under the TMF covers data restoration, investigation, public relations services, and denial-of-service attack containment. This is a relatively new and complex coverage type. Agency IT and security managers who are not familiar with what must be declared and what is covered may under-declare cyber exposure or fail to notify cyber-related incidents promptly.

*Cost lever:* Cyber claim completeness; under-declaration; consequential loss from unreported incidents.

*Evidence grade:* Confirmed that cyber coverage is included in the TMF Statement of Cover 2021; Inferred that cyber-specific under-declaration is a risk; no data on cyber declaration completeness or claim frequency is publicly available.

*Data gap:* Cyber declaration completion rate; cyber claim lodgement rate relative to declared exposure; comparison between declared cyber exposure and actual agency-reported cyber incidents.

---

## Part 6 — Confidence and Evidence Standards

### 6.1 The Playbook Grade Definitions for This Scheme

| Grade | Definition | Example in General Lines Asset Context |
|---|---|---|
| Confirmed | Directly stated in a cited, high-confidence public source — TMF Statement of Cover, icare website, buy.nsw procurement records, icare Annual Reports, legislative text | "Consequential loss is covered where approved by icare" — directly from TMF Statement of Cover 2021 |
| Inferred | Logically derived from confirmed facts or by analogy from the broader icare operational context | "Declaration usability improvements are likely to reduce error rates" — derived from the confirmed existence of the buy.nsw RFP for a new declaration platform, not directly stated in a source |
| Asserted | Present in an output but not grounded in either confirmed or inferred reasoning — must be flagged and removed from stakeholder-facing material before release | "Under-declaration occurs in 15% of agency submissions" — no source; this is asserted and must not appear without grounding |

### 6.2 Known Evidence Gaps

The General Lines Asset evidence base is thinner than the NI or LTC evidence bases. The following gaps apply to all analytical work in this scheme until resolved:

| Gap | Impact on Analysis | Action Required |
|---|---|---|
| No publicly available disaggregation of the $1.3bn General Lines claims total by stream | Cannot quantify the asset stream's scale or share | Source from icare financial statements or GB operational data |
| Declaration error rate, under-declaration incidence, and late declaration volume are not published | All declaration improvement hypotheses are Inferred | Source from icare internal declaration management data |
| Claim cycle time (days from notification to settlement) by asset type is not published | Cannot quantify the consequential loss impact of delayed decisions | Source from GB operational data or icare CSP performance reporting |
| Legal panel referral rate for the property stream is not published | Cannot quantify dispute-driven cost | Source from GB or legal panel reporting |
| REX participation rate and its correlation with claims outcomes is not published | REX improvement hypothesis remains unanchored | Source from icare REX data and claims history correlation |
| The 2024 TMF Statement of Cover — specific property exclusions list | May differ from 2021 version; must be confirmed from 2024 document | Fetch directly from icare website (TMF Statement of Cover 2024, PDF) |

### 6.3 Source Hierarchy for This Scheme

| Tier | Sources | Confidence |
|---|---|---|
| Primary | TMF Statement of Cover (2024 version — most current); NSW Self Insurance Corporation Act 2004; State Insurance and Care Governance Act 2015; icare Making a Claim page; icare Declaration Training Hub | High |
| Secondary | icare Annual Reports 2023–24 and 2024–25; icare About Insurance for NSW page; icare Our Story page; icare REX page | High |
| Supporting | buy.nsw procurement records (RFP prj_1202); icare news announcements (e.g. July 2021 legal panel); Gallagher Bassett TMF page | Confirmed (existence); Inferred (operational implications) |
| External benchmarking | APRA General Insurance Statistics; comparable public sector self-insurance schemes in other Australian jurisdictions | Medium |

---

## Part 7 — Reform and External Context

### 7.1 Active Reform Signals

| Signal | Relevance to General Lines Asset | Confidence |
|---|---|---|
| TMF Asset Declaration Platform RFP (buy.nsw prj_1202, November 2024) | icare has initiated procurement for a new declaration platform, explicitly acknowledging the need to modernise the annual declaration process. This is the single strongest confirmed signal of a known friction point in the scheme. | Confirmed — buy.nsw procurement record |
| TMF Statement of Cover updated July 2024 | The 2024 Statement of Cover is the current operative document, updated from the 2021 and 2017 versions. Changes in the 2024 version may affect cover scope, exclusions, or conditions for property claims. | Confirmed (existence of 2024 version); Inferred (changes from prior version require document review) |
| icare independent review remediation — 107 recommendations addressed | icare has formally addressed all 107 recommendations from its independent review. The extent to which General Lines Asset processes were affected is not confirmed from publicly available sources. | Confirmed for overall remediation; Inferred for General Lines Asset applicability |
| Reinsurance provider change — Aon from 2024 | A new reinsurance arrangement with Aon commenced in 2024, replacing the prior provider. This may affect reinsurance recovery processes for large property claims. | Confirmed (Aon appointment); Inferred (operational implications for claims) |
| Climate and extreme weather event frequency | Increasing frequency of weather events (bushfire, flood, storm) creates clustered property claims across multiple agencies simultaneously, testing GB capacity and icare's consequential loss management. | Confirmed (climate risk is referenced in icare materials); Inferred for specific impact on property claims volume |

### 7.2 Service Improvement Framing for General Lines Asset

In General Lines Asset, service improvement should be framed as:

- **Operational efficiency for agencies** — faster claim resolution = faster reinstatement = uninterrupted public service delivery
- **Declaration accuracy** — better tools and guidance = correct asset declaration = accurate contributions and full cover at claim time
- **Contribution stability** — better risk management and accurate declaration = stable and predictable contribution amounts for agency budgets
- **Handling cost reduction** — fewer rework cycles, disputes, and legal referrals = lower GB and icare operational cost
- **Institutional confidence** — reliable, professional claims management and declaration support builds agency confidence in the TMF as their mandatory scheme

Not as:
- Individual claimant empowerment or distress management
- Return-to-work or recovery outcomes
- Duration reduction (in the personal injury sense)

---

## Part 8 — Quick Reference for Common Tasks

**Generating an opportunity hypothesis**
→ Use the format in Part 5.2. Anchor to the correct cost driver (reinstatement cost, consequential loss, declaration accuracy, handling efficiency, dispute/legal). Frame the mechanism through agency operational impact and public asset stewardship. Grade the evidence. Flag what data would confirm the hypothesis. Never express impact as weekly benefit weeks saved.

**Framing a service expectation for an executive audience in General Lines Asset**
→ Lead with the agency operational context (government building unavailable, public service disrupted, heritage asset damaged, annual declaration approaching). State the expectation as a handling efficiency, declaration accuracy, or dispute prevention mechanism. Use institutional client framing throughout. Avoid personal injury language.

**Checking a claim's confidence grade**
→ Ask: is this directly stated in the TMF Statement of Cover (2024), NSW Self Insurance Corporation Act 2004, icare Insurance for NSW website, icare Annual Reports, or buy.nsw procurement records? If yes: Confirmed. If derived through reasoning from those sources or by analogy from General Lines Motor or other icare schemes: Inferred — label explicitly. If neither: Asserted — remove or reclassify.

**Assessing whether a service improvement applies to General Lines Asset**
→ Check: does it reduce claim cycle time, declaration error rate, consequential loss exposure, handling cost, dispute rate, or legal referral? Does it address the institutional client's operational or budget concerns? Is the mechanism traceable to the TMF's self-insurance design, declaration cycle, or asset protection mandate? If yes on one or more: it is a valid opportunity hypothesis, graded Inferred unless directly evidenced.

**Identifying evidence gaps**
→ Refer to Part 6.2. For any quantified opportunity hypothesis, identify which gap area applies and flag it explicitly before the hypothesis is presented to stakeholders. No dollar-level claim should be made about General Lines Asset improvement opportunities until asset-stream-specific cost data is confirmed.

**Distinguishing General Lines Asset from General Lines Motor**
→ Asset = property, buildings, contents, cultural assets, cyber, watercraft, aircraft. Motor = government vehicles. Both are General Lines TMF streams, both managed by Gallagher Bassett, but cost drivers, declaration processes, and claim mechanics are distinct. Do not merge these into a single analysis unless explicitly producing a combined General Lines overview.

---

## Appendix A — Key Evidence Sources

| Source | Role in General Lines Asset Analysis | Confidence |
|---|---|---|
| NSW Self Insurance Corporation Act 2004 | Legislative foundation — SICorp and TMF establishment | Confirmed |
| State Insurance and Care Governance Act 2015 | icare mandate; governance framework | Confirmed |
| Government Sector Finance Act 2018 | Financial reporting obligations | Confirmed |
| TMF Statement of Cover 2024 (current version) | Cover scope, exclusions, consequential loss conditions, excess, cyber coverage — primary reference for all coverage questions | Confirmed (document exists, uploaded July 2024); full text requires direct download |
| TMF Statement of Cover 2021 | Prior operative version — useful for specific clauses where 2024 version has not yet been reviewed | Confirmed |
| NSW Treasury Circular TC-20-05 | Mandatory TMF membership for agencies | Confirmed |
| icare Insurance for NSW — Making a Claim page | Gallagher Bassett appointment for property claims; lodgement channels | Confirmed |
| icare Declaration Training Hub | Declaration calendar; process; form types; user roles | Confirmed |
| icare Property Declaration page | Property-specific declaration guidance; buildings vs contents; leasing scenarios | Confirmed |
| icare About Insurance for NSW page | Portal functions; agency overview; scope of cover summary | Confirmed |
| icare Our Story page | $437bn assets; 187 agencies; scale context | Confirmed |
| icare REX page | Risk Education Express — complimentary education programme for agency staff | Confirmed |
| icare Annual Reports 2023–24 and 2024–25 | Enterprise context; $1.3bn General Lines claims (FY24); $437bn assets | Confirmed |
| buy.nsw procurement record — RFP prj_1202 (November 2024) | TMF Asset Declaration Platform procurement — confirms declaration complexity as a known friction point | Confirmed |
| icare news announcement — July 2021 | General Lines legal services panel — seven primary streams confirmed | Confirmed |

---

*A note on confidence posture: This skill carries predominantly Inferred material at the opportunity hypothesis level, which is correct and honest given the General Lines Asset evidence base. Asset-specific performance data, declaration error rates, claim cycle time, and cost disaggregation are not publicly available. The skill flags this throughout rather than masking it. This is consistent with The Playbook standard: a well-marked inference is more useful than a suppressed evidence gap. The single strongest confirmed signal of a structural friction point is the buy.nsw procurement of a new TMF Asset Declaration Platform (November 2024) — all analytical work should treat this as an anchor for the "Easy Process / Self-Service" opportunity.*
