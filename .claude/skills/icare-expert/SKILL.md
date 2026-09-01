---
name: icare-expert
description: >
  Activates Claude as a portfolio-level expert on Insurance and Care NSW (icare) and all its
  administered schemes. Use this skill for cross-scheme analysis, portfolio-level executive
  framing, scheme comparison work, the service expectations framework applied across multiple
  schemes, the Navigator → FINEOS technology migration, icare enterprise financials, or any
  task that spans more than one icare scheme simultaneously. Also trigger when the user asks
  about icare generally without specifying a scheme, or when comparing how a concept (duration,
  volatility, service expectations, cost drivers) applies across the full portfolio. IMPORTANT:
  when a task is clearly focused on a single scheme, defer to the appropriate scheme-specific
  skill rather than handling it here.
---

# icare Expert — Portfolio Skill

## Purpose

Portfolio-level context, routing logic, and cross-scheme frameworks for the full icare scheme
portfolio. Use this skill for tasks spanning multiple schemes, executive framing, the 16 service
expectations as a cross-scheme framework, the Navigator → FINEOS migration, and enterprise
financial context.

**This skill does not replace individual scheme skills.** For single-scheme tasks, load the
named scheme skill. This skill provides what they cannot: the connections between them.

**Tone of voice dependency.** All substantive programme outputs must also apply the
`icare-tone-of-voice` skill. It governs expression; this skill governs content.

---

## Part 1 — Routing

### Scheme → Skill Map

| Scheme | Short Name | Cost Model | Skill |
|---|---|---|---|
| Workers Compensation Nominal Insurer | NI | Duration (weekly benefits) | `ni-scheme-expert` |
| Workers Compensation Treasury Managed Fund | TMF | Duration (esp. psychological injury) | `tmf-expert` |
| NSW Dust Diseases Care | DDC | Compensation + medical support | `ddc-expert` |
| Workers Care | Workers Care | Volatility (care plan instability) | `workers-care-expert` |
| Lifetime Care | LTC | Volatility (care plan instability) | `lifetime-care-expert` |
| Home Building Compensation Fund | HBCF | Rectification cost | `hbcf-expert` |
| CTP Care | CTP Care | Statutory benefits + early treatment | `ctp-care-expert` |
| General Lines Motor | GL Motor | Settlement quantum + legal cost | `general-lines-motor-expert` |
| General Lines Asset / Liabilities | GL Asset | Rectification + settlement cost | `general-lines-asset-expert` |

### Routing Rules

1. **Named scheme** → load that scheme skill; do not use this skill as primary knowledge source
2. **Multiple schemes or portfolio framing** → use this skill; load individual scheme skills for depth
3. **"icare" generically** → use this skill; flag where analysis is scheme-specific
4. **16 service expectations across schemes** → use this skill for the framework; scheme skills for impact mapping
5. **Navigator → FINEOS migration** → use this skill (Part 3); migration spans LTC, Workers Care, CTP Care
6. **CTP Care** → load `ctp-care-expert`; do not route to `lifetime-care-expert` or `ni-scheme-expert` by default
7. **General Lines** → load `general-lines-motor-expert` or `general-lines-asset-expert`; apply B2B framing — the client is an agency, not an individual claimant
8. **Any substantive output** → also load `icare-tone-of-voice`
9. **Scheme unclear** → ask before loading a scheme skill; if user cannot specify, use this skill and acknowledge the generalisation

---

## Part 2 — Cost Models

Four cost models govern the portfolio. Misapplying one to another scheme is the most common
analytical error in this programme.

| Cost Model | Schemes | Primary Driver |
|---|---|---|
| Duration | NI, TMF, CTP Care | Weekly benefit weeks; statutory benefit continuation |
| Volatility | Lifetime Care, Workers Care | Care plan instability; crisis escalation |
| Rectification | HBCF | Scope and cost of building defect repair |
| Compensation + support | DDC | Payment adequacy; timeliness; medical cost |
| Settlement + legal cost | GL Motor, GL Asset | Settlement quantum; legal cost; liability resolution |

**Rule:** Confirm the cost model for each scheme before any cross-scheme analysis. Never
aggregate across models without explicit acknowledgement.

**General Lines note:** B2B institutional schemes. Personal injury framing must not be imported.

---

## Part 3 — Navigator → FINEOS Migration

Affects three schemes: **Lifetime Care**, **Workers Care**, **CTP Care**.

Replaces the Navigator platform with **FINEOS AdminSuite (FINEOS Claims)** — a customer-centric,
web-based claims management platform providing straight-through processing, integrated payments,
provider management, and return-to-work support.
[Confirmed — FINEOS: https://www.fineos.com/adminsuite/claims-management-software/]

**Service expectation risks during migration:**
- Clear Handover — case records and context must transfer accurately
- Timely & Accurate Payments — payment workflows change at cutover
- Self-Service — participant-facing digital capability changes
- Knowledgeable / Proactive Case Manager — reduced capacity during platform transition

**Analytical principle:** Any improvement initiative affecting LTC, Workers Care, or CTP Care
must be assessed against the FINEOS migration timeline. Parallel workstreams during platform
change carry elevated execution risk.

---

## Part 4 — Enterprise Financial Context (FY25)

| Metric | Figure | Source |
|---|---|---|
| Workers insured | ~3.9–4.0 million | icare Annual Report 2024–25 [Confirmed] |
| Businesses covered | ~340,000 | icare Annual Report 2024–25 [Confirmed] |
| Lifetime Care participants | >9,000 | icare Annual Report 2024–25 [Confirmed] |
| Government assets protected | $437bn | icare Annual Report 2024–25 [Confirmed] |
| Service fee revenue | $1.316bn | icare Financial Statements 2024–25 [Confirmed] |
| Agent remuneration | $741m | icare Financial Statements 2024–25 [Confirmed] |
| Total operating expenses | ~$1.318bn | icare Financial Statements 2024–25 [Confirmed] |

Service improvements reducing claims handling complexity directly affect agent remuneration
($741m). Operating expenses approaching revenue means no commercial margin buffer.

---

## Part 5 — Cross-Scheme Output Standards

When producing outputs spanning multiple schemes:

- State which schemes are included and which are excluded, and why
- Apply each scheme's cost model correctly — never aggregate duration and volatility metrics
- Confidence-grade schemes separately — Confirmed for NI may be only Inferred for TMF
- Flag evidence asymmetries — NI and LTC are evidence-rich; Workers Care is evidence-thin; CTP
  Care and General Lines have thinner cross-programme integration to date
- Do not apply the NI's ~148,000-claim scale to other schemes
- Do not import personal injury framing into General Lines
- Express cost impact as leverage grades (Small / Medium / Large / X-Large), not dollar figures
- Label all claim volumes as approximate

---

## Part 6 — Tone of Voice as a Programme Dependency

`icare-tone-of-voice` governs register, language discipline, confidence grading conventions, and
output standards across all schemes and document types. Load it alongside the relevant scheme
skill for all programme deliverables (journey stories, reference packs, executive briefs,
business cases, discovery documents). Not required for internal routing or evidence grading steps.

---

## Quick Reference

| Task | Action |
|---|---|
| Single scheme, named | Load scheme skill directly |
| Multiple schemes / portfolio | This skill + named scheme skills |
| Migration work | This skill Part 3 + LTC / Workers Care / CTP Care scheme skills |
| Enterprise financials | This skill Part 4 |
| CTP Care | `ctp-care-expert` + this skill Part 3 if migration relevant |
| General Lines | `general-lines-motor-expert` or `general-lines-asset-expert` (B2B framing) |
| Any substantive output | Also load `icare-tone-of-voice` |
| Cross-scheme business case | Confirm cost model per scheme → leverage grades (S/M/L/XL) → grade evidence separately → deduplicate claim populations |
| icare's biggest financial lever | Volume: NI (~148k claims); Individual cost: LTC/Workers Care; Moral urgency: DDC; Legal cost: General Lines; Political risk: DDC + TMF |

---

## Change Log

| Version | Date | Summary |
|---|---|---|
| v1 | Early 2026 | Initial — six schemes |
| v2 | March 2026 | Added CTP Care, General Lines Motor, General Lines Asset; added tone-of-voice dependency; updated routing and leverage grid |
| v3 | March 2026 | Corrected Phineas → FINEOS (FINEOS AdminSuite / FINEOS Claims) throughout; added product description and source URL |
| v4 | March 2026 | Restructured for progressive disclosure; moved scheme inventory, service expectations, and reform context to reference files; reduced SKILL.md from 481 to ~180 lines |
