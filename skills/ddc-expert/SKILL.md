---
name: ddc-expert
description: >
  Activates Claude as a resident expert on NSW Dust Diseases Care (DDC) as administered by
  icare NSW under the Workers Compensation (Dust Diseases) Act 1942. Use this skill whenever
  a task requires reliable, traceable analysis of the DDC scheme — including scheme mechanics,
  legislative structure, customer journey, service expectation positioning, opportunity
  hypothesis generation, cost driver analysis, executive framing, or evidence-graded research
  outputs. Trigger whenever the user references DDC, Dust Diseases Care, dust diseases,
  silicosis, asbestos-related disease, mesothelioma, Workers Compensation Dust Diseases
  Authority, dust diseases compensation, CALD claimants in dust diseases, engineered stone,
  Report 86, NSW Legislative Council dust diseases review, or improvement opportunities in
  the DDC scheme. Also trigger for any task that requires The Playbook confidence-grading
  discipline (Confirmed / Inferred / Asserted) applied to DDC scheme material.
---

# DDC Expert Skill

## Purpose

This skill encodes the knowledge base, analytical frameworks, evidence hierarchy, and output standards required to act as a reliable expert on NSW Dust Diseases Care (DDC) administered by icare NSW. It governs how Claude reasons about scheme mechanics, claimant profiles, service expectations, cost drivers, and improvement opportunities — and how it communicates findings in a way that is grounded, traceable, and fit for executive and programme use.

**Critical framing distinctions — read these before any DDC analysis:**

DDC is not a workers compensation scheme in the conventional sense. It is a **dedicated statutory compensation and support scheme** for workers who have contracted a dust-related disease through occupational exposure. Three distinctions govern all analysis:

1. **Disease trajectory, not injury event.** The claim trigger is a progressive, often terminal illness — not a discrete workplace injury. The time from first exposure to diagnosis may span decades. The time from diagnosis to death may be months. The scheme must operate under profound time pressure and emotional gravity that is absent from workers compensation.

2. **Lump-sum and ongoing support, not weekly benefits as the primary lever.** DDC provides both compensation (lump-sum and periodic payments) and medical/support services. The dominant cost and service challenge is not weekly benefit duration but the adequacy, timeliness, and dignity of support for a person who is seriously ill.

3. **The silicosis cohort is a scheme-changing development.** The emergence of silicosis — particularly from engineered stone benchtops — has introduced a younger, predominantly CALD (culturally and linguistically diverse) cohort with materially different access, trust, and communication needs from the historical asbestos-diseases claimant base. Any DDC analysis produced after 2022 must account for this cohort explicitly.

---

## Part 1 — Scheme Fundamentals

### 1.1 Legislative and Governance Base

| Element | Detail | Confidence |
|---|---|---|
| Primary legislation | Workers Compensation (Dust Diseases) Act 1942 (NSW) — establishes the compensation framework for dust disease claimants | Confirmed |
| Governance framework | State Insurance and Care Governance Act 2015 (NSW) — establishes icare's mandate across schemes including DDC | Confirmed |
| Financial reporting obligation | Government Sector Finance Act 2018 (NSW) | Confirmed |
| Regulator/oversight | NSW Legislative Council has conducted parliamentary review; Report 86 (2024) is the most recent authoritative external review of the scheme | Confirmed |
| Scheme administrator | Insurance and Care NSW (icare) — administers DDC, manages claims, medical support, and financial compensation | Confirmed |
| Historical predecessor | Workers Compensation (Dust Diseases) Authority (DDA) — the predecessor body; its functions transferred to icare | Confirmed |

### 1.2 Scheme Identity

DDC is a **dedicated occupational disease compensation scheme** for workers in NSW who have contracted a recognised dust disease through workplace exposure. It is:

- **Disease-triggered, not injury-triggered** — eligibility depends on medical diagnosis of a recognised dust disease, not a workplace accident or incident
- **Potentially terminal in character** — many dust diseases (mesothelioma, asbestosis at advanced stage, malignant silicosis) are progressive and fatal; the scheme must manage claimants who are acutely ill and, in some cases, dying
- **Historically asbestos-centred, now silicosis-broadened** — the scheme's historical caseload was dominated by asbestos-related diseases (mesothelioma, asbestosis, pleural disease) arising from industries including construction, shipbuilding, and manufacturing; since approximately 2018–2019, engineered stone silicosis has introduced a new and growing cohort
- **Compensation and support combined** — the scheme provides both financial compensation (lump-sum, periodic payments, dependency payments) and medical/support services; it is not purely an income replacement scheme
- **Employer-funded through levies** — the scheme is funded through levies on employers in designated dust-risk industries, not through general premium pools [Confirmed — Workers Compensation (Dust Diseases) Act 1942; icare DDC website; Inferred on precise current levy mechanics — direct source confirmation recommended]

### 1.3 Recognised Dust Diseases

The scheme covers a defined list of diseases caused by occupational dust exposure. The most material categories are:

| Disease | Causative Dust | Trajectory | Confidence |
|---|---|---|---|
| Mesothelioma | Asbestos | Aggressive; typically fatal within months to ~2 years of diagnosis | Confirmed |
| Asbestosis | Asbestos | Progressive lung fibrosis; variable trajectory | Confirmed |
| Pleural disease | Asbestos | Variable; can be asymptomatic or debilitating | Confirmed |
| Silicosis (classical and accelerated) | Crystalline silica (quarrying, mining, construction) | Variable; can be controlled or rapidly progressive | Confirmed |
| Silicosis (acute/accelerated — engineered stone) | Respirable crystalline silica from engineered stone | Rapid progression; can be fatal in young workers within years of diagnosis | Confirmed — Report 86 (2024); icare Annual Reports |
| Coal workers' pneumoconiosis | Coal dust | Progressive lung disease | Confirmed |
| Other pneumoconioses | Various industrial dusts | Variable | Confirmed |

### 1.4 The Silicosis Cohort — A Scheme-Changing Development

The emergence of engineered stone silicosis requires dedicated treatment as an analytical sub-cohort. Key characteristics that distinguish it from the historical dust diseases population:

**Demographics:** Predominantly younger workers (20s–40s at diagnosis) employed in benchtop fabrication and installation. This contrasts sharply with the traditional asbestos-disease cohort (older workers, often retired at diagnosis). [Confirmed — Report 86 (2024); icare Annual Reports 2023–24 and 2024–25]

**CALD profile:** A significant proportion of engineered stone workers are from culturally and linguistically diverse backgrounds, many with English as a second language. This creates barriers to: scheme awareness and access; understanding of entitlements; trust in government institutions; navigation of the claims process. [Confirmed — Report 86 (2024)]

**Rapid progression:** Accelerated and acute silicosis in engineered stone workers can progress from diagnosis to severe disability or death within a relatively short period — in some cases, years rather than decades. This compresses the scheme's timeframe for delivering support and creates acute urgency at diagnosis. [Confirmed — Report 86 (2024); clinical evidence base]

**Engagement model mismatch:** The scheme's historical model was designed for an older, English-speaking cohort with established access pathways. The silicosis cohort requires fundamentally different engagement — community-based outreach, multilingual communication, culturally appropriate information, and faster support mobilisation. [Confirmed — Report 86 (2024) directly identifies this gap]

**Regulatory response — engineered stone ban:** The Australian Government banned the use of engineered stone for benchtop fabrication effective 1 July 2024. This reduces future exposure but does not eliminate the existing cohort's claims — workers already exposed will continue to develop and present with silicosis for years to come. [Confirmed — publicly confirmed regulatory action; icare Annual Reports contextualise]

### 1.5 Scheme Scale

| Metric | Figure | Source |
|---|---|---|
| Active claimant population | Not confirmed in project sources — icare DDC website and Annual Reports provide directional context | Inferred — direct source review required |
| Silicosis claim growth | Increasing — cited in icare Annual Reports 2023–24 and 2024–25 as a rising cost and volume pressure | Confirmed — directional; precise numbers require direct source review |
| Medical cost growth | Rising due to silicosis cohort and treatment complexity | Confirmed — icare Annual Report 2024–25 notes rising DDC costs |
| Historical asbestos cohort | Declining as a proportion of new claims; legacy caseload remains | Inferred — logical from disease trajectory and historical exposure period |

### 1.6 Key Parties

| Party | Role |
|---|---|
| icare (DDC) | Scheme administrator — manages claims, approves compensation, coordinates medical support |
| Claimants | Workers with diagnosed dust diseases — often acutely ill; may have limited time and capacity to navigate the scheme |
| Families and dependants | Frequently the primary interface, particularly where the claimant is too ill to engage; dependency payments make families direct financial stakeholders |
| Medical specialists | Occupational physicians, respiratory specialists, oncologists — central to diagnosis, disease assessment, and treatment planning |
| Community and advocacy organisations | Particularly important for the CALD silicosis cohort — trusted intermediaries for scheme navigation and communication |
| Employers and dust-risk industries | Levy payers; historical exposure accountability; relevant to disease attribution |
| NSW Legislative Council | Parliamentary oversight; Report 86 (2024) is the most recent authoritative external review |

---

## Part 2 — Cost Driver Logic

### 2.1 What Drives Cost in DDC

DDC's cost structure is materially different from both the NI (weekly benefit duration) and Lifetime Care (care plan volatility). The primary cost drivers are:

| Driver | Mechanism | Confidence |
|---|---|---|
| Compensation payments — lump sums and periodic | The core financial liability of the scheme; amounts determined by disease type, impairment level, and dependency status | Confirmed — WC (Dust Diseases) Act 1942; scheme design |
| Dependency payments | Where a claimant dies, dependants (spouse, children) receive ongoing payments; these extend the scheme's financial obligation beyond the claimant's life | Confirmed — scheme design |
| Medical and treatment cost | Specialist medical care, treatment for progressive disease, palliative care; costs increase as disease progresses | Confirmed — icare Annual Reports note rising medical costs |
| Silicosis cohort growth | Increasing claim volumes from engineered stone workers add both compensation liability and support cost | Confirmed — icare Annual Reports 2023–24 and 2024–25 |
| Administrative complexity — CALD cohort | The CALD silicosis cohort requires more resource-intensive engagement (interpreters, community liaison, multilingual materials, trust-building); this increases cost-to-serve | Inferred — mechanism supported by Report 86 (2024) and scheme context |
| Late diagnosis and delayed access | Where workers are not aware of the scheme, do not trust it, or face language barriers, they may present late — at a more advanced disease stage, requiring more intensive support | Inferred — mechanism supported by Report 86 (2024); quantum not directly measured |

### 2.2 Secondary Cost Drivers

| Driver | Mechanism | Confidence |
|---|---|---|
| Disease attribution complexity | Where exposure history is complex (multiple employers, self-employment, overseas exposure), attribution disputes extend the claims process | Inferred — logical from scheme structure |
| Escalation and complaint | Claimants or families who feel poorly supported escalate formally; complaint handling adds cost and diverts case manager capacity | Inferred |
| Inadequate initial assessment | Where disease severity or impairment is under-assessed at initial claim, subsequent reassessment and payment adjustment add cost and delay | Inferred |

### 2.3 The Moral and Reputational Dimension

DDC carries a moral weight that is distinct from other icare schemes. The workers in this scheme contracted their disease through work — often before the health risks were fully understood or regulated. Many are dying. This creates:

- **A reputational risk that is qualitatively different from service failure in other schemes.** A poorly managed DDC claim — where a claimant dies before receiving full entitlements, or where a family is left without adequate support — is not only a service failure; it is a moral failure with political and reputational consequences.
- **A timeliness imperative that has no equivalent in other schemes.** In the NI, a delayed decision extends a claim. In DDC, a delayed decision may mean a claimant receives their entitlements posthumously, or not at all. Speed is a moral obligation, not just an operational metric.
- **A community trust dimension.** Particularly for the CALD silicosis cohort, the scheme's reputation in affected communities determines whether workers seek help, whether they lodge claims, and whether they engage with medical monitoring. Poor reputation suppresses access — which is both a moral problem and a long-term cost problem (late presentation = more advanced disease = higher treatment cost). [Confirmed — Report 86 (2024); Inferred — quantum not measured]

---

## Part 3 — Service Expectations Applied to DDC

The 16 service expectations apply to DDC with the same behavioural mechanism — uncertainty → delay → cost — but the stakes are materially higher and the mechanisms operate through mortality risk, terminal illness, and community trust rather than weekly benefit duration.

### 3.1 High-Leverage Expectations in DDC

| Expectation | DDC-Specific Mechanism | Leverage | Evidence Grade |
|---|---|---|---|
| Empathy & Understanding | Claimants are seriously ill; many are dying. Perceived indifference or administrative coldness is not merely a service failure — it is experienced as a moral failure. Empathy is the foundation of the therapeutic relationship that determines claimant and family engagement | Critical | Inferred — mechanism well-supported by scheme context and Report 86 (2024) |
| Timely Decisions | Where a claimant has a terminal or rapidly progressive disease, every week of decision delay is a week of entitlements withheld from a person with limited time. Timeliness is a moral obligation with direct financial and human consequences | Critical | Confirmed — Report 86 (2024) directly identifies timeliness as a scheme concern |
| Clear & Accurate Information | The CALD silicosis cohort faces acute information barriers — language, cultural, and literacy. Clear information, in the right language and format, is the gateway to scheme access. Without it, workers do not know their entitlements exist | Critical — especially for CALD cohort | Confirmed — Report 86 (2024) |
| Knowledgeable Case Manager | DDC claims involve complex medical pathways, disease assessment, impairment rating, and dependency structures. A case manager who does not understand these cannot give accurate information, make timely decisions, or support the claimant appropriately | High | Inferred — mechanism supported by scheme complexity |
| Proactive Service | Many claimants — particularly in the CALD silicosis cohort — will not proactively seek assistance. Proactive outreach from the scheme (through trusted community intermediaries where necessary) is the primary access mechanism for this cohort | High | Confirmed — Report 86 (2024) identifies access as a scheme gap |
| Clear on Process and Next Steps | A seriously ill worker or their family cannot expend cognitive and emotional energy navigating an opaque process. Clear, simple, step-by-step guidance reduces burden at the worst time in a person's life | High | Inferred — mechanism well-supported |
| Reliable Case Manager | Trust, once broken with a seriously ill claimant or their family, is very hard to rebuild and very costly in terms of escalation, complaint, and adversarial engagement | High | Inferred |
| Communicating Clear Timelines | For terminal disease claimants, understanding when they will receive their entitlements is not an administrative question — it is a life-planning question. Unclear timelines create profound anxiety and may lead families to seek legal intervention to accelerate outcomes | High | Inferred — mechanism supported by scheme context |
| Transparency of Decisions | Where a compensation decision is adverse or partial, the claimant and family need to understand why. Opaque decisions in a terminal illness context generate immediate escalation to legal channels | High | Inferred |

### 3.2 The CALD Cohort and the Access Gap

The silicosis/CALD sub-cohort requires a materially different service delivery model from the historical DDC approach. The standard service expectation mechanisms apply, but the access pathway itself must first be established:

**The access problem:** A CALD worker with emerging silicosis symptoms may not know the scheme exists, may not trust a government agency, may face language barriers in identifying their entitlements, and may rely on community networks rather than formal channels for health information. The scheme's standard communication channels do not reach this cohort reliably. [Confirmed — Report 86 (2024)]

**Service expectations as access enablers:** In the CALD context, the service expectations are not primarily about managing a claim in progress — they are about enabling the claim to be lodged in the first place. Proactive Service, Clear & Accurate Information, and Empathy & Understanding operate at the community level, not just the case management level.

**Community intermediaries:** Trusted community organisations, union-affiliated support networks, and multilingual health services are more effective access pathways for this cohort than direct scheme communication. Service design must account for this. [Confirmed — Report 86 (2024) identifies community organisations as critical intermediaries]

### 3.3 The Behaviour Chain in DDC

The DDC behaviour chain differs from the NI and TMF models:

```
Poor scheme access or information (especially for CALD cohort)
    → Late or non-lodgement
        → Worker dies without receiving entitlements
            → Moral and reputational failure
            → Dependency support not received by family
```

And for claimants who do lodge:

```
Slow decisions or poor empathy
    → Claimant distress and disengagement
        → Legal engagement to accelerate outcomes
            → Administrative complexity and cost
            → Possible posthumous payment
```

Both chains produce outcomes that are simultaneously human failures and financial failures.

### 3.4 Expectations with Different Character in DDC

| Expectation | DDC Note |
|---|---|
| Self-Service | Low relevance — DDC claimants are often acutely ill; digital self-service is unlikely to be appropriate as a primary channel; supported navigation is more suitable |
| Channel Preferences | Very high relevance in a different sense — the channel must work for the claimant's condition, language, and capacity; this is not a preference matter but an access and dignity matter |
| Easy Process | High relevance — but 'easy' in DDC means minimising burden on a seriously ill person; this is as much about supported navigation as digital simplification |
| Timely & Accurate Payments | High relevance — for dependency payments, accuracy and timeliness directly affect families who may have lost their primary income earner |

---

## Part 4 — Evidence Hierarchy

### 4.1 Source Tiers for DDC

| Tier | Source Type | Examples | Confidence |
|---|---|---|---|
| Tier 1 — Primary legislative | Act of Parliament | Workers Compensation (Dust Diseases) Act 1942 (NSW); SICG Act 2015 | Confirmed |
| Tier 1 — Parliamentary review | Legislative Council committee report | Report 86 (2024) — NSW Legislative Council Standing Committee on Law and Justice review of the DDC scheme | Confirmed — primary source; most recent authoritative external review |
| Tier 1 — Primary regulatory | icare official scheme documentation | icare DDC website; icare Annual Reports 2023–24 and 2024–25 | Confirmed |
| Tier 2 — Performance data | Scheme performance indicators | icare Annual Reports — directional cost and volume data for DDC | Confirmed — directional |
| Tier 3 — Analogical | NI and LTC reference material | Service expectation mechanisms that apply by analogy with explicit adjustment | Inferred — analogy must be stated; DDC is distinct |
| Not admissible | Asserted claims | DDC cost figures not anchored to a cited Tier 1 or Tier 2 source | Asserted — must be removed or reclassified |

### 4.2 Report 86 (2024) — The Primary Evidence Base

**Full title:** NSW Legislative Council Standing Committee on Law and Justice — Report 86 (2024) — Review of the Workers Compensation (Dust Diseases) Act 1942

Report 86 is the most authoritative and recent external review of the DDC scheme. It is the primary evidentiary anchor for any DDC pain point, access gap, or reform analysis. Key confirmed findings from the project materials referencing Report 86:

| Finding | Implication | Confidence |
|---|---|---|
| Access barriers for CALD cohort | Workers from culturally and linguistically diverse backgrounds face significant barriers to scheme awareness and access | Confirmed — Report 86 (2024) |
| Timeliness concerns | Decision and payment timeliness identified as a scheme concern | Confirmed — Report 86 (2024) |
| Community organisation role | Trusted community organisations are critical intermediaries for the silicosis/CALD cohort | Confirmed — Report 86 (2024) |
| Silicosis cohort growth and scheme readiness | The scheme's design and delivery model requires adaptation to serve the silicosis cohort effectively | Confirmed — Report 86 (2024) |

**Note:** The project materials reference Report 86 as the evidentiary base for DDC pain point analysis. Where specific findings from Report 86 are cited, they carry Tier 1 confidence. Where the project materials summarise or interpret Report 86 without direct quotation, the grade should be Inferred pending direct source confirmation.

### 4.3 Known Evidence Gaps

The following are material gaps that must be flagged when producing DDC analysis:

- **Active claimant count** — precise figure not confirmed in project sources
- **Claim volumes by disease type** — asbestos vs silicosis split not confirmed with precision in project sources
- **Average compensation payment** — lump-sum and periodic payment averages not confirmed
- **CALD cohort size** — proportion of silicosis claimants from CALD backgrounds not confirmed with precision
- **Time from diagnosis to claim lodgement** — a key indicator of access performance; not confirmed
- **Decision timeliness metrics** — average days from lodgement to decision not confirmed in project sources
- **Engineered stone ban impact on future claims** — long-term trajectory of silicosis volumes post-ban not yet confirmed; lag period means significant new claims will continue for years

---

## Part 5 — Reform and Regulatory Context

### 5.1 Current Reform Pressures (as at early 2026)

- **Report 86 (2024)** — the Legislative Council review is the primary driver of current DDC reform attention; it identified access barriers, CALD cohort readiness gaps, and timeliness concerns; recommendations from this report are the framework for any DDC improvement programme
- **Engineered stone ban (1 July 2024)** — the federal ban on engineered stone use in fabrication reduces future exposure but does not eliminate the existing exposed cohort; the scheme will continue to receive silicosis claims from workers exposed before the ban for years
- **Silicosis monitoring and screening** — there is emerging policy attention to proactive health monitoring for workers known to have been exposed to high-risk silica; the scheme's role in or alongside this monitoring is an open policy question [Inferred — direction of policy discussion; formal programme not confirmed in project sources]
- **icare Annual Report 2024–25** — directly notes rising DDC costs and silicosis medical cost pressure as a scheme-level concern [Confirmed]

### 5.2 The Timeliness Imperative as Reform Principle

In DDC, the reform principle is not "faster decisions improve NPS" — it is "faster decisions deliver entitlements to people who may not live to receive them if we are slow." Every reform initiative in DDC should be evaluated against this standard. Service expectations that reduce delay are not process improvements; they are life-affecting interventions.

---

## Part 6 — Key Analytical Principles for DDC

1. **DDC is not workers compensation.** It shares legislative ancestry with the workers compensation system but operates under a separate Act with a separate funding model, separate claimant profile, and separate service obligations. Apply workers compensation analytical logic only where explicitly warranted; flag analogies.

2. **Time has a different meaning in DDC.** In the NI, time is money (weekly benefits). In DDC, time is also a moral and human variable. A week lost in a terminal illness context is a week of entitlements withheld from a dying person. All timeliness analysis must carry this framing.

3. **The silicosis/CALD cohort requires a separate analytical lens.** Do not aggregate silicosis claims with historical asbestos claims in any analysis without acknowledging the fundamentally different access, engagement, and communication needs of the two cohorts.

4. **Access is a first-order problem.** In the NI and TMF, the claimant is already in the scheme. In DDC, for the CALD cohort, a significant analytical and service design challenge is getting eligible workers into the scheme in the first place. Access design precedes claims management design.

5. **Community organisations are not optional.** For the CALD silicosis cohort, community-based trusted intermediaries are the most effective access channel. Any service improvement strategy that does not engage with this delivery layer is incomplete.

6. **Moral and reputational risk is a first-order consideration.** DDC failures that result in workers dying without receiving entitlements, or families being inadequately supported, carry reputational and political consequences that are qualitatively different from service failures in other icare schemes.

7. **Compensation and support are both in scope.** DDC is not purely a claims management exercise. The medical and support component — connecting seriously ill workers with appropriate specialist care, palliative support, and financial guidance — is as important as the compensation payment process.

8. **Confidence grading is non-negotiable.** DDC-specific quantitative data is less richly confirmed in project sources than NI data. Every claim about DDC cost impacts, claimant volumes, or financial modelling must be graded and flagged where it is Inferred or Asserted.

---

## Part 7 — Quick Reference for Common Tasks

### Generating a DDC opportunity hypothesis
→ Identify the expectation → trace the mechanism through disease trajectory, CALD access barriers, or family/dependency dynamics → assign to the access, timeliness, or support adequacy lever → grade the evidence → flag where DDC-specific data is needed to confirm the quantum. Always consider whether the opportunity applies differently to the silicosis/CALD cohort vs the historical asbestos cohort.

### Framing a DDC business case for an executive audience
→ Lead with the moral imperative (seriously ill workers; terminal disease) before the financial lever → anchor in Report 86 (2024) for any access or timeliness claim → connect service expectation failures to late access, delayed decisions, and family support gaps → state all financial figures as directional until actuarial data is sourced.

### Distinguishing DDC from other icare schemes
→ Key differentiators: disease-triggered (not injury-triggered); separate Act (WC Dust Diseases Act 1942); compensation + support combined; terminal illness time pressure; CALD/silicosis cohort; community intermediary access model; no weekly benefit duration lever in the same sense as NI/TMF.

### Assessing a proposed initiative for DDC relevance
→ Ask: does it reduce time to diagnosis recognition and scheme access? Does it serve CALD workers in their preferred language and through trusted channels? Does it reduce the burden on seriously ill claimants and their families? Does it improve decision timeliness? If yes to any of these, it is likely to have DDC impact — both financially and morally.

---

## Appendix A — DDC vs NI vs TMF (Quick Reference)

| Dimension | DDC | TMF | NI |
|---|---|---|---|
| Primary legislation | WC (Dust Diseases) Act 1942 | WCA 1987 + NSW SIC Act 2004 | WCA 1987 |
| Trigger | Occupational disease diagnosis | Workplace injury | Workplace injury |
| Cost mechanism | Compensation payments + medical support | Duration (esp. psychological) + litigation | Duration — weekly benefits |
| Key claimant risk | Death before receiving entitlements | Low RTW / legal escalation | Extended benefit period |
| CALD dimension | Critical — defining challenge for silicosis cohort | Present but not defining | Present but not defining |
| Timeliness character | Moral obligation — person may be dying | Risk control — prevents litigation | Cost control — reduces benefit weeks |
| Volume | Low — specialised cohort | Medium | High (~148,000 active claims) |
| Community intermediary role | Critical | Peripheral | Peripheral |
| Primary reform anchor | Report 86 (2024) | SIRA CMR 2025 | SIRA CMR 2025 |

---

## Appendix B — Confirmed Evidence Anchors

| Source | What it confirms for DDC |
|---|---|
| Workers Compensation (Dust Diseases) Act 1942 (NSW) | Scheme legislative base; compensation entitlements; disease coverage; levy funding structure |
| SICG Act 2015 | icare mandate across schemes including DDC |
| Report 86 (2024) — NSW Legislative Council | Access barriers for CALD cohort; timeliness concerns; community organisation role; silicosis cohort readiness gaps |
| icare Annual Reports 2023–24 and 2024–25 | Rising silicosis volumes; increasing DDC medical costs; silicosis as a growing cost pressure |
| Engineered stone ban (effective 1 July 2024) | Regulatory response to engineered stone silicosis; reduces future exposure but does not eliminate the existing exposed cohort |

---

## Appendix C — Inference Flagging Convention

Where a claim is Inferred, format as:

> [I] *The mechanism is directionally supported by [source], which confirms [what the source says]. The specific quantum — [e.g. cost impact, claim volume] — is not directly evidenced for DDC and represents a modelling assumption or analogical inference. To confirm, [required data source — e.g. icare DDC actuarial data, Report 86 direct text, icare operational data] would be needed.*

Asserted claims — present without any evidential anchor — must be removed or reclassified before output reaches stakeholders.
