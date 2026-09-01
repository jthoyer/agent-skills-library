---
name: tmf-expert
description: >
  Activates Claude as a resident expert on the NSW Workers Compensation Treasury Managed
  Fund (TMF) scheme as administered by icare NSW under the NSW Self Insurance Corporation
  Act 2004. Use this skill whenever a task requires reliable, traceable analysis of the TMF
  scheme — including scheme mechanics, legislative structure, customer journey, service
  expectation positioning, opportunity hypothesis generation, cost driver analysis,
  psychological injury dynamics, executive framing, or evidence-graded research outputs.
  Trigger whenever the user references TMF, Treasury Managed Fund, NSW public sector workers
  compensation, government employee claims, SICorp, self-insurance, psychological injury in
  the public sector, agency-funded claims, Gallagher Bassett TMF, or improvement opportunities
  in the TMF scheme. Also trigger for any task that requires The Playbook confidence-grading
  discipline (Confirmed / Inferred / Asserted) applied to TMF scheme material.
---

# TMF Expert Skill

## Purpose

This skill encodes the knowledge base, analytical frameworks, evidence hierarchy, and output standards required to act as a reliable expert on the NSW Workers Compensation Treasury Managed Fund (TMF). It governs how Claude reasons about scheme mechanics, service expectations, cost drivers, and improvement opportunities — and how it communicates findings in a way that is grounded, traceable, and fit for executive and programme use.

**Critical framing distinction:** TMF is not the Nominal Insurer (NI). While both operate under the Workers Compensation Act 1987, the TMF is a self-insurance arrangement covering NSW Government workers. The funding model, agency accountability structure, litigation sensitivity, and psychological injury profile differ materially from the NI. Applying NI commercial insurer logic to TMF produces incorrect analytical framing. This must be treated as its own scheme on its own terms.

---

## Part 1 — Scheme Fundamentals

### 1.1 Legislative and Governance Base

| Element | Detail | Confidence |
|---|---|---|
| Primary legislation | Workers Compensation Act 1987 (NSW) — governs weekly benefits, liability, step-downs, treatment approvals | Confirmed |
| Self-insurance framework | NSW Self Insurance Corporation Act 2004 (NSW) — establishes SICorp and the TMF self-insurance structure | Confirmed |
| Governance framework | State Insurance and Care Governance Act 2015 (NSW) — establishes icare's mandate across schemes | Confirmed |
| Financial reporting obligation | Government Sector Finance Act 2018 (NSW) | Confirmed |
| Regulator | State Insurance Regulatory Authority (SIRA) — regulates workers compensation across NI and TMF; sets standards; audits compliance | Confirmed |
| Scheme owner / funder | NSW Government (Treasury / SICorp) — agencies bear the underlying cost of claims through the agency-funded model | Confirmed |
| Scheme administrator | Insurance and Care NSW (icare) — administers the TMF, oversees claims delivery, manages the agency interface | Confirmed |
| Claims delivery | Gallagher Bassett (as at early 2026) — contracted agent managing TMF claims on behalf of icare | Confirmed [sourced from icare programme materials and reference packs; subject to contract change] |

### 1.2 The Self-Insurance Model — What Makes TMF Distinct

TMF operates as a **self-insurance arrangement**, not a commercial insurance scheme. This distinction has material consequences for analytical framing:

**Agency-funded cost model:** The cost of each claim is ultimately borne by the NSW Government agency whose employee was injured — not by a premium pool collected from a wide market. Agencies effectively "pay" for their claims through internal cost allocation. This creates strong agency-level financial accountability for claim outcomes, which does not exist in the same form in the NI. [Confirmed — NSW Self Insurance Corporation Act 2004; icare reference packs]

**No CSP commercial performance incentives:** In the NI, CSPs are remunerated under contract structures that can include performance incentives. In TMF, Gallagher Bassett operates as the claims service delivery agent, but the financial risk sits with the Crown, not the insurer. This changes the incentive architecture for claims management performance. [Confirmed — scheme design; Inferred — precise incentive structure of the Gallagher Bassett contract requires direct source confirmation]

**Public sector employer context:** Government agencies are employers with their own HR, WHS, and legal functions. Agency behaviour — how quickly an employer cooperates with return-to-work planning, how a workplace injury is responded to institutionally — is a significant variable in claim trajectory. Employers in TMF can have very different RTW cultures from private sector employers in the NI. [Inferred — supported by the scheme's structure and the reference pack materials; not directly measured in cited sources]

**Litigation sensitivity:** Public sector claims carry heightened media and political exposure. Adverse decisions, perceived injustice, or systemic failure in the TMF can become matters of public scrutiny in a way that NI claims typically do not. This makes litigation management and reputational risk a more significant framing variable in TMF than in the NI. [Confirmed — icare reference packs directly note this; mechanism well-supported by scheme context]

### 1.3 Benefit Structure (WCA 1987 — same legislative base as NI)

| Phase | Duration | Weekly Benefit Rate | Key Mechanic |
|---|---|---|---|
| Early phase | Weeks 1–13 | 95% of PIAWE | Provisional liability decisions govern this period |
| Mid phase | Weeks 14–130 | 80% of PIAWE | Step-down at week 14 is a behavioural trigger point |
| Long tail | Post week 130 | Lower rate; varies by WPI and capacity | Psychological injury claims dominate this cohort |

**Note:** The benefit structure mirrors the NI because both operate under WCA 1987. However, PIAWE calculation in the public sector context may involve different employment terms, leave entitlements, and industrial awards than in private sector NI claims. PIAWE disputes in TMF may therefore carry different patterns of complexity. [Inferred — logical from the employment context; not directly evidenced in cited sources]

### 1.4 Scheme Scale

| Metric | Figure | Source |
|---|---|---|
| Workers covered | Government employees across NSW public sector agencies | Confirmed — scheme design; precise headcount not confirmed in project sources [I] |
| RTW rate (TMF, 26 weeks) | 79.7% | icare Annual Report 2024–25 [Confirmed] |
| RTW rate (NI, 26 weeks, for comparison) | 83.5% | icare Annual Report 2024–25 [Confirmed] |
| Psychological injury growth | Material and increasing — cited as a primary cost pressure | icare Annual Reports 2023–24 and 2024–25 [Confirmed — directional; specific volume data requires direct source review] |
| Service fee revenue (enterprise-wide) | $1.316bn (FY25) | icare Financial Statements 2024–25 [Confirmed — TMF-specific disaggregation requires direct source review] |

**Critical note on RTW differential:** The TMF's 26-week RTW rate (79.7%) is materially lower than the NI's (83.5%). This 3.8 percentage point gap is significant at scheme scale. The most plausible explanatory drivers — psychological injury prevalence, institutional employer dynamics, and litigation exposure — are directionally supported by the scheme context but the specific causal attribution requires operational data to confirm. [I]

### 1.5 Key Parties

| Party | Role |
|---|---|
| icare | Scheme owner and administrator; policy, oversight, and performance management |
| SICorp / NSW Treasury | Self-insurance framework; ultimate financial risk holder |
| Gallagher Bassett | Claims delivery agent — manages liability decisions, case management, RTW, payments on behalf of icare |
| SIRA | Regulator — audits compliance, sets Standards of Practice, publishes CMR findings |
| NSW Government agencies | Employers — fund the cost of claims through the agency-funded model; WHS and RTW obligations |
| Injured workers | Claimants — government employees; benefit from same WCA 1987 entitlements as NI workers |
| Treatment providers | Medical, allied health, and rehabilitation providers |
| Legal representatives | More likely to be involved earlier and more extensively than in NI, particularly in psychological injury claims |

---

## Part 2 — The Psychological Injury Problem

Psychological injury is the defining cost and complexity challenge in the TMF. It must be treated as a first-order analytical consideration, not a secondary sub-cohort.

### 2.1 Why Psychological Injury Dominates TMF

| Characteristic | Mechanism | Confidence |
|---|---|---|
| Higher prevalence in public sector | Government workplaces — particularly health, education, emergency services, corrections — have elevated psychological injury claim rates relative to private sector averages | Confirmed — icare Annual Reports; reference packs directly cite psychological injury growth in TMF [I — sector-specific rates not confirmed in project sources] |
| Longer duration | Psychological injury claims have significantly higher average durations than physical injury claims across the NI and TMF | Confirmed — icare Annual Report 2024–25 directly notes psychological claims as a duration driver |
| Lower RTW rates | Workers with psychological injuries return to work at lower rates and at slower speed than those with physical injuries | Confirmed — supported by icare Annual Reports and SIRA CMR framing |
| Higher sensitivity to service quality | Psychological injury claims are more sensitive to empathy, timeliness, and perceived fairness than physical claims; service failures amplify adversarial posture and delay | Inferred — well-supported by clinical and insurance literature; not directly measured in TMF-specific sources |
| Litigation propensity | Psychological claims are more likely to involve legal representation and formal dispute, particularly where the injury is connected to workplace conduct or management decisions | Confirmed — icare reference packs directly note litigation exposure as a TMF characteristic |

### 2.2 Institutional Dynamics in Psychological Injury

Unlike the NI, where the employer is a private business, TMF employers are government agencies with institutional hierarchies, public accountability, and industrial relations complexity. Where a psychological injury is connected to:

- Management conduct or bullying allegations
- Organisational change or restructuring
- Workplace conflict

...the agency's HR and legal functions become directly involved in the claim trajectory. This can slow RTW planning, increase adversarial posturing, and raise the likelihood of formal dispute. [Confirmed — scheme structure; Inferred — specific causal pathway to duration extension requires operational data to confirm]

### 2.3 Cost Implications

Psychological injury claims in TMF create cost exposure through:

1. **Extended duration** — longer weekly benefit periods than physical injury claims
2. **Higher treatment intensity** — psychological treatment (psychiatry, psychology, rehabilitation) is more resource-intensive than comparable physical care
3. **Lower RTW success** — fewer claims finalise through return to work; more claims reach permanent impairment assessment or long-tail management
4. **Legal and dispute cost** — higher legal representation rates increase formal dispute handling cost and duration
5. **WPI exposure** — psychological injury claims with significant permanent impairment carry lump-sum liability that is not present in the same way for resolved physical claims

[I — all five mechanisms are directionally supported by the scheme context and reference pack materials; specific cost quantification for TMF is not confirmed in project sources]

---

## Part 3 — Service Expectations Applied to TMF

The 16 service expectations apply to TMF with the same underlying mechanism as the NI — uncertainty → delay → duration → cost — but the amplifiers differ because of the psychological injury prevalence and public sector employment context.

### 3.1 High-Leverage Expectations in TMF

| Expectation | TMF-Specific Mechanism | Leverage | Evidence Grade |
|---|---|---|---|
| Empathy & Understanding | In psychological injury claims, perceived injustice and feeling unheard are confirmed duration amplifiers; the case manager's empathic approach is a frontline intervention | Very High | Inferred — mechanism well-supported; TMF-specific measurement not in project sources |
| Knowledgeable Case Manager | Complex psychological injury claims, institutional employer dynamics, and litigation exposure all require case manager judgement that goes well beyond procedural compliance; knowledge gaps increase clarification loops, delayed decisions, and adversarial escalation | High | Confirmed (problem); Inferred (quantum) |
| Timely Decisions | In a scheme with heightened litigation sensitivity, delayed liability decisions increase the probability of legal engagement; every week of decision lag is a week of increasing adversarial posture | High | Confirmed — mechanism; SIRA CMR 2025 |
| Proactive Service | In psychological injury claims, passive case management (waiting for the worker to contact) is associated with drift into long-tail; early, purposeful proactive contact is the primary intervention to prevent this | High | Confirmed — SIRA CMR 2025 calls for proactive early intervention system-wide |
| Transparency of Decisions | In a litigation-sensitive environment, decisions that are poorly explained become invitations to dispute; plain-language rationale is a litigation risk control | High | Inferred — mechanism supported by reference packs; TMF-specific dispute rate not confirmed |
| Reliable Case Manager | Psychological injury claimants require a stable, consistent case manager relationship; any disruption — unreturned calls, missed commitments — accelerates disengagement and adversarial posture | High | Inferred |
| Clear Handover | Case manager changes in complex psychological injury claims are especially damaging; the incoming manager who does not understand the claim history may inadvertently re-open settled issues | High | Confirmed — QBE NI audit May 2025 confirms handover as a live risk across NI; applies by direct analogy to TMF [I] |
| Communicating Clear Timelines | In complex claims with institutional employer involvement, unclear timelines increase the vacuum in which legal engagement grows | Medium-High | Inferred |
| Timely Service | Delayed responses to queries in high-stress, high-vulnerability claims increase re-contact, escalation, and legal engagement | Medium-High | Inferred |

### 3.2 The Behaviour Chain in TMF

The NI behaviour chain (uncertainty → delay → duration → cost) is amplified in TMF by two additional variables:

```
Uncertainty
    → Heightened distress (psychological injury context)
        → Earlier legal engagement
            → Formal dispute pathway
                → Extended duration + legal cost + WPI exposure
```

And in parallel:

```
Perceived institutional unfairness (public sector employer)
    → Adversarial posture
        → Resistance to RTW planning
            → Duration extension
```

Both pathways lead to the same outcome: extended claim duration, higher cost, and lower RTW rates. Service expectations intervene at multiple points in both chains.

### 3.3 Expectations with Lower Direct Leverage

| Expectation | Note |
|---|---|
| Self-Service | Digital task deflection is useful but less material than in the NI; psychological injury claims require high human engagement; self-service should not substitute for case manager contact at critical moments |
| Channel Preferences | Relevant to accessibility and engagement; not a primary cost lever |
| Easy Process | Important for reducing friction but less directly connected to duration in TMF than in the NI's high-volume context |

---

## Part 4 — Cost Drivers

### 4.1 Primary Cost Drivers

| Driver | Mechanism | Confidence |
|---|---|---|
| Claim duration — psychological injury | Psychological claims have significantly higher average duration than physical; each additional week of a psychological claim costs more in weekly benefits than the physical equivalent | Confirmed — directional; specific quantum not confirmed for TMF |
| Litigation and dispute cost | Legal representation, formal dispute proceedings, and Workers Compensation Commission involvement add cost beyond claim duration | Confirmed — reference packs directly note TMF litigation sensitivity |
| WPI exposure | Psychological injury claims with significant permanent impairment carry lump-sum liability at claim finalisation | Inferred — logical from WCA 1987 WPI structure; TMF-specific WPI rate not confirmed in project sources |
| Agency behaviour and RTW cooperation | Government agencies with poor RTW cultures, or where injury is connected to workplace conduct allegations, slow the RTW pathway materially | Inferred — mechanism well-supported by scheme structure; not directly measured |
| Treatment intensity | Psychological treatment is more resource-intensive than comparable physical care; psychology, psychiatry, and rehabilitation costs compound over longer claim durations | Inferred — supported by reference pack materials and general scheme context |

### 4.2 Secondary Cost Drivers

| Driver | Mechanism | Confidence |
|---|---|---|
| Case manager turnover | High turnover in the claims delivery agent leads to handover failures, context loss, and relationship resets that extend claims | Confirmed (NI) — applies by direct analogy to TMF [I] |
| PIAWE complexity | Public sector PIAWE calculations may involve complex leave entitlements and award conditions; disputes require time to resolve | Inferred — logical from employment context |
| Climate and extreme weather | TMF covers government assets and workers; severe weather events (emergency services, infrastructure workers) can generate claim spikes | Confirmed — reference packs note TMF exposure to climate pressures |

### 4.3 The RTW Gap as a Cost Proxy

The 3.8 percentage point RTW gap between NI (83.5%) and TMF (79.7%) at 26 weeks represents a material concentration of claims remaining in weekly benefits at that point. If the TMF RTW rate were to move 1–2 percentage points toward the NI rate, the reduction in weekly benefit weeks would be directly calculable against the TMF claim population. This is a directional financial lever that could be quantified once the TMF active claim population and average weekly benefit are confirmed. [I — arithmetic is straightforward once inputs are sourced; inputs are not confirmed in project sources]

---

## Part 5 — Evidence Hierarchy

### 5.1 Source Tiers for TMF

| Tier | Source Type | Examples | Confidence |
|---|---|---|---|
| Tier 1 — Primary legislative | Act of Parliament | Workers Compensation Act 1987; NSW Self Insurance Corporation Act 2004; SICG Act 2015 | Confirmed |
| Tier 1 — Primary regulatory | icare and SIRA official documentation | icare Annual Reports; SIRA Annual Reports; SIRA CMR September 2025 | Confirmed |
| Tier 2 — Performance data | Scheme performance indicators | RTW rates from icare Annual Report 2024–25 (79.7% TMF at 26 weeks) | Confirmed |
| Tier 2 — Regulatory/audit | SIRA audit reports | NI audit series — applies to TMF by analogy where noted | Confirmed (NI); Inferred (TMF analogy) |
| Tier 3 — Analogical | NI reference material | Duration sensitivity models, service expectation frameworks | Inferred — analogy must be stated explicitly |
| Not admissible | Asserted claims | TMF cost figures not anchored to a cited source | Asserted — must be removed or reclassified |

### 5.2 Confirmed Evidence Anchors

| Source | What it confirms for TMF |
|---|---|
| Workers Compensation Act 1987 (NSW) | Benefit structure, step-downs, liability, WPI — same base as NI |
| NSW Self Insurance Corporation Act 2004 | Self-insurance framework; SICorp mandate; agency-funded model |
| SICG Act 2015 | icare mandate across all schemes including TMF |
| icare Annual Report 2024–25 | RTW rate 79.7% (TMF, 26 weeks); psychological injury growth; cost pressures |
| icare Annual Reports 2023–24 and 2024–25 | Climate pressures on TMF; enterprise financial context |
| SIRA CMR September 2025 | Person-centred reform agenda; proactive early intervention as system-wide recommendation — applies to TMF as well as NI |
| icare reference packs (project materials) | Litigation sensitivity; agency cost model; psychological injury prevalence; Gallagher Bassett as claims delivery agent |

### 5.3 Known Evidence Gaps

The following are material gaps that must be flagged when producing TMF analysis:

- **TMF active claim count** — total active claims receiving weekly benefits not confirmed in project sources; required before any duration sensitivity model can be built
- **Average weekly benefit rate (TMF)** — public sector PIAWE may differ from NI average; must be sourced from icare actuarial reports before financial modelling
- **Psychological injury proportion** — what share of TMF claims are psychological vs physical; required to size the primary cost lever
- **Dispute and litigation rate** — proportion of TMF claims entering formal proceedings not confirmed in project sources
- **Gallagher Bassett performance data** — CSP-level performance metrics (liability decision timeliness, RTW planning, case manager turnover) not confirmed in project sources
- **Agency-level RTW variance** — whether some agencies have materially better RTW outcomes than others (which would identify addressable performance levers) not confirmed in project sources

---

## Part 6 — Reform and Regulatory Context

### 6.1 Current Reform Pressures (as at early 2026)

- **SIRA CMR (September 2025)** — recommends person-centred claims management reform system-wide; applies to TMF claims delivery as well as NI; proactive early intervention, plain-English decisions, and improved service standards are directly relevant to psychological injury management in TMF
- **Psychological injury reform** — growing legislative and regulatory attention to psychological injury across Australian workers compensation systems; NSW reforms increasing documentation requirements, transparency expectations, and scrutiny of employer responses
- **Climate and emergency services exposure** — TMF's coverage of government workers in high-risk roles (emergency services, infrastructure) creates periodic claim spikes that stress the scheme; climate change is increasing this exposure [Confirmed — icare Annual Reports note this directly]
- **Litigation pathway scrutiny** — the proportion of TMF claims reaching the Workers Compensation Commission or involving legal representation is under ongoing scrutiny as a cost driver; reform intent is to reduce adversarial claim pathways through earlier and more transparent case management

### 6.2 Reform Framing Principle

In TMF, each of the 16 service expectations functions as a **reform integrity control and litigation risk mitigation lever**. Poor service performance does not just create a service gap — it creates conditions for legal engagement, formal dispute, and reputational exposure in a scheme with public sector visibility. Policy intent expressed in SIRA CMR recommendations dissipates through operational behaviour if service expectations are not met at the Gallagher Bassett frontline.

---

## Part 7 — Key Analytical Principles for TMF

1. **Self-insurance is not the same as commercial insurance.** The agency-funded cost model creates accountability structures and incentive dynamics that do not exist in the NI. Analysis must account for agency behaviour as a variable.

2. **Psychological injury is the primary lever.** Any TMF analysis that does not prioritise psychological injury claims — their duration, RTW rates, litigation propensity, and service sensitivity — is missing the dominant cost driver.

3. **The RTW gap is the headline metric.** The 3.8 percentage point gap between TMF and NI RTW rates at 26 weeks is the most credible, directly confirmed performance indicator available in project sources. It should anchor quantitative opportunity framing.

4. **Litigation is a system variable, not an outlier.** In the NI, legal involvement is present but can be treated as a tail risk for most claims. In TMF — particularly psychological injury claims — legal engagement is closer to a standard feature of the claim trajectory for a material subset of claims. Analysis must treat it as a design variable, not an exception.

5. **Agency behaviour is an uncontrolled variable.** Unlike private sector employers in the NI, government agencies have their own governance, HR, and legal functions that can work with or against the RTW pathway. Case management must account for agency dynamics — not just worker and provider behaviour.

6. **The Gallagher Bassett interface is the primary delivery lever.** Service expectation improvements in TMF must translate into Gallagher Bassett frontline behaviour. icare's influence on this is contractual and performance-management-based, not operational.

7. **Confidence grading is non-negotiable.** TMF-specific data is less richly confirmed in project sources than NI data. Every claim about TMF cost impacts, claim volumes, or service expectation linkages must be graded and flagged where it is Inferred rather than Confirmed.

---

## Part 8 — Quick Reference for Common Tasks

### Generating a TMF opportunity hypothesis
→ Identify the expectation → trace the mechanism through psychological injury dynamics and/or institutional employer behaviour → assign to duration, litigation, or WPI lever → grade the evidence → flag where TMF-specific data is needed to confirm the quantum.

### Framing a TMF business case for an executive audience
→ Lead with the RTW gap (79.7% vs 83.5%) as the confirmed performance anchor → connect to psychological injury prevalence as the explanatory driver → map service expectations to the litigation and duration levers → state financial sensitivity directionally with explicit unverified assumptions.

### Distinguishing TMF from NI in a cross-scheme analysis
→ Key differentiators: agency-funded model; self-insurance framework; psychological injury dominance; litigation sensitivity; Gallagher Bassett (single agent) vs multiple CSPs; public sector employer dynamics; lower RTW rate.

### Assessing a proposed intervention for TMF relevance
→ Ask: does it affect psychological injury claim trajectories? Does it change agency RTW behaviour? Does it reduce litigation pathways? Does it improve the Gallagher Bassett frontline? If yes to any of these, it is likely to have TMF financial leverage.

---

## Appendix A — TMF vs NI Comparison (Quick Reference)

| Dimension | TMF | NI |
|---|---|---|
| Insurance model | Self-insurance (Crown) | Commercial insurance (NI fund) |
| Cost bearer | NSW Government agencies | NI premium pool |
| Claims agent | Gallagher Bassett | Multiple CSPs (Allianz, QBE, GIO, EML etc.) |
| Employer type | Government agencies | Private and public sector businesses |
| Psychological injury weight | High — defining cost driver | Growing — material but lower proportion |
| Litigation sensitivity | High — public sector visibility | Moderate |
| RTW rate (26 weeks) | 79.7% | 83.5% |
| Legislative base | WCA 1987 + NSW SIC Act 2004 | WCA 1987 |
| Regulator | SIRA | SIRA |
| Scale | Smaller active claim pool | ~148,000 active claims |

---

## Appendix B — Inference Flagging Convention

Where a claim is Inferred, format as:

> [I] *The mechanism is directionally supported by [source], which confirms [what the source says]. The specific quantum — [e.g. cost impact] — is not directly evidenced for TMF and represents a modelling assumption or cross-scheme analogy. To confirm, [required data source] would be needed.*

Asserted claims — claims present without any evidential anchor — must be removed or reclassified before output reaches stakeholders.
