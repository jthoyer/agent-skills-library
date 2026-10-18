---
name: market-analyst
description: >
  Structured competitive market analysis skill for sports technology, fitness apps, and endurance
  sports categories. Use this skill whenever the user asks to analyse, compare, or review apps,
  platforms, or products in a specific market segment — including requests like "what apps are out
  there for X", "analyse the triathlon app space", "what are competitors doing", "review the market
  for X", "what are users saying about apps in Y category", or "find market gaps in Z". Combines
  web-sourced user sentiment, per-product assessment, cross-category patterns and a gap
  opportunity matrix. Triggers on
  market analysis, competitor review, app landscape, user complaints, product gaps, sports tech
  review, and "what's available for X".
---

# Market Analyst

A skill for producing structured, evidence-based competitive market analyses of sports technology and fitness app categories — grounded in actual user sentiment, not marketing claims.

---

## Phase 1: Refine the brief

Before searching, confirm:
- **Category scope**: What discipline(s), use case(s), or product types are in scope? (e.g. triathlon training apps, race-day nutrition, indoor cycling, injury prevention)
- **Athlete context**: Who is the primary user — competitive age-grouper, coach-led athlete, beginner, elite? This governs which failure modes matter most.
- **Product relevance**: Is the analysis being conducted to identify gaps for a specific product being built? If yes, note it — the gap matrix should map directly to that product's positioning.

If the brief is clear enough from context, proceed without asking.

---

## Phase 2: Research strategy

Run web searches across three evidence types, in parallel where possible:

### 2a. User sentiment (primary evidence)
Search: `[app name] user reviews complaints [year]`, `[app name] reddit criticism`, `[app name] app store review`, `[app name] trustpilot`

**Target sources (in priority order):**
1. App Store / Google Play reviews (verbatim user language)
2. Trustpilot (Confirmed complaints, patterns)
3. Reddit (r/triathlon, r/running, r/Zwift, r/TrainingPeaks etc.) — raw, unfiltered
4. DCRainmaker, Triathlete.com, 220 Triathlon — expert editorial with user comment threads
5. MOTTIV, Phazon Triathlon comparison pieces — aggregated athlete opinion

**Evidence grading:**
- **Confirmed**: Consistent complaint pattern across ≥3 independent sources
- **Inferred**: Mentioned by credible editorial source + 1–2 user reviews
- **Asserted**: Single source; flag as such

### 2b. Feature and positioning data
Search: `[app name] features pricing 2025`, `[app name] vs [competitor]`

### 2c. Category gaps (scientific/structural)
Where relevant, search for peer-reviewed evidence on athlete health problems, nutrition failures, injury epidemiology — this grounds gap identification in mechanism, not opinion.

---

## Phase 3: Output structure

Produce output in the following order. Do not abbreviate any section.

### Executive summary
3–5 sentence synthesis: what the category does well overall, its dominant failure pattern, and the single clearest market gap.

### Per-app assessments
For each major platform:
- **App name** + category badge (tracking / coaching / social / indoor / nutrition / planning)
- **What it does well** — mechanism-first, 3–5 sentences
- **User-reported failure modes** — evidence-graded, 3–5 sentences. Lead with the most commonly cited complaint. Do not soften or hedge findings.
- **Pricing** — current, to contextualise value perception complaints

### Cross-category failure patterns
Identify 3–5 structural failure modes that appear across multiple platforms. These are the most diagnostically valuable — they indicate category-wide blind spots, not just individual product weaknesses.

**Common patterns to check for:**
- UI complexity creep (data buried by redesign)
- Mobile as second-class citizen
- AI as surface feature (insights without mechanism)
- Completion-athlete bias (features designed for finishers, not competitors)
- GI / health problem neglect
- Pricing opacity and subscription backlash

### Gap opportunity matrix
A structured table with columns:
| Gap | Current market response | Priority |
| --- | --- | --- |

Priority: **High** = no credible competitor, confirmed athlete problem, clear product surface. **Med** = partial solutions exist. **Low** = niche or already being addressed.

Where the analysis is in service of a specific product (e.g. TRI Momentum), annotate which gaps the product is positioned to address.

---

## Phase 4: Visualisation (if widget rendering is available)

Use `visualize:show_widget` to render the analysis as an interactive dashboard:
- Metric summary cards (platforms analysed, failure modes, gap count)
- Per-app two-column cards (strengths / failure modes)
- Cross-category failure pattern cards in a 2x2 grid
- Gap opportunity matrix as a structured table

Read the `chart` and `data_viz` modules from `visualize:read_me` before rendering.

---

## Phase 5: Skill creation trigger

If the user asks to "create a skill from this" or "turn this into a skill" after running the analysis, follow the `skill-creator` skill workflow to package the output as a reusable skill. The market-analyst skill itself is the template.

---

## Evidence standards

- Never state a failure mode without a source type (user review / editorial / peer-reviewed)
- Never present a market gap without explaining why current products fail to address it (mechanism, not just absence)
- Distinguish between:
  - Problems that are **universal** (every platform has them)
  - Problems that are **category-leader specific** (dominant app's flaw is the category's flaw by default)
  - Problems that are **segment-specific** (e.g. only affects competitive athletes, not beginners)

---

## Tone and format

- Analytical and direct. No hedging on user sentiment — if users hate a UI redesign, say that.
- Mechanism-first: explain *why* something is a problem, not just *that* it is
- No bullet-point lists unless listing a set of discrete items; use prose for analysis
- Findings are the priority; tooling and methodology are background

---

## Skill routing for execution

This skill is commonly paired with:
- `rewrite` — when the user's initial request is underspecified
- `multi-actor-research` — for deeper, evidence-graded synthesis with devil's advocate challenge
- `product-requirement-document` — when gap analysis flows into feature scoping
- `triathlon-coach` — for domain validation of findings against coaching science

---

## Example trigger phrases

- "analyse the triathlon app market"
- "what apps exist for race nutrition planning"
- "what are users saying about [app name]"
- "review the competitive landscape for [category]"
- "what gaps exist in the [sport] tech space"
- "compare the main training platforms"
- "market analysis of [category] for my product"
- "conduct market analysis of triathlon and triathlon related sports apps"
