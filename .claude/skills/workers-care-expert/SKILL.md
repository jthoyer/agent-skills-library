---
name: workers-care-expert
description: >
  Activates Claude as a resident expert on the NSW Workers Care scheme as administered by
  icare NSW. Use this skill whenever a task requires reliable, traceable analysis of Workers
  Care — including scheme mechanics, participant profile, service expectation positioning,
  opportunity hypothesis generation, cost driver analysis, executive framing, or
  evidence-graded research outputs. Trigger whenever the user references Workers Care,
  workers care programme, long-tail workers compensation support, severe injury workers
  compensation, catastrophic work injury, icare long-tail care, or improvement opportunities
  in the Workers Care scheme. Also trigger for any task that requires The Playbook
  confidence-grading discipline (Confirmed / Inferred / Asserted) applied to Workers Care
  scheme material.
---

# Workers Care Expert Skill

## Purpose

This skill encodes the knowledge base, analytical frameworks, evidence hierarchy, and output standards required to act as a reliable expert on the NSW Workers Care scheme administered by icare NSW. It governs how Claude reasons about scheme mechanics, participant profiles, service expectations, cost drivers, and improvement opportunities — and how it communicates findings in a way that is grounded, traceable, and fit for executive and programme use.

---

## A Mandatory Preliminary: Evidence Boundaries for This Skill

**Workers Care is the least evidence-rich scheme in the icare portfolio covered by these skills.** Before any analysis, this must be understood and stated.

The project source register rates the icare Workers Care Programme website source at **Medium confidence** — the same tier as a general scheme overview, not a primary legislative or audit source. There is no confirmed parliamentary review, no published audit series, and no scheme-specific actuarial data confirmed in the project materials.

What is confirmed:
- Workers Care exists as a distinct icare programme for long-tail workers compensation support
- It is consistently positioned alongside Lifetime Care as a low-volume, very long duration, high-individual-cost scheme in the project's service expectation reference packs
- The Workers Compensation Act 1987 provides the underlying legislative base for workers compensation entitlements that Workers Care participants hold
- icare administers it under the SICG Act 2015 mandate

What is not confirmed from project sources:
- The precise legislative and regulatory definition of Workers Care as distinct from the NI long-tail cohort
- Participant count and demographic profile
- Cost structure, average cost per participant, and funding model
- The claims delivery model (whether a CSP is involved or icare manages directly)
- The exact eligibility criteria and transition mechanics from NI to Workers Care

**This skill will make the evidence boundary explicit at every analytical step. Where project sources confirm something about Workers Care directly, it is graded Confirmed. Where the framing is derived by analogy with Lifetime Care or the NI long-tail cohort, it is graded Inferred and flagged as such. No Asserted claims will appear without challenge.**

The recommended first action for any substantive Workers Care analytical task is to review the icare Workers Care Programme website directly before producing findings.

---

## Part 1 — Scheme Fundamentals

### 1.1 What Workers Care Is — and What It Is Not

Workers Care is icare's programme for supporting workers with **serious, long-term workers compensation injuries** — the cohort who do not achieve a successful return to work and require sustained support beyond the standard NI claim lifecycle.

It is **not** a separate insurance scheme in the same legislative sense as the NI or Lifetime Care. It is best understood as a **specialist support and case management programme** for the most complex and long-duration tail of the NSW workers compensation population. [Confirmed — icare Workers Care Programme website, as referenced in the project source register with Medium confidence; exact legislative positioning requires direct source confirmation]

**What distinguishes Workers Care from the NI long-tail:**

| Dimension | NI Long-Tail | Workers Care | Confidence |
|---|---|---|---|
| Case management intensity | Standard CSP-managed | Specialist, more intensive | Inferred — supported by positioning as a distinct programme |
| Participant severity | Range including moderate long-tail | Serious / catastrophic work injuries | Inferred |
| Duration | Long — potentially years | Very long — potentially lifetime support | Inferred |
| RTW expectation | Remains a goal | May not be achievable for all participants | Inferred |
| Service model | CSP-delivered | icare programme delivery (exact model not confirmed) | Inferred |

**What distinguishes Workers Care from Lifetime Care:**

| Dimension | Lifetime Care | Workers Care | Confidence |
|---|---|---|---|
| Cause of injury | Motor accident | Workplace injury | Confirmed |
| Legislative base | Motor Accidents (Lifetime Care and Support) Act 2006 | Workers Compensation Act 1987 (base); Workers Care programme mechanics require direct source confirmation | Confirmed (WCA base); Inferred (programme specifics) |
| Funding model | CTP insurance levy (motor accident) | Workers compensation system (employer premiums) | Inferred |
| Entitlement character | Lifetime support — statutory right | Workers compensation entitlements — regime-defined | Inferred |
| No-fault status | Yes — no-fault scheme | No — fault/liability established through WC process | Confirmed |

### 1.2 Legislative and Governance Base

| Element | Detail | Confidence |
|---|---|---|
| Underlying legislation | Workers Compensation Act 1987 (NSW) — workers in the Workers Care programme hold WC entitlements under this Act | Confirmed |
| Governance framework | State Insurance and Care Governance Act 2015 (NSW) — establishes icare's mandate across all schemes | Confirmed |
| Financial reporting obligation | Government Sector Finance Act 2018 (NSW) | Confirmed |
| Scheme administrator | Insurance and Care NSW (icare) — administers Workers Care as a programme within the workers compensation system | Confirmed |
| Regulator | State Insurance Regulatory Authority (SIRA) — workers compensation regulator; oversight extends to the WC entitlements held by Workers Care participants | Confirmed |
| Programme-specific governance | Exact governance model for Workers Care as a distinct programme requires direct source confirmation | Not confirmed — flagged as evidence gap |

### 1.3 Scheme Scale

| Metric | Figure | Source |
|---|---|---|
| Participant count | Not confirmed in project sources | Evidence gap — requires icare Workers Care website or annual report review |
| Average cost per participant | Not confirmed | Evidence gap |
| Funding model (scheme-specific) | Not confirmed with precision | Evidence gap |
| icare enterprise scale (context) | ~3.9–4.0m workers insured; >9,000 Lifetime Care participants; ~148,000 NI active claims | icare Annual Report 2024–25 [Confirmed] — Workers Care sits within this enterprise but its volume is not separately confirmed |

**Scale framing:** The project's service expectation reference packs consistently describe Workers Care alongside Lifetime Care as "low volume, very long duration, high individual cost." This is the working analytical assumption pending direct source confirmation. [Inferred — derived from consistent cross-scheme framing in project reference packs]

### 1.4 The Participant Profile

Workers Care participants are workers who have sustained **serious workplace injuries** and have not achieved return to work within the standard NI claim lifecycle. The working profile, based on analogy with the Lifetime Care scheme and the project reference pack framing, is:

- Severe physical injury (spinal cord injury, traumatic brain injury, severe burns, multiple trauma) arising from a workplace incident [Inferred — logical from "severe injury" positioning; not directly confirmed for Workers Care specifically]
- Long-term or permanent functional limitation that precludes return to pre-injury employment
- Ongoing need for medical treatment, rehabilitation support, and potentially personal care
- Complex, multi-provider support arrangements requiring coordinated case management
- High likelihood of family or carer involvement as co-participants in the support relationship

**The difference from Lifetime Care participants:** Workers Care participants sustained their injury at work (not in a motor accident), meaning:
- The claim history includes an employer relationship and WC liability determination
- There may be a legacy of dispute or adversarial history from the initial claim phase
- The worker may have experienced the step-down in weekly benefits and other WC-specific mechanics before transitioning to the Workers Care support model
- The no-fault dynamic of Lifetime Care is absent — fault and liability were established through the WC process

[I] *These profile characteristics are Inferred from the scheme's positioning and legislative base. Direct participant demographics are not confirmed in project sources.*

---

## Part 2 — Cost Driver Logic

### 2.1 The Volatility Model

Workers Care shares the Lifetime Care cost model, not the NI duration model. The primary cost driver is **not** claim duration per se — it is **cost volatility**: care plan instability, crisis escalation, relationship breakdown, and provider fragmentation that drives unplanned, intensive, and expensive intervention.

**The analytical spine for Workers Care:**

**Care plan instability → Crisis escalation → Unplanned high-cost intervention → Cost spike**

This is the same spine as Lifetime Care. The mechanism is the same. The magnitude per participant and scheme is not confirmed. [I — derived from consistent cross-scheme framing in project reference packs; Workers Care-specific cost data not confirmed]

### 2.2 Primary Cost Drivers

| Driver | Mechanism | Confidence |
|---|---|---|
| Care plan instability | Frequent unplanned changes to approved support arrangements; providers exiting; needs changing | Inferred — derived from Lifetime Care analogy and low-volume / high-cost scheme framing |
| Crisis escalation | Unmet needs or relationship breakdown triggering emergency or intensive intervention; acute cost spikes | Inferred — derived from reference pack framing ("crisis escalation" cited directly for this scheme group) |
| Provider fragmentation | Multiple providers without coordination; gaps and overlaps in support | Inferred |
| Trust erosion | Participant or family advocacy breakdown; adversarial positioning; legal involvement | Inferred — reference packs confirm "adversarial family dynamics" as a cost amplifier for this scheme group |
| Transition friction from NI | Workers entering Workers Care may carry unresolved dispute history or adversarial posture from the NI phase; this legacy can complicate relationship-building | Inferred — logical from the workers compensation liability history; not directly evidenced |
| Long-duration compound cost | Very long support obligations mean small inefficiencies compound significantly over time | Inferred |

### 2.3 The Transition from NI — A Distinctive Risk

Workers Care participants have a workers compensation history that Lifetime Care participants do not. Before entering the Workers Care programme, they will have been:
- Managed by a CSP under the NI model
- Subject to liability decisions, step-downs, and RTW planning that may have produced conflict
- Potentially involved in formal dispute proceedings

This transition history is a risk factor that has no equivalent in Lifetime Care. A participant arriving in Workers Care with an adversarial posture inherited from the NI phase requires a different initial engagement approach to one arriving fresh from a motor accident into Lifetime Care. [I — mechanism plausible from scheme structure; not directly evidenced in project sources]

---

## Part 3 — Service Expectations Applied to Workers Care

The 16 service expectations apply to Workers Care through the volatility model — the same mechanism as Lifetime Care — but with two scheme-specific modifiers:

1. **The transition legacy modifier:** Some participants carry adversarial history from the NI phase; trust must be rebuilt, not assumed.
2. **The workers compensation residue:** WC entitlements under WCA 1987 continue to apply, meaning decisions about benefit rates, treatment approvals, and liability determinations are still part of the participant's experience — unlike Lifetime Care's cleaner no-fault support model.

### 3.1 High-Leverage Expectations in Workers Care

| Expectation | Workers Care Mechanism | Leverage | Evidence Grade |
|---|---|---|---|
| Empathy & Understanding | Participants are often severely injured and may have experienced adversarial WC processes before entering Workers Care; perceived indifference amplifies legacy distrust and triggers escalation | Critical | Inferred — reference packs directly cite this dynamic for this scheme group |
| Clear Handover | Complex support arrangements and long histories mean context loss at transition is extremely costly; every new case manager who lacks full context risks re-opening settled issues | High | Confirmed (problem pattern by analogy with NI audit findings and LTC framing); Inferred (Workers Care-specific) |
| Reliable Case Manager | Long-duration relationships depend on consistency; unreliability in a scheme where participants may already distrust the system amplifies adversarial posture | High | Inferred — reference packs directly cite care plan instability as the risk |
| Knowledgeable Case Manager | Severe injury participants with complex multi-provider support arrangements require deep scheme and clinical knowledge; knowledge gaps produce incorrect plan decisions and provider fragmentation | High | Inferred — reference packs directly cite misaligned care plans as a cost driver |
| Proactive Service | Unmet needs that are not identified early harden into crises; proactivity prevents the escalation spiral | High | Inferred — reference packs directly cite crisis escalation prevention for this scheme group |
| Timely Decisions | Care plan decisions gate treatment and support continuity; delays create health risk and trust breakdown in a high-vulnerability population | High | Inferred — reference packs directly cite cost volatility and crisis escalation for this scheme group |
| Transparency of Decisions | Participants with WC histories are accustomed to adversarial decision-making; transparent, clearly explained decisions are the primary mechanism for shifting that posture | High | Inferred |
| Communicating Clear Timelines | Uncertainty about support continuity is a primary anxiety trigger; clear timelines reduce defensive behaviour and legal engagement | High | Inferred |
| Empathy & Understanding | Particularly important where participant carries adversarial posture from NI history | High | Inferred |

### 3.2 The Behaviour Chain in Workers Care

```
Legacy adversarial posture (from NI phase)
    + Poor service quality (unclear decisions, unreliable case manager)
        → Trust breakdown
            → Legal engagement
                → Care plan instability
                    → Crisis escalation
                        → High-cost unplanned intervention
```

And in parallel:

```
Unmet support need (not proactively identified)
    → Escalation to crisis
        → Emergency intervention
            → Cost spike
            → Possible irreversible relationship breakdown
```

Both chains lead to the same outcome: cost volatility spikes that dwarf the cost of prevention.

### 3.3 Expectations with Different Character in Workers Care vs Lifetime Care

| Expectation | Workers Care Note |
|---|---|
| Self-Service | Low priority as a primary engagement channel — severely injured participants need supported navigation, not digital deflection; administrative self-service (invoice submission, status tracking) may be appropriate for carers/families |
| Channel Preferences | High importance — participants with physical limitations may have strong channel requirements; accessibility is non-negotiable |
| Easy Process | "Easy" means minimising burden on a severely injured person and their family; supported process navigation is more appropriate than digital simplification in many cases |
| Timely & Accurate Payments | High importance — for participants dependent on icare funding for care and support, payment accuracy and timeliness directly affects health and safety |

---

## Part 4 — Evidence Hierarchy

### 4.1 Source Tiers for Workers Care

| Tier | Source Type | Examples | Confidence |
|---|---|---|---|
| Tier 1 — Primary legislative | Act of Parliament | Workers Compensation Act 1987; SICG Act 2015 | Confirmed |
| Tier 2 — Scheme documentation | icare official programme documentation | icare Workers Care Programme website | Medium [per project source register] |
| Tier 2 — Enterprise performance | icare Annual Reports | Enterprise-level data; Workers Care-specific data not confirmed separately | Confirmed (enterprise); Inferred (scheme-specific) |
| Tier 3 — Analogical | Lifetime Care reference material; NI long-tail framing | Service expectation mechanisms that apply by analogy with adjustment | Inferred — analogy must be stated explicitly |
| Not admissible | Asserted claims | Workers Care cost figures not anchored to a cited source | Asserted — must be removed or reclassified |

### 4.2 The Analogy Protocol

Given the evidence-thin nature of Workers Care in the project source base, this skill uses a structured analogy protocol when drawing on Lifetime Care or NI material:

**When drawing on Lifetime Care analogy:**
> [I — Lifetime Care analogy] *The Lifetime Care scheme shares the same volatility cost model and low-volume / high-individual-cost structure. [Specific mechanism] applies to Workers Care by analogy because [stated reason]. This is Inferred pending direct Workers Care source confirmation.*

**When drawing on NI analogy:**
> [I — NI analogy] *The NI scheme shares the same WCA 1987 legislative base. [Specific mechanism] applies to Workers Care by analogy for the WC entitlement dimension. The care support dimension differs from the NI model and this analogy does not extend to [specific exclusion].*

### 4.3 Known Evidence Gaps

The following are material gaps that must be flagged for every Workers Care analytical task:

- **Participant count** — total active Workers Care participants not confirmed in project sources
- **Average cost per participant** — not confirmed; required before any financial sensitivity model
- **Funding and cost allocation model** — how Workers Care costs are funded within the workers compensation system not confirmed with precision
- **Eligibility and transition criteria** — exact criteria for entering Workers Care from the NI not confirmed
- **Claims delivery model** — whether a CSP delivers Workers Care or icare manages directly not confirmed
- **Transition adversarial posture rate** — what proportion of participants enter Workers Care with adversarial history from the NI phase; not confirmed
- **SIRA oversight and audit coverage** — whether SIRA audits Workers Care as a distinct programme or only through the NI lens; not confirmed

**Recommended action before any substantive Workers Care output:** Review the icare Workers Care Programme website directly. The source register flags this as the primary (Medium confidence) source for scheme mechanics. Any analytical work not grounded in a direct website review should be presented as directional only.

---

## Part 5 — Reform and Regulatory Context

### 5.1 Current Context (as at early 2026)

- **SIRA CMR (September 2025)** — recommends person-centred claims management reform system-wide; applies to the WC entitlement dimension of Workers Care; early intervention, proactive case management, and improved communication standards are directly relevant to the transition from NI to Workers Care
- **Navigator → Phineas technology migration** — the programme migration (covering Lifetime Care, Workers Care, and CTP Care) is a live context for Workers Care; the technology platform change affects case management workflow, participant records, and service delivery capability [Confirmed — referenced in project context materials]
- **Psychological injury growth in workers compensation** — while Workers Care is primarily a severe physical injury programme, any workers compensation system reform to address psychological injury trajectories affects the upstream pipeline that feeds Workers Care [Inferred]

### 5.2 The Navigator → Phineas Migration

Workers Care is one of three schemes explicitly included in the Navigator → Phineas technology migration programme. This is a confirmed operational context that affects:
- Case management workflow and tool availability
- Participant record integrity and transition
- Invoice and payment processing
- Self-service capability for participants and providers
- Handover quality during the migration period

[Confirmed — referenced in project context materials. Specific migration timelines and scope require programme documentation review.]

---

## Part 6 — Key Analytical Principles for Workers Care

1. **Workers Care is not Lifetime Care.** The two schemes share a cost model (volatility, not duration) and a participant profile shape (low volume, high cost, long duration). But Workers Care participants hold workers compensation entitlements, have WC dispute histories, and sit within the workers compensation regulatory framework. Apply LTC analogies explicitly and flag them.

2. **The transition from NI is a first-order analytical variable.** The legacy of the NI claims process — including any adversarial history — is not present in Lifetime Care and must not be assumed away in Workers Care analysis. Trust rebuilding is part of the Workers Care service model in a way that has no Lifetime Care equivalent.

3. **Volatility is the cost driver, not duration.** The question is not how long the support obligation runs — it will run for years — but how stable the care arrangement is and how frequently crisis-driven cost spikes occur.

4. **Evidence gaps must be named, not papered over.** Workers Care is evidence-thin in the project source base. Every quantitative claim about Workers Care requires a source. Where no source exists, the claim must be positioned as directional or Inferred, and the gap flagged.

5. **The Phineas migration is live operational context.** Any Workers Care service design or system work occurs in the context of an active technology migration. This is not background — it affects what is possible, what is in-flight, and what should not be duplicated.

6. **The family advocate is a co-participant.** As in Lifetime Care, Workers Care participants with severe cognitive or physical limitations will frequently have family members or carers as the primary operational interface with icare. Service design that ignores the family is incomplete.

7. **The Playbook confidence discipline is more important here than anywhere else.** Because Workers Care evidence is thinner than any other icare scheme in the project, the risk of Asserted claims appearing in outputs is higher. Every claim must be graded before delivery.

---

## Part 7 — Quick Reference for Common Tasks

### Generating a Workers Care opportunity hypothesis
→ Identify the expectation → trace the mechanism through the volatility model (not duration model) → check whether the transition-from-NI modifier applies → assign to care plan instability, crisis escalation, provider fragmentation, or trust erosion → grade the evidence → flag analogy sources explicitly → name the specific evidence gap that would confirm the quantum.

### Framing a Workers Care business case for an executive audience
→ Lead with the volatility mechanism (care plan instability → crisis escalation → cost spike) → acknowledge the transition-from-NI legacy as a distinctive risk → draw on Lifetime Care analogies where appropriate and label them → state all financial figures as directional with evidence gaps named → connect to the Phineas migration as live operational context where relevant.

### Distinguishing Workers Care from Lifetime Care
→ Key differentiators: workers compensation cause (not motor accident); WCA 1987 legislative base; fault-based (not no-fault); NI transition history; SIRA workers compensation regulatory framework; Phineas migration scope.

### Distinguishing Workers Care from NI long-tail
→ Key differentiators: specialist programme (not standard CSP-managed); higher severity; lower volume; volatility cost model (not duration model); support orientation rather than RTW orientation; different service delivery model (details require source confirmation).

### Responding to a request that requires Workers Care-specific data
→ First: acknowledge the evidence gap explicitly. State what is confirmed (legislative base, scheme positioning, analogy from LTC/NI). State what requires direct source review (participant count, costs, eligibility, delivery model). Recommend icare Workers Care Programme website as the next source to consult. Then provide the directional analysis clearly labelled as such.

---

## Appendix A — Workers Care vs Lifetime Care vs NI Long-Tail (Quick Reference)

| Dimension | Workers Care | Lifetime Care | NI Long-Tail |
|---|---|---|---|
| Cause of injury | Workplace injury | Motor accident | Workplace injury |
| Legislative base | WCA 1987 + Workers Care programme | Motor Accidents (LCS) Act 2006 | WCA 1987 |
| Fault/no-fault | Fault-based (WC liability) | No-fault | Fault-based |
| Cost model | Volatility (care plan instability) | Volatility (care plan instability) | Duration (weekly benefits) |
| Volume | Low (not confirmed precisely) | Low (~9,000 participants) | High (~148,000 active claims) |
| RTW expectation | Reduced or absent for most | Not applicable (catastrophic injury) | Present — primary goal |
| NI transition history | Yes — legacy risk | No | N/A |
| Technology migration | Yes — Phineas | Yes — Phineas | No |
| Primary evidence source | icare website (Medium confidence) | MAIV Act; icare Annual Reports; SIRA | WCA 1987; SIRA audits; icare Annual Reports |
| Evidence richness | Thin | Moderate | Rich |

---

## Appendix B — Inference Flagging Convention

Where a claim is Inferred from Lifetime Care analogy:

> [I — Lifetime Care analogy] *[Mechanism] applies to Workers Care by analogy with the Lifetime Care scheme, which shares the same [volatility cost model / low-volume structure / family advocate dynamic]. The Workers Care-specific expression of this mechanism is not directly evidenced in project sources. To confirm, [icare Workers Care programme data / direct source review] would be needed.*

Where a claim is Inferred from NI analogy:

> [I — NI analogy] *[Mechanism] applies to the workers compensation entitlement dimension of Workers Care by analogy with the NI scheme, which shares the same WCA 1987 legislative base. This analogy does not extend to the care support dimension of Workers Care, which follows the volatility model rather than the duration model.*

Asserted claims — present without any evidential anchor — must be removed or reclassified before output reaches stakeholders.
