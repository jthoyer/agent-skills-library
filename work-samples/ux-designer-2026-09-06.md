# UX direction — CPO Dispatch Map v7

Definition: `.claude/agents/ux-designer.md`
Brief: design (not build) the replacement for `dispatch-map-v6.html`. Establish audience and the one task the page must support from the actual library, not by assumption. Deliverable is the direction — three options, a recommendation, the chosen one polished into a spec — not the final HTML.

---

## 1. Who this is for, and the one task it must support

Established from the material, not assumed:

- **Audience: Justin, acting as himself** — the one human operator of this library — at the moment *before* he types a request, deciding where it should go. Not CPO: `CPO.md` step 2 explicitly refuses to trust a static map ("Inventory before routing — never against a remembered list... Enumerate live") and re-derives the roster from frontmatter via a bash sweep every time it runs. A hand-authored HTML page is structurally the wrong source of truth for an agent that can grep. So this page has exactly one real consumer, and it's the person who *doesn't* have a grep loop running in his head — which is also, not coincidentally, why v6 drifted twice (missing `ux-designer`, `investigator`, `security-auditor`, `release-engineer`, the two shared references) without anything downstream noticing or complaining.
- **The one task: reverse lookup.** "I have a piece of work in mind and no agent name attached to it — which of the 16 agents, or which skill, should it go to?" That's the brief's own framing, and it's also the one job v6's actual structure doesn't support: v6 has three separate `Need → Route` tables (COS's, the skills-only one, and CPO's own step-3 table lives only in `CPO.md`, not in the HTML at all), and its one big agent table (`The library`) is organised by *what an agent is* (hub / specialist / pipeline actor) rather than *what the work looks like*. To use it today you either already know the agent's name, or you read all 16 role descriptions and pattern-match yourself — which is the exact effort this page should be removing.
- **Secondary jobs v6 also serves, kept but demoted:** understanding dispatch mechanics (frame → route → execute → close), the tool-guarantee inventory (useful for "can this agent actually edit files"), and the versioned history of *why* the roster looks like this. None of these are the reverse-lookup task, and v6 currently gives them equal or greater visual weight than the lookup itself.

**The sharper finding, from reading the ledger rather than guessing:** this library's actual, *recorded* routing failures are almost never "no idea where to start" — they're **sibling collisions**. `agent-improver`'s 2026-09-05 review of `cos` found its trigger phrase colliding with `CPO`'s ("what should I work on" vs "who should work on this"). `mc-reviewer`'s 2026-09-06 review flagged a routing-layer asymmetry with `code-improver`. Four agents — `code-improver`, `mc-reviewer`, `watchdog`, `security-auditor` — all describe themselves partly by *how they differ from each other* in their own frontmatter, because the authors already knew this was the confusable cluster. `ux-designer` vs `cody`, `mc-planner` vs built-in `Plan`, `security-auditor` vs the `security-review` skill, `release-engineer` vs `mc-verifier`, `agent-improver` vs `watchdog` — same pattern, seven times over. **A routing aid for this library is 80% a disambiguation tool for near-neighbours, not a directory for strangers.** That fact should drive the shape, not just the content.

---

## 2. What this is grounded in

Per the library's own `ux-designer.md` step 2: don't invent patterns, cite what's proven, and re-check currency rather than reciting from memory.

- **The interaction model** (a filterable, task-first lookup table over a role-first directory) is the same move behind command palettes (VS Code's `Cmd+K`, Linear, Notion's `Cmd+K`) and behind well-run internal-tools directories generally: index by *intent*, not by *org chart*. shadcn/ui's own `Combobox`/`Command` component is the closest packaged analogue — search-as-you-type over a flat list, grouped, with a visible empty state.
- **The disambiguation-strip technique** (naming what a sibling is *not*, side by side) is already native to this codebase — `mc-orchestrator.md`'s own "Exists to catch / Never does" MECE table is the pattern, just never surfaced outside that one file. Reusing an in-house pattern beats importing a new one.
- **Type/spacing/hierarchy discipline** follows Refactoring UI's baseline heuristics (type scale, spacing rhythm, contrast over cleverness) — already reasonably well applied in v6's CSS, which is one reason I'm not proposing to replace it (see §6.3).
- I did not need to run a fresh `WebSearch` for "what's currently highest-adoption" here, because the actual decision in this brief is IA (page structure), not visual style — the visual language is already established and working (§6.3) and the interaction pattern being proposed (filter-over-a-flat-index) hasn't shifted underneath it since shadcn/Radix's `Command` pattern became the default; I'd re-check before a *visual* system decision, not this one.

---

## 3. Three options

All three keep v6's visual language (serif/mono pairing, the existing color tokens, the `figure`/`table`/`caveat` component vocabulary — see §6.3 for why). They differ in the **interaction model for the lookup itself**, which is the actual open question.

### Option A — Filterable router table (search-first)

One flat, always-visible table, grouped under task-domain headers (`Ship or build code`, `Review or audit something`, `Decide how it should look`, `Research or pressure-test`, `Communicate`, `Personal & portfolio`), with a single text input at the top that live-filters every row by substring match against its shape-of-work text, trigger phrases, and route. No clicks required to see the whole thing; the filter is pure acceleration, not a gate.

```html
<div class="router">
  <label for="router-filter" class="router-label">Find your route</label>
  <input id="router-filter" type="text" class="router-filter"
         placeholder="e.g. “bug I can’t explain”, “review this diff”, “what should this look like”"
         aria-describedby="router-count">
  <p id="router-count" class="t-sub" aria-live="polite">20 routes shown</p>

  <section class="router-group" data-group="review">
    <h3>Review or audit something that already exists</h3>
    <table class="router-table">
      <tr data-match="read only code quality readability performance no spec">
        <td class="who">code-improver</td>
        <td>Read-only quality pass, no spec to check against</td>
      </tr>
      <tr data-match="spec bound defect hunt inside the coding pipeline blocks merge">
        <td class="who">mc-reviewer</td>
        <td>Same, but against a Stage 1 spec, inside the pipeline</td>
      </tr>
      <tr data-match="cross work sweep duplication across many files not one artifact">
        <td class="who">watchdog</td>
        <td>Same question, asked across many artifacts at once</td>
      </tr>
      <tr data-match="security owasp stride auth payments">
        <td class="who">security-auditor</td>
        <td>Same question, security-only, its own dispatch</td>
      </tr>
    </table>
    <p class="router-collision">These four all read code and say what's wrong.
      Pick by: <b>is there a spec?</b> → mc-reviewer. <b>Many files, not one?</b> → watchdog.
      <b>Security-shaped?</b> → security-auditor. <b>None of those?</b> → code-improver.</p>
  </section>
  <!-- … remaining groups … -->
</div>
```

**Trade-off:** fastest possible path when you have *any* word for the work — one keystroke narrows 20 rows to 2. Degrades gracefully with JS off (it's just a grouped table). Its weakness is exactly what it doesn't solve for free: filtering finds rows that *match your words*, not rows that are *siblings of each other* — the collision note under each group is doing that work by hand, and it only helps if you land in the right group to begin with.

### Option B — Guided decision tree (question-first)

A single top-level question ("What kind of work is this?") with 6-7 branches as expandable disclosures; picking a branch reveals 2-4 candidates with a one-line disambiguator each. No search box — the tree *is* the search.

```html
<details class="router-branch">
  <summary>Something's already wrong and I don't know why</summary>
  <div class="router-branch-body">
    <p><b>investigator</b> — root cause unknown, nothing shipped yet needs fixing by you</p>
    <p class="router-collision">Not this if you already know the cause and just need it built:
      that's <b>cody</b> or <b>mc-implementer</b>. Not this either if the code hasn't shipped yet
      and you're checking it <i>before</i> it does — that's <b>mc-reviewer</b> (against a spec) or
      <b>watchdog</b> (across several things).</p>
  </div>
</details>
<details class="router-branch">
  <summary>I want to ship or change code</summary>
  <div class="router-branch-body">…</div>
</details>
```

**Trade-off:** best for someone with genuinely no vocabulary for what they need yet — the question does the work a search term can't when you don't have the word. Costs a click-then-read round trip even when you *do* already know roughly what you want, which is the more common case for a solo operator revisiting his own library. Also forces every request into exactly one branch, and this library's own step-3 table in `CPO.md` explicitly allows a request to span more than one ("build this feature and make sure the research holds up") — a tree structurally fights that.

### Option C — Domain cards with sibling comparison strips (neighbourhood-first)

A card grid, one card per task-domain, each card built around a small comparison table in the exact shape `mc-orchestrator.md` already uses internally for its five actors (`Actor | Exists to catch | Never does`) — applied to whichever agents/skills are the confusable cluster in that domain.

```html
<article class="router-card">
  <h3>Review or audit something that already exists</h3>
  <table class="router-compare">
    <thead><tr><th>Who</th><th>Exists to catch</th><th>Never does</th></tr></thead>
    <tbody>
      <tr><td class="who">code-improver</td><td>General quality issue, no spec</td><td>Cross-file duplication; can't edit</td></tr>
      <tr><td class="who">mc-reviewer</td><td>Spec-bound defect, ranked for merge</td><td>Runs the code</td></tr>
      <tr><td class="who">watchdog</td><td>Duplication/error across artifacts</td><td>Single-artifact review</td></tr>
      <tr><td class="who">security-auditor</td><td>OWASP/STRIDE, confidence-gated</td><td>Fixes anything</td></tr>
    </tbody>
  </table>
</article>
```

**Trade-off:** makes the *actual* failure mode (§1's finding) the headline of the page rather than a footnote under a table — the comparison is unmissable, not opt-in. But it's the heaviest to keep current: every new agent needs a human to decide which existing card's comparison table it joins and re-write that table's "never does" column so it stays mutually exclusive, which is exactly the kind of hand-maintained, drift-prone authoring that produced v6's staleness in the first place (§2 of the diagnosis). It's also worse than A at the plain "I already know what I want, just confirm the name" case, since nothing is scannable in one flat list.

---

## 4. Recommendation

**Option A, with Option C's comparison-strip technique folded in as the disambiguation note under each group** (visible in A's wireframe above) — not a separate card layer. One sentence why: A is the only one of the three that costs *zero* extra interaction for the common case (you already have a rough word for the work) while still surfacing the actual recorded failure mode (siblings) as a first-class, always-visible element rather than a click away, and it degrades to a perfectly usable static table with JavaScript off, which a lookup-tool-you-open-under-time-pressure should.

Stating this as a recommendation, not a decision — per this library's own convention (CPO's portfolio calls are proposed and signed off, not self-approved), Justin picks; I'd flag it if this recommendation gets substantially reworked, per step 8 below.

---

## 5. The chosen direction, polished

### 5.1 Full page outline (top to bottom)

1. **Header** — kept from v6 (eyebrow / h1 / standfirst / meta stats), stats recomputed at generation time, not hand-typed (see 5.2).
2. **`Find your route`** *(new, hero position, immediately after the header, no scrolling required)* — the filterable, grouped router from Option A. This is the page's reason to exist; everything below is support material.
3. **`Where a request goes, mechanically`** — v6's "How a request gets routed" SVG diagram, kept, updated to place `ux-designer`, `investigator`, `security-auditor`, `release-engineer` and the two shared references (`review-gates.md`, `external-content.md`) correctly.
4. **`The roster`** — v6's "The library" inventory table (agent / model / role / tool guarantee), kept, but re-labelled as generated (5.2) and footnoted with which agents read which shared reference.
5. **`The coding pipeline, in sequence`** — kept as-is; it's a different question (mechanics of one pipeline) from the router (which route to take), and it isn't broken.
6. **`Skills this library names directly`** — the *named* skills from `CPO.md`'s step-3 table only (there are ~49 skill directories total; most aren't individually notable enough for this page). Explicit note: "everything else — check the session's skill listing, not this page."
7. **`Inline self-review`** — kept from v6, short, folded to a compact note rather than a full section (it's two agents, one mechanism).
8. **`Where COS sits`** — kept, shortened; its `Need → Route` table is now redundant with the router (folded in there) so this section becomes pure context: what COS is, why it isn't inside CPO's portfolio, the staging/mandate/decision-log mechanics.
9. **`How the library got here`** *(collapsed by default, `<details>`)* — v6's history appendix, unchanged in content, demoted structurally rather than deleted. It's real, valuable, audit-relevant material that simply isn't the reverse-lookup task.
10. **Footer** — kept, stats regenerated.

This collapses v6's **three separate lookup tables** (COS's, skills-only, and the step-3 logic that never made it into the HTML at all) into **one**, and demotes the two sections that don't serve the stated task (mechanics, history) without deleting them.

### 5.2 Generate the router from source — the actual fix for staleness

v6 went stale twice on hand-typed content. The router's *facts* (`name`, `description`, whether it's a hub/pipeline actor) must come from the same frontmatter sweep `CPO.md` step 2 already runs — not be retyped. Concretely, hand this to `cody`/whoever builds it as a two-part data model:

- **Generated, every build:** `name`, one-line `description` (truncated with a "…" affordance past ~140 chars, never silently cut — see 5.4), `model`, and a `flag` column reusing CPO's own flags (`NAME!=FILENAME` / `DESC>1024` / `NO-MODEL`) so a live library defect *shows up on the page* instead of being invisible.
- **Hand-curated, rarely:** which task-domain group each agent/skill belongs to, the one-line "shape of the work" phrasing, and the collision notes. This is genuinely editorial judgment (nobody can derive "this is a sibling-confusion cluster" from frontmatter alone) — keep it in one small sidecar file (e.g. `router.yml`, one row per agent/skill) that a build script joins against the live sweep. When the sweep finds an agent with no sidecar entry, render it in a `Needs routing` group at the top rather than omitting it silently — that's the mechanism that stops the next `ux-designer`-shaped gap from recurring invisibly.

This is an information-architecture decision I'm making now, not deferring: **the router must not be hand-transcribed prose**, or v7 fails the exact same way v6 did, on a longer timer.

### 5.3 Visual system: kept, not redesigned

v6's visual language — the serif/mono pairing, the `--ground/--panel/--ink/--muted/--accent/--signal` token set (with a real, explicit-opt-in dark mode), the `figure`/`table`/`caveat` component vocabulary — is coherent, already reasonably accessible (§6), and not what Justin flagged as wrong ("I'm not sure its *shape* is right" — his word is shape, not look). Per my own step 1: a fresh visual system here would be rework, not a fresh option. New components below extend the existing token set; they don't introduce new colors.

### 5.4 States

- **Empty (zero filter matches).** Never render a blank table. Show: `No routes match "<query>". Try a shorter word, or browse a group below.` and leave the group headers visible but collapsed, so the fallback is "browse," not "dead end."
- **Loading.** N/A — static generated file, no async data at render time. Stated explicitly rather than silently omitted, per the brief for this step: an unclaimed state is a gap, not a non-issue, until it's been ruled out on purpose.
- **Error / flagged.** A generated row whose source frontmatter fails CPO's own sweep (`NAME!=FILENAME`, `DESC>1024`, `NO-MODEL`) renders with a visible flag badge, not omission — this is the one state v6 (and honestly the whole library) has treated as CPO's-problem-only; putting it on the page is what makes a stale roster visible to Justin without his having to run the bash sweep himself.
- **Overflow.** A description near the 1,024-char cap truncates at ~140 chars with a `…` and a native `title=` tooltip carrying the full text (no JS dependency for the full string to exist somewhere) — never a hard clip with no affordance. Diagrams keep v6's `.scroller` horizontal-scroll wrapper for narrow viewports. Below 640px, router table rows collapse to stacked cards (label above value) rather than horizontal scroll, since scanning a lookup table sideways on a phone defeats the whole point of the page.

---

## 6. Accessibility

- **Contrast, computed against v6's actual tokens (not eyeballed):**
  - `--muted` (#5A6A65) on `--ground` (#EBEEEB): **≈4.86:1** — passes AA for normal text (4.5:1) but with very little headroom. This token is used for small mono labels throughout (table headers, meta stats, `t-sub`). **Flag, not blocker:** re-measure once real router content sets final font sizes — if any of these drop below 14px regular / aren't already covered by the 3:1 large-text allowance, the margin here is thin enough that a future dark-token tweak could silently fail it.
  - `--signal` (#9C570F) on `--ground`: **≈4.75:1** — same story, same flag, and it's the color I'm proposing for the new collision-callout border/badge (5.5 below); re-check against the *actual composited* background once the callout's final surface color is set, per this very agent's own step 6 rule about measuring the rendered background, not the swatch.
  - `--accent` (#0E6E5E) on `--ground`: **≈5.27:1** — comfortable, no flag.
  - Dark-mode `--muted` (#91A29C) on `--ground` (#101614): **≈6.85:1** — comfortable, no flag.
  - **Could not verify:** contrast for the generated flag badge and the truncation tooltip, since their final background depends on build-time layout decisions not yet made. Named here so `cody`'s own WCAG pass isn't the first place this surfaces.
- **Focus state — v6 currently defines none at all.** No `:focus`/`:focus-visible` rule exists anywhere in its CSS. This is a real gap, not a style preference, and it's mine to catch before handoff, not `cody`'s to retrofit: add `:focus-visible { outline: 2px solid var(--accent); outline-offset: 2px; border-radius: 2px; }` globally, applied to the new filter input, every `<details>/<summary>` toggle, and all links.
- **Tap targets.** Filter input: `min-height: 44px`, `font-size: 16px` minimum (prevents iOS auto-zoom-on-focus, which would otherwise fight the "quickly" requirement on a phone). `<summary>` toggles and any future filter-chip controls: same 44px minimum with `padding`, not just line-height, to get there.
- **The filter is genuinely operable without a mouse or without JS.** Tab order: label → input → first group heading → first row. `aria-live="polite"` on the result count (`router-count` in the Option A wireframe) so a screen-reader user gets the "3 routes shown" update without it interrupting mid-type. With JavaScript disabled, the input is inert but every row is still present and readable — filtering is acceleration, not the only way to reach the content.
- **Semantic structure.** Router rows as an actual `<table>` (not styled `<div>`s) so a screen reader gets row/column semantics for free; group headers as real `<h3>`s under the section's `<h2>`, not styled paragraphs, so the page's heading outline itself becomes a second, assistive-tech-native way to browse by domain.

---

## 7. Handoff spec (concrete values, for whoever builds this)

New tokens/components, added to v6's existing `:root` block — no new hues introduced:

```css
:focus-visible { outline: 2px solid var(--accent); outline-offset: 2px; border-radius: 2px; }

.router-filter {
  min-height: 44px; font-size: 16px; width: 100%;
  padding: 10px 14px; border: 1px solid var(--rule); border-radius: 4px;
  background: var(--panel); color: var(--ink); font-family: var(--serif);
}
.router-group h3 { /* reuse existing h3 rule as-is */ }
.router-table td { padding: 10px 14px; border-bottom: 1px solid var(--rule); }
.router-table tr[hidden] { display: none; } /* filter hides rows this way, not by removing them */

.router-collision {
  border-left: 3px solid var(--signal); /* --signal, not --accent — visually distinct from a normal caveat */
  padding: 6px 0 6px 16px; font-size: 13.5px; color: var(--muted);
}
.router-flag {
  display: inline-block; font-family: var(--mono); font-size: 10px;
  color: var(--signal); border: 1px solid var(--signal); border-radius: 2px;
  padding: 1px 6px; margin-left: 8px; letter-spacing: 0.06em; text-transform: uppercase;
}

@media (max-width: 640px) {
  .router-table, .router-table tbody, .router-table tr, .router-table td { display: block; width: 100%; }
  .router-table tr { padding: 10px 0; border-bottom: 1px solid var(--rule); }
  .router-table td.who { font-weight: 600; }
}
```

- Filter matching: case-insensitive substring against a row's `data-match` attribute (concatenation of shape-of-work text + trigger phrases + route name), not against visible text alone — lets `"bug"` match the investigator row even though the visible cell says "root cause unknown."
- A group with zero visible rows after filtering hides its own `<h3>`, not just its rows — otherwise the page shows orphaned headings over nothing, which reads as a bug.
- Router content model: generated rows (name/description/model/flag) + one hand-maintained `router.yml` sidecar (group, shape-of-work line, collision note) per §5.2. Ungrouped agents render under a `Needs routing` heading at the top, not omitted.

---

## 8. Score

Bar: does the router let Justin find the right agent for an unlabelled piece of work in one glance-or-keystroke, and does it stop the two-siblings problem this library actually has, without becoming the next thing that goes stale?

**This direction, as specced: 7/10.** A 10 would additionally have the router's `router.yml` sidecar validated at build time against the live frontmatter sweep (so an agent added without a sidecar entry *fails the build* rather than rendering under "Needs routing" — a harder guarantee than the soft fallback specced here), and would have real contrast numbers for the flag badge and tooltip rather than the two flagged-but-unverified cases in §6. Both are build-time concerns cheap to close once someone's actually implementing it, which is why this lands at 7 rather than lower — the IA decision itself (one generated, grouped, filterable router with disambiguation surfaced inline) is the load-bearing call, and I'm confident in it; the two open items are hardening, not direction.

---

## 9. Summary

- **Options presented:** three, differing in interaction model, not just color — (A) filterable flat router table, (B) guided decision tree, (C) domain cards with sibling comparison tables. All three keep v6's existing visual language.
- **Chosen by:** me, as a recommendation — no live user turn was available to pick in this session. Flagged explicitly rather than treated as settled, matching this library's own convention that portfolio-shaped decisions are proposed and signed off, not self-approved.
- **Recommendation:** Option A (filterable router), with Option C's sibling-comparison technique folded in as an inline collision note per group rather than a separate layer.
- **Polish score:** 7/10 against the stated bar (§8); the two gaps are build-time hardening (sidecar validation, two unverified contrast pairs), not direction.
- **Accessibility carried into handoff:** two tight-but-passing contrast pairs flagged for re-check against final surfaces (§6); v6's total absence of a focus state identified and specified (§6, §7); 44px tap targets specified for the new filter and toggles; full non-JS and screen-reader fallback behaviour specified.
- **Amendment-feedback flag (step 8 of my own definition):** not applicable this run — there is no prior version of *this* proposal to have been reworked against; this is the first pass. What I'd flag if it comes back heavily changed: if Justin picks B or C outright, the likely miss on my part is underweighting how much a *personal* tool benefits from the guided/branching feel even when the operator "already knows roughly what he wants" — solo tools are also mood-dependent, and A assumes a user who always arrives with a search term in hand.
