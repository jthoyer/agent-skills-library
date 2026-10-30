# ux-designer — 2026-10-30 — BBallSkills three improvement options

First run after `design-principles.md` landed (PR #79). Dispatched by `cpo` from a `/rewrite` of: "review https://jthoyer.github.io/BBallSkills/ — design three options for improvements, both visual styling and user flow".

## Brief (summary of the dispatch)
Frame: three distinct, buildable options (visual + flow), each with thesis, visual, flow before/after for player/parent/coach, trade-off, Rams principles leaned on or strained, size and files. Recommend one, stated as a proposal. Read-only on the repo. Keep the no-data rule. Inputs: repo source, STYLEGUIDE.md, design-principles.md, external-content.md, 14 main-thread screenshots (7 routes × 390/1280px). Live URL blocked. Outputs: options doc ≤1,400 words, one self-contained HTML mock (390px home + drill per option), ≤300-word summary.

## Output (verbatim summary as returned)
- A "Find" (M): one filterable list of all 18 drills; drill page reordered; more drills at the end. **Recommended** (agent's choice, unconfirmed).
- B "Play" (M): suggested-today card, progress strip, Next drill bar.
- C "Plan" (L): coach builds a plan held in the URL hash; asks the user to confirm that fits "collects no data".
- Critique: 8 points, each tied to a screenshot or file:line and a principle.
- Defects: `router.js:62` (Skills tab always lit on a drill), `drill.js:16` (Back ignores origin), `components.css:141-142` (tick rule "declared twice").

## Disk-verified outcome (main thread)
- Repo untouched (`git status` clean). Doc 1,213 words (within cap). Mock: no external requests.
- `router.js:62` and `drill.js:16`: confirmed.
- `components.css:141-142`: **false positive**. The second rule is the `content: "x" / ""` alt-text form with the first as fallback; deliberate. Main thread struck it.
- Critique cited "Thumbnail unavailable" as a site problem; it is an artefact of the review sandbox blocking YouTube, which the brief stated. Agent self-flagged it as loose. Main thread reworded.
- Mock overflowed by 16px at 390px (flex child without `min-width:0`). Main thread fixed. Agent did not render its own mock (it has no browser).
- Every principle citation names a specific Rams number with a reason; trade-offs cite principles, not taste. That was the 10-30 reference's expected effect.
- Mock video lengths and the plan total (4:19) match `content.js`.
