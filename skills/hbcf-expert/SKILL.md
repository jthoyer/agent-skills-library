---
name: hbcf-expert
description: Activates Claude as a resident expert on the NSW Home Building Compensation Fund (HBCF)
  as administered by icare NSW under the Home Building Act 1989. Use this skill whenever
  a task requires reliable, traceable analysis of the HBCF — including scheme mechanics,
  legislative structure, customer journey, service expectation positioning, opportunity
  hypothesis generation, cost driver analysis, executive framing, or evidence-graded
  research outputs. Trigger whenever the user references HBCF, Home Building Compensation
  Fund, builder insolvency, defective building work, homeowner claims, rectification,
  statutory warranty, the Home Building Act, or improvement opportunities in the HBCF
  scheme. Also trigger for any task that requires The Playbook confidence-grading discipline
  (Confirmed / Inferred / Asserted) applied to HBCF scheme material.
---

## Purpose

This skill encodes the knowledge base, analytical frameworks, evidence hierarchy, and output standards required to act as a reliable expert on the NSW Home Building Compensation Fund (HBCF) administered by icare NSW. It governs how Claude reasons about scheme mechanics, homeowner and builder profiles, service expectations, cost drivers, and improvement opportunities — and how it communicates findings in a way that is grounded, traceable, and fit for executive and programme use.
> **Critical framing distinction:** HBCF is not a personal injury scheme. The dominant cost driver is not claim duration (as in the NI) nor care plan volatility (as in Lifetime Care) but rectification cost — arising from the nature, extent, and management of building defects following builder insolvency or death. All analysis must be anchored to this distinction. Applying workers compensation duration logic or Lifetime Care volatility logic directly to HBCF produces the wrong analytical frame.

## Part 1 — Scheme Fundamentals

### 1.1 Legislative and Governance Base
ElementDetailConfidencePrimary legislationHome Building Act 1989 (NSW) — establishes the statutory warranty framework, builder eligibility requirements, and the HBCF insurance obligation for residential building workConfirmedGovernance frameworkState Insurance and Care Governance Act 2015 (NSW) — establishes icare's mandate across schemes including HBCFConfirmedFinancial reporting obligationGovernment Sector Finance Act 2018 (NSW)ConfirmedScheme administratorInsurance and Care NSW (icare) — administers the HBCF, assesses claims, manages rectification, and sets premium and eligibility policiesConfirmedRegulatorNSW Fair Trading — has a role in licensing builders and enforcing building standards; interacts with HBCF claim assessmentConfirmed [Inferred from icare HBCF website and HBA 1989 — the exact regulatory interface with icare requires direct source confirmation]Key contractHomeowners requiring the insurance product must be covered by a certificate of insurance before a builder can receive a deposit on eligible residential workConfirmed
### 1.2 Scheme Identity
HBCF is a last-resort statutory insurance scheme that protects homeowners who have engaged a licensed builder to carry out eligible residential building work in NSW. It is:

Not a first-resort insurer — HBCF only responds when the builder has become insolvent, died, or disappeared, or (in limited circumstances) has had their licence suspended. It does not respond where the builder is still trading, even if the work is defective. [Confirmed — Home Building Act 1989; icare HBCF website]
Not a personal injury scheme — the claimant is a homeowner with a defective or incomplete building; there are no weekly benefits, no treatment approvals, and no return-to-work mechanics
Rectification-first in design — the scheme's preferred outcome is completing or rectifying work to an acceptable standard, not cash settlement. This makes cost management fundamentally about scope-of-works control and contractor engagement, not duration of income replacement
Defined warranty periods — eligibility is bounded by statutory warranty periods under the Home Building Act: 6 years for major defects (structural), 2 years for non-major (non-structural) defects. Warranty period management is therefore a core scheme mechanic [Confirmed — Home Building Act 1989 Part 2C]
Premium-funded, not tax-funded — premiums are paid by builders for each eligible contract, creating a cross-subsidy between high-risk and low-risk builder cohorts. HBCF financial sustainability is therefore sensitive to builder insolvency rates, premium adequacy, and claims frequency trends [Confirmed — icare Annual Report; icare HBCF website]
Volume subject to insolvency cycles — unlike the NI where claim volume is relatively stable, HBCF claim volumes are sensitive to the construction industry cycle. Rising builder insolvencies (notably elevated post-2022 due to cost pressures) drive increased claim lodgements [Confirmed — icare Annual Report 2023–24 and 2024–25 note HBCF claims increased due to insolvencies]

### 1.3 Eligible Work and Claim Triggers
ElementDetailConfidenceEligible workResidential building work valued above the threshold (currently $20,000); must be carried out by a licensed contractorConfirmed — Home Building Act 1989Mandatory coverageBuilder must obtain a certificate of insurance before taking a deposit on eligible workConfirmedClaim triggers (active)Builder insolvency (most common), builder death, builder disappearanceConfirmedClaim triggers (limited)Licence suspension following a court or tribunal finding — applies only in specific circumstancesConfirmed — Home Building Act 1989; icare HBCF websiteWarrant periods6 years — major defects (structural); 2 years — non-major defectsConfirmed — Home Building Act 1989 Part 2CWhat HBCF coversLoss arising from defective or incomplete work; does not cover normal wear and tear, maintenance, or cosmetic issuesConfirmed
### 1.4 Scheme Scale
MetricFigureSourceAnnual claims volumeNot publicly confirmed with precision; elevated post-2022 due to builder insolvency cycleicare Annual Report 2023–24 and 2024–25 — directional reference only [Inferred — specific claim count not confirmed in publicly available sources reviewed to date]Builder insolvency trendElevated relative to pre-2022 baselineicare Annual Reports 2023–24 and 2024–25 [Confirmed — directional; exact insolvency rate not cited]Premium revenueDisclosed within icare financial statements as part of total premium income across schemesicare Financial Statements [Confirmed — scheme-specific disaggregation requires direct source review]Coverage thresholdResidential work above $20,000Home Building Act 1989 [Confirmed]
Critical note on scale: HBCF's cost exposure is driven more by rectification cost per claim than by claim volume alone. A small number of large, complex defects (particularly structural failures in multi-unit developments) can dominate scheme costs in any given year. This makes per-claim severity management as important as frequency management.
### 1.5 Key Parties
PartyRoleicareScheme administrator — assesses claims, approves rectification scope, engages contractors, manages premium and eligibilityHomeownersClaimants — primary beneficiaries; often in financial distress and emotionally stressed due to uninhabitable or significantly defective homesLicensed buildersPremium payers and scheme participants; when insolvent or deceased they trigger HBCF coverageRectification contractorsAppointed by icare to carry out approved rectification worksNSW Fair TradingBuilder licensing authority; enforces building standards; interacts with HBCF through licence-related claim triggersLegal representativesIncreasingly involved where homeowners dispute scope of rectification or claim decisionsStrata managers / owners corporationsRelevant where HBCF claims arise from multi-unit residential developments

## Part 2 — Cost Driver Logic

### 2.1 The Primary Cost Driver: Rectification Scope and Complexity
In the HBCF, the dominant cost variable is not time (as in the NI) or care volatility (as in Lifetime Care) but rectification cost — the amount required to complete or correct building work to the standard required under the statutory warranty.
Rectification cost is driven by:

Defect severity and scope — structural defects (major defects under the 6-year warranty) are significantly more expensive to rectify than non-structural defects. Multi-unit developments with structural failures can produce very large individual claims.
Builder insolvency complexity — when a builder becomes insolvent mid-project, the extent of incomplete work, the availability of documentation, and the condition of materials already on-site all affect rectification cost.
Scope assessment quality — the accuracy of the initial scope-of-works assessment governs both rectification adequacy and cost control. Under-scoped assessments lead to variation orders and cost overruns; over-scoped assessments expose the scheme to excessive spend.
Contractor availability and cost — HBCF is exposed to the construction market. When contractor capacity is constrained (as during post-COVID supply chain pressures), rectification costs rise and timelines extend. This is an exogenous cost driver the scheme cannot fully control.
Claim lifecycle length — the longer a claim remains open, the greater the administrative, legal, and contractor management cost. Claims that enter dispute, require tribunal proceedings, or stall at scope-agreement stage generate compounding overhead.
Legal involvement — legal representation by homeowners, particularly in disputed scope decisions, increases claim management cost materially and lengthens resolution timelines.

### 2.2 Secondary Cost Drivers
DriverMechanismConfidenceHomeowner distress and escalationEmotionally distressed homeowners in uninhabitable dwellings are more likely to escalate, seek legal advice, and initiate formal complaintsInferred — supported by the scheme's nature; not directly measured in cited sourcesScope disputeWhere homeowners contest the scope or quality of approved rectification, claims stall and legal cost accumulatesConfirmed — consistent with icare HBCF website description and scheme designIncomplete documentation from insolvent builderMissing permits, plans, or specifications increase assessment time and scope uncertaintyInferred — logical from insolvency context; not directly measured in cited sourcesWarranty period disputesDisputes about whether a defect was within the warranty period extend the claim and may require expert assessmentInferred — logical from HBA 1989 warranty structureMulti-unit development complexityStrata-titled developments involve multiple claimants, strata managers, and owners corporations, multiplying coordination costInferred — supported by scheme structure
### 2.3 The Cost Control Imperative
For HBCF, cost control operates through three primary levers (distinct from the NI duration levers):

Scope accuracy — getting the rectification scope right at first assessment reduces variation, rework, and dispute
Claim lifecycle management — reducing dwell time between assessment, approval, contractor engagement, and completion
Escalation prevention — keeping homeowners informed, reducing distress-driven escalation and legal involvement

These levers map directly to service expectation gaps and improvement opportunities.

## Part 3 — The 16 Service Expectations Applied to HBCF

The 16 service expectations were developed in the NI context but apply across icare schemes with scheme-specific adaptation. For HBCF, the mapping requires care: some expectations translate directly, some apply by analogy with a different mechanism, and some are peripheral.
### 3.1 Expectation Mapping
#ExpectationHBCF ApplicabilityMechanism in HBCF ContextEvidence Grade1Clear HandoverDirectCase manager changes disrupt homeowner trust and scope continuity; a new manager unfamiliar with the claim history may re-assess scope or lose context, extending resolution timeInferred2Empathy & UnderstandingDirect — heightenedHBCF homeowners are often in acute distress (uninhabitable homes, financial exposure, legal complexity); perceived indifference significantly increases escalation and legal engagementInferred — mechanism well-supported by scheme context; not directly measured3Knowledgeable Case ManagerDirectComplex building defect assessment requires technical knowledge (structural vs non-structural classification, warranty period application, scope scoping); knowledge gaps increase variation orders, scope disputes, and costInferred4Reliable Case ManagerDirectPromises on timeline and next steps that are not followed through increase homeowner anxiety and drive escalationInferred5Professional Case ManagerDirectIn a high-distress context, professionalism (treating the homeowner as a person not a claimant number) directly reduces adversarial escalationInferred6Proactive ServiceDirectEarly contact and expectation-setting at claim lodgement reduces the anxiety that drives premature escalation; proactive updates during contractor engagement reduce re-contactInferred7Timely ServiceDirectDelayed responses in a context where the homeowner's home may be uninhabitable compound distress rapidly; timely responses are a trust and escalation controlInferred8Self-ServiceApplicable by analogy — partialDocument lodgement, status tracking, and evidence submission could be completed digitally; however, HBCF claim complexity means self-service cannot replace case manager engagement at key decision pointsInferred9Channel PreferencesApplicable — lower weightCommunication channel preference matters for homeowner engagement but is less critical to cost outcomes than in high-volume schemesInferred10Clear & Accurate InformationDirect — high leverageMisunderstanding of what HBCF covers, what the scope of rectification includes, and what the process is generates significant re-contact, dispute, and legal engagementInferred11Easy ProcessDirectA complex claims process (multiple forms, unclear evidence requirements, opaque decision pathways) increases submission errors, delays, and homeowner frustrationInferred12Clear on Process and Next StepsDirectWithout a clear roadmap, homeowners in distress default to escalation; knowing what happens next and when reduces defensive behaviourInferred13Communicating Clear TimelinesDirect — high leverageIn a scheme where rectification can take months, unclear timelines create chronic anxiety; homeowners who cannot predict when their home will be habitable are more likely to seek legal interventionInferred14Timely DecisionsDirectDelayed scope decisions, delayed contractor approvals, and delayed claim assessments extend the claim lifecycle and increase cost directlyInferred15Transparency of DecisionsDirectScope decisions and coverage determinations that are not clearly explained generate formal disputes, tribunal referrals, and legal costInferred16Timely & Accurate PaymentsApplicable — adaptedIn HBCF, the equivalent is timely and accurate rectification approvals and contractor payment; delays in paying contractors stall works and extend claim duration; where cash settlements apply, accuracy mattersInferred
> **Key observation:** In HBCF, all 16 expectations remain relevant but the mechanism shifts. The cost impact is through claim lifecycle extension and escalation into dispute or legal proceedings, rather than weekly benefit leakage. The financial leverage is lower per claim than in the NI at scheme level due to lower volume, but individual claim costs can be very high.

## Part 4 — Evidence Hierarchy

### 4.1 Source Tiers for HBCF
TierSource TypeExamplesConfidenceTier 1 — Primary legislativeAct of ParliamentHome Building Act 1989 (NSW); State Insurance and Care Governance Act 2015 (NSW)ConfirmedTier 1 — Primary regulatoryicare official scheme documentationicare HBCF website (scheme coverage, claim process, eligibility); icare Annual ReportsConfirmedTier 2 — Performance dataScheme performance indicatorsicare Annual Reports 2023–24 and 2024–25 — references to HBCF claims growth due to insolvenciesConfirmed — directionalTier 2 — Regulatory/auditNSW Fair TradingBuilder licensing data, compliance findingsConfirmed as a source type; specific data requires direct source reviewTier 3 — AnalogicalNI and LTC reference packsService expectation mechanisms that apply by analogy with adjustmentInferred — analogy must be stated explicitlyNot admissibleAsserted claimsAny claim about HBCF cost impacts without a cited Tier 1 or Tier 2 sourceAsserted — must be removed or reclassified
### 4.2 Confirmed Evidence Anchors
SourceWhat it confirms for HBCFHome Building Act 1989 (NSW)Statutory warranty periods (6yr/2yr); eligible work definition; builder insurance obligation; claim triggers (insolvency, death, disappearance, licence suspension)icare Annual Reports 2023–24 and 2024–25HBCF claims increased due to insolvencies; HBCF as part of icare's scheme portfolio; enterprise financial contexticare HBCF websiteScheme coverage, claim process, eligibility, rectification-first designSICG Act 2015icare mandate across all schemes including HBCF; governance structureicare Financial Statements FY25Enterprise financial scale; HBCF-specific disaggregation requires direct source review
### 4.3 Known Evidence Gaps
The following are material gaps that must be flagged when producing HBCF analysis:

Claim volume data — precise annual claim counts for HBCF are not confirmed in publicly reviewed sources; directional references from Annual Reports only
Average rectification cost per claim — not confirmed in publicly reviewed sources; required before any financial sensitivity modelling can be produced
Claim lifecycle duration benchmarks — time from lodgement to rectification completion not confirmed; required to model cost-of-delay levers
Escalation and dispute rates — proportion of HBCF claims entering formal dispute or tribunal proceedings not confirmed in publicly reviewed sources
Homeowner experience data — no NPS, satisfaction, or complaint rate data confirmed at scheme level for HBCF from publicly reviewed sources

These gaps define the evidence collection agenda for any HBCF opportunity hypothesis work.

Part 5 — Opportunity Hypothesis Generation
5.1 Analytical Logic for HBCF Opportunities
Unlike the NI (where opportunities are traced to claim duration reduction) or Lifetime Care (where they are traced to cost volatility dampening), HBCF opportunities are traced to one or more of:

Rectification cost reduction — through more accurate scope assessment, better contractor management, or earlier defect identification
Claim lifecycle compression — through faster decisions, clearer process, and reduced rework
Escalation prevention — through better homeowner communication, clearer timelines, and more empathetic case management
Premium adequacy protection — through accurate risk pricing enabled by better claims data

5.2 Opportunity Hypothesis Format
Every HBCF opportunity hypothesis must follow this structure:

Expectation: [Named service expectation]
Mechanism: When [expectation gap], homeowners [behavioural response], which leads to [system effect], which drives [cost outcome].
Lever: [Rectification cost / Claim lifecycle / Escalation / Premium adequacy]
Evidence grade: [Confirmed / Inferred / Asserted]
Source: [Tier 1 or Tier 2 source, or explicit statement that the mechanism is Inferred by analogy from NI/LTC reference material]
What would confirm this: [Specific data required to upgrade to Confirmed]

5.3 Example: Clear Timelines Opportunity Hypothesis

Expectation: Communicating Clear Timelines
Mechanism: When homeowners do not receive a clear timeline for rectification completion — particularly in cases involving uninhabitable dwellings — the absence of a predicted end date creates chronic anxiety. This anxiety drives frequent re-contact (consuming case manager capacity), accelerates escalation to complaints, and increases the likelihood of legal representation being engaged to "force" progress. Legal involvement directly increases claim management cost and may delay rectification by introducing contested scope reviews.
Lever: Escalation prevention; claim lifecycle compression
Evidence grade: Inferred — the mechanism is supported by the scheme's structural design (last-resort, high-distress context, complex rectification process) and is consistent with the broader service expectation evidence base in the project. No HBCF-specific study directly measuring the relationship between timeline clarity and legal engagement rate has been reviewed.
Source: Home Building Act 1989 (structural context); icare HBCF website (claim process); Communicating Clear Timelines Standard Reference Pack (analogy — mechanism applies across schemes)
What would confirm this: HBCF complaint and escalation data; legal representation rate before and after a timeline communication intervention; re-contact rate per claim correlated with timeline communication quality.


Part 6 — Output Standards
6.1 Core Principles

HBCF is its own scheme. Never apply NI mechanics (weekly benefits, step-down, PIAWE, RTW) to HBCF analysis without explicitly flagging the analogy and its limits. The schemes are structurally distinct.
Rectification cost, not duration, is the primary lever. All financial impact claims must trace to rectification scope, claim lifecycle, or escalation — not to weekly benefit leakage.
Evidence gaps are the dominant analytical risk. HBCF has less publicly available scheme performance data than the NI or Lifetime Care. The default posture must be Inferred, not Confirmed, for most mechanism and quantum claims.
Homeowner distress is structurally elevated. Unlike workers compensation where claimant emotional state is variable, HBCF homeowners are systematically in high-distress situations (uninhabitable or defective homes, financial exposure, often in mortgage stress). This amplifies the cost impact of poor service expectations compared with schemes where claimant stress is more variable.
Insolvency cycles create external volatility. HBCF cost and volume are partially exogenous — they depend on the construction industry cycle. Any opportunity hypothesis must distinguish between endogenous improvements (within icare's control) and exogenous drivers (builder insolvency rates).

6.2 Confidence Marking Convention
All HBCF outputs must apply The Playbook confidence grades:

Confirmed — directly supported by a Tier 1 or Tier 2 source cited by name
Inferred — logically derived from evidence but not directly stated; labelled [I]
Asserted — present without support; must be removed or reclassified before stakeholder presentation

6.3 Inference Flagging Format
Where a claim is Inferred:

[I] The mechanism is directionally supported by [source], which confirms [what the source says]. The specific quantum — [if applicable] — is not directly evidenced and represents a modelling assumption. To confirm, [specific data] would be needed.

6.4 Prohibited Framings
The following must not appear in HBCF outputs without explicit qualification:

Applying NI claim duration or weekly benefit mechanics directly to HBCF without analogy flag
Stating a dollar value for an HBCF improvement opportunity without a verified average rectification cost figure
Treating builder insolvency rate reductions as within icare's control (this is an exogenous variable)
Describing any of the 16 expectations as "soft" or purely experience-oriented in the HBCF context
Presenting the icare Annual Report's directional reference to claims growth as a precise volume figure


Part 7 — Reform and Regulatory Context
7.1 External Pressures (as at early 2026)

Elevated builder insolvencies — the construction cost pressures of 2022–2024 drove a materially higher rate of builder insolvencies in NSW, increasing HBCF claim lodgements and scheme cost exposure [Confirmed — directional, icare Annual Reports 2023–24 and 2024–25]
Premium adequacy scrutiny — as claims volumes and costs rise, the adequacy of HBCF premiums becomes a scheme sustainability question; icare must balance premium accessibility (to keep builders insured) with scheme solvency
Consumer advocacy pressure — homeowners with defective or incomplete work are a highly visible, politically sensitive cohort; complaint volumes and media coverage of HBCF claims handling can create reputational pressure disproportionate to the scheme's financial scale
Construction industry reform — broader reforms to builder licensing, building standards, and developer accountability in NSW (e.g. Design and Building Practitioners Act 2020) interact with HBCF eligibility and scope; these reforms may change the defect landscape over the medium term [Inferred — requires direct source review for specifics]

7.2 Reform Framing Principle
In the HBCF context, each service expectation gap functions as a scheme trust and sustainability risk. Poor homeowner experience in HBCF is disproportionately visible — distressed homeowners are likely to escalate publicly, approach media, or seek Ministerial intervention. This creates a reputational multiplier on service failures that does not exist in the same form in the NI.

Part 8 — Quick Reference for Common Tasks
Generating an opportunity hypothesis
→ Use the format in Part 5.2. Identify the expectation, trace the mechanism through homeowner behaviour to claim lifecycle or escalation cost, assign the lever, grade the evidence. State what data would confirm the mechanism.
Framing a service expectation for an executive audience in HBCF
→ Lead with the homeowner context (last-resort, high-distress, uninhabitable home). State the expectation as an escalation prevention or lifecycle control mechanism. Avoid weekly benefit or duration language. Use the rectification-first framing throughout.
Checking a claim's confidence grade
→ Ask: is this directly stated in Home Building Act 1989, icare HBCF website, or icare Annual Reports? If yes: Confirmed. If derived through reasoning from those sources or by analogy from NI/LTC material: Inferred — label it explicitly. If neither: Asserted — remove or reclassify.
Assessing whether a service improvement applies to HBCF
→ Check: does it reduce scope dispute, claim lifecycle, or homeowner escalation? Does it address the distress amplifier specific to HBCF? Is the mechanism traceable to rectification cost or legal engagement? If yes on one or more: it is a valid HBCF opportunity hypothesis, graded Inferred unless directly evidenced.
Identifying evidence gaps
→ Refer to Part 4.3. For any quantified opportunity hypothesis, identify which of the five gap areas (claim volume, rectification cost per claim, lifecycle duration, escalation rate, homeowner experience data) is required and flag it explicitly before the hypothesis is presented to stakeholders.

Appendix A — HBCF Service Expectations at a Glance
#ExpectationHBCF MechanismPrimary Lever1Clear HandoverPrevents context loss and scope re-assessment at case manager changeLifecycle compression2Empathy & UnderstandingReduces escalation in high-distress contextEscalation prevention3Knowledgeable Case ManagerReduces scope errors, variation orders, warranty period disputesRectification cost; lifecycle4Reliable Case ManagerPrevents anxiety-driven re-contact and escalationEscalation prevention5Professional Case ManagerReduces adversarial positioning in distress contextEscalation prevention6Proactive ServiceEarly expectation-setting at lodgement reduces premature escalationEscalation prevention7Timely ServicePrevents distress compounding during uninhabitable periodsEscalation prevention8Self-ServiceReduces administrative load on simple document/status tasksCost-to-serve (partial)9Channel PreferencesSupports homeowner engagement; lower direct cost impactEngagement10Clear & Accurate InformationReduces re-contact, scope dispute, and legal engagementLifecycle; escalation11Easy ProcessReduces submission errors and delays at claim lodgementLifecycle compression12Clear on Process and Next StepsPrevents passive delay and escalation at transition pointsLifecycle; escalation13Communicating Clear TimelinesReduces chronic anxiety during long rectification periodsEscalation prevention14Timely DecisionsReduces claim lifecycle length directlyLifecycle compression15Transparency of DecisionsReduces scope disputes and tribunal referralsEscalation; legal cost16Timely & Accurate Payments / ApprovalsPrevents contractor stall; reduces variation ordersRectification cost

Appendix B — Key Evidence Sources
SourceRole in HBCF AnalysisHome Building Act 1989 (NSW)Statutory warrant periods, eligible work, claim triggers, builder insurance obligationicare HBCF websiteScheme coverage, claim process, eligibility, rectification-first designicare Annual Reports 2023–24 and 2024–25HBCF claims growth due to insolvencies; enterprise financial contextSICG Act 2015icare mandate; HBCF governanceGovernment Sector Finance Act 2018Financial reporting obligationsDesign and Building Practitioners Act 2020 (NSW)Broader building reform context [Inferred relevance — direct review required]

A few notes on where this skill stands against The Playbook standard:
Confidence posture: This skill carries more Inferred material than the NI expert skill, which is correct. HBCF has a thinner publicly available evidence base. The skill flags this honestly throughout rather than masking it.
Evidence gaps (Part 4.3): These five gaps — claim volume, rectification cost per claim, lifecycle duration benchmarks, escalation rates, and homeowner experience data — are the single most important inputs for anyone building a business case or financial model for HBCF. Until these are sourced, all dollar-level opportunity hypotheses remain Inferred at best.
Scheme distinctiveness: The skill is deliberately built on rectification-cost logic throughout, not duration logic. The 16 expectations are remapped to HBCF-specific mechanisms rather than ported directly from the NI mapping.