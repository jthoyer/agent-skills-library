
# Spec: empty state for the races list — BalanceTRI-app

Author: UX design pass, 2026-09-13. Repo checked read-only at `/home/user/balancetri-app/` (current `main`).

---

## 1. What's actually there today (grounding)

Read directly from the repo, not from the brief's summary of it:

- **Markup** — `index.html:47`: `<p class="empty-state hidden" id="emptyState">No races here yet. Add a race or switch back to all races.</p>`. It's a plain paragraph, no icon, no button, no `aria-live`. This static string is only ever seen for an instant (or if JS fails) — `app.js` overwrites `textContent` on every `render()`.
- **Styling** — `styles.css:1`: `.empty-state{padding:34px;border:1px dashed #cbd1da;border-radius:9px;background:#fff;color:var(--muted);text-align:center}`. Dashed box, muted grey text, centered. No hover/focus states exist because there's nothing interactive in it today.
- **Logic** — `app.js:125`, inside `render()`. The message is built with an if/else chain across three independent filters:
  - `state.filter` — free-text athlete-name search (`#athleteFilter`)
  - `state.eventTypeFilter` — the event-type `<select>` (`#eventTypeFilter`, includes "Balance Bolt")
  - `state.viewFilter` — the club/all toggle (`.view-toggle-btn`, hero section, defaults to `'club'`)

  Current copy (this is the 2026-09-11 commit's work):
  | Condition | Message |
  |---|---|
  | `query` set | `No races found for "{query}". Try another name.` |
  | club view + type set | `No upcoming club races match "{type}". Try "All types" or "View all".` |
  | club view, no type | `No upcoming club-focussed races yet. Try "View all" to see every event.` |
  | all view + type set | `No upcoming races match "{type}". Try "All types".` |
  | all view, no type | `No races here yet. Add a race to get started.` |
  | Supabase fetch fails | `Could not reach the Supabase backend. Check your connection and try refreshing.` (same box, same style) |

  **Gap confirmed by reading the code, not assumed**: `query` is checked first and short-circuits everything else. If a user has an event-type filter *and* a name search both narrowing to zero, the message only ever mentions the name search — the type filter is silently dropped from the sentence. The 2026-09-11 commit named *a* blocking filter, not necessarily *all* of them.

  **Also confirmed**: the message only ever *names* the filter. There is no button, link, or click target in the empty state itself that clears it — the user has to scroll back up to the toolbar/hero and operate the control themselves. That's the actual design gap this task is asking me to close.

  **Pre-existing bug, adjacent but not mine to fix here**: `app.js:11` — `state.viewFilter = 'club';` runs unconditionally on every load, overwriting whatever was persisted. `state.eventTypeFilter` and `state.filter` *do* restore from `localStorage` (line 9-10 use `||=`), but `viewFilter` never does. Flagging this now because my spec below adds a one-click "clear club focus" action — that action will visibly work in-session but **will not survive a page reload** until this line is fixed. Cody should know this isn't a regression introduced by the empty-state change.

- **Existing pill/badge vocabulary** (`styles-additions.css:23-25`, referenced in the brief):
  - `.club-focus-badge` — pill, `background:var(--yellow)`, `color:var(--ink)`, `border-radius:999px`, `font:700 11px`, uppercase, on race cards.
  - `.event-type-badge` — pill, `background:var(--navy-bg)`, `color:var(--ink)`, same shape/weight. (This is the one the 09-11 commit repainted from brand-blue to ink-on-navy to match the club badge.)
  - Separately, `.choice` / `.choice.selected` (`styles.css:1`) is the app's existing **interactive** pill: `border-radius:999px`, `min-height:44px`, `cursor:pointer`; selected state is `border-color:#92a4c6;background:var(--navy-bg);color:var(--ink)`.
  - Tap-target convention: `.text-button`, `.icon-button`, and `.choice` are all explicitly `min-height:44px`. This is a convention already chosen by this codebase, not something I'm importing.
  - Focus convention: `button:focus-visible,a:focus-visible,input:focus-visible{outline:3px solid #285ba8;outline-offset:3px}` — global, already applies to any real `<button>`.
  - No error/danger color token exists in `:root`. The only red in the codebase is ad hoc, on `.roster-remove:hover` (`color:#b3261e;background:#fdecec;border-color:#e3a3a3`). No loading-state pattern exists anywhere in the app.

No `STYLEGUIDE.md` or design-system doc exists in this repo — confirmed by attempting to read one. The de facto style guide is the CSS itself, which is what I matched against above rather than inventing new tokens.

---

## 2. What the field has converged on (checked, not recited from memory)

Ran a search rather than relying on stale training knowledge for this. Current guidance (shadcn/ui empty-state blocks, Cloudscape Design System's empty-state pattern, Pencil & Paper's empty-state UX writeup) converges on the same two points for a **filtered-to-zero** list specifically:

1. Name the specific filter(s) causing the miss, not a generic "No data" — "a user who can see which chip to drop recovers in one click."
2. Give a one-click recovery path *in the empty state itself* — visible filter chips/badges the user can dismiss directly, plus a "clear all" fallback for when more than one filter is stacked.

That second point is exactly the affordance missing from the current implementation: the 2026-09-11 commit did point (1) but not point (2). My recommendation below is the natural next increment, not a reinvention.

Sources: [Clear Filters Suggestion — shadcn.io](https://www.shadcn.io/examples/empty-clear-filters-suggestion), [No Filter Results — shadcn.io](https://www.shadcn.io/examples/empty-no-filter-results), [Empty states — Cloudscape Design System](https://cloudscape.design/patterns/general/empty-states/), [Empty State UX Examples & Best Practices — Pencil & Paper](https://www.pencilandpaper.io/articles/empty-states)

---

## 3. Three options (wireframe-level)

### Option 1 — Inline actionable chips (evolve the existing box)

```html
<div class="empty-state" role="status">
  <p>No upcoming club races match:</p>
  <div class="chips">
    <button aria-label="Clear event type filter: Triathlon">Type: Triathlon <span aria-hidden="true">×</span></button>
    <button aria-label="Clear club focus filter">Club focus <span aria-hidden="true">×</span></button>
  </div>
</div>
```
Same dashed box, same footprint as today. The sentence stays a plain sentence; the filter values become real buttons instead of quoted text.

*Rationale:* smallest possible change from what's shipped — it finishes the sentence the 09-11 commit started, by making the named filter clickable instead of just readable.
*Trade-off:* low visual weight; a user skimming fast may not immediately register the pill-shaped text as clickable rather than another `.event-type-badge` label.

### Option 2 — Icon + heading + description + single CTA (card style)

```html
<div class="empty-state-card">
  <svg class="icon" aria-hidden="true">…calendar/search glyph…</svg>
  <h3>No races match your filters</h3>
  <p>Event type "Triathlon" and Club focus are hiding every upcoming race.</p>
  <button class="primary-button">Clear all filters</button>
</div>
```
*Rationale:* matches the warmer, larger-type voice used in the hero ("Find your next start line."); one unambiguous action.
*Trade-off:* bigger footprint (new heading level, new icon asset that doesn't exist anywhere else in this app's inline-SVG set), and collapsing to a single "Clear all filters" button actually **undoes** the precision of the 09-11 commit — the user can no longer tell or choose which one filter was the actual culprit when only one is active.

### Option 3 — Persistent filter-chip row above the list (systemic)

```html
<div class="active-filters" aria-label="Active filters">
  <button>Type: Triathlon ×</button>
  <button>Club focus ×</button>
</div>
<!-- list or empty-state renders below, always -->
<div class="empty-state"><p>0 races match. Remove a filter above to see more.</p></div>
```
*Rationale:* chips live above the toolbar/list at all times (shown or not-shown state), so clearing a filter never requires reaching an empty state at all — this is the shadcn/ui faceted-filter pattern cited above, and probably the best long-term answer.
*Trade-off:* this redesigns the filter toolbar, not just the empty state — bigger diff, touches `.toolbar` layout and the dropdown/toggle relationship, and raises new questions (chip row visible even with 40 races shown? Where does it sit relative to the `<select>` and search box?) that are outside this task's scope.

---

## 4. Recommendation

**Option 1**, chosen by me (no user review loop on this pass — flagging that per step 4, so if this is countermanded, it's a genuine directional disagreement worth noting, not a routine revision).

Reasoning: this app has no other icon-and-heading empty/zero state anywhere — every existing surface (race cards, badges, toolbar) is dense and utilitarian; the hero section is the one deliberately friendly zone and it's structurally separate from the results area. Option 2 is the right call *only* for the true first-run case (see §5, State 1) where I've folded its friendliness in on a smaller scale. Option 3 is real and worth doing later — noting it as a explicit "not now" rather than silently dropping it — but it's a toolbar redesign wearing an empty-state costume, and would touch files/areas beyond what was asked.

---

## 5. Polish: states, hierarchy, copy

**Bar for a 10/10 here:** every combination of active filters is named and independently clearable in one click without leaving the page; true-empty, filtered-empty, search-no-match, and connection-error are visually distinct so an error never reads as "you just have no races"; every new interactive element meets this app's own 44px tap-target and focus-visible conventions with zero new contrast risk.

**Where this lands: 8.5/10.** It hits every functional and accessibility mark above and fixes a real combinatorial bug in the current copy logic, using only colors/spacing already proven in this exact codebase (no new tokens invented). It's not a 10 because (a) I could only verify contrast by hand-computing token values, not by rendering in a browser — see §7 — and (b) it deliberately leaves the pre-existing missing-loading-state gap as a noted "nice to have" rather than fixing it, since it's outside what was asked.

### State 1 — True empty (no upcoming races at all, independent of filters)

Trigger: `futureRaces.length === 0` (i.e., zero races with `date >= today` in the whole dataset — check this *before* applying `eventTypeFilter`/`viewFilter`/`query`, so a genuinely-empty calendar isn't reported as "adjust your filters").

```html
<div class="empty-state" id="emptyState" role="status">
  <p class="empty-state-message is-first-run">No races on the calendar yet.</p>
  <div class="empty-state-actions">
    <button type="button" class="primary-button" id="emptyStateAddButton">Add a race <span>+</span></button>
  </div>
</div>
```
- `#emptyStateAddButton` wired to the exact same behaviour as `#heroAddButton`: `toggleAdd(true)` then scroll `#addPanel` into view. Don't write a second implementation — call the same handler.
- `.empty-state-message.is-first-run{color:var(--ink);font-weight:700;font-size:17px}` — only variant that gets ink/bold instead of muted, since this is the one case with real stakes (a brand-new club with literally nothing on the calendar) and it earns a little more presence, per Option 2's instinct, without adopting Option 2's full icon+heading structure.

### State 2 — Filtered to zero (the common case)

Trigger: `futureRaces.length > 0 && shown.length === 0`.

```html
<div class="empty-state" id="emptyState" role="status">
  <p class="empty-state-message" id="emptyStateMessage">No upcoming races match "Triathlon".</p>
  <div class="empty-state-chips" id="emptyStateChips">
    <button type="button" class="choice selected filter-chip" aria-label="Clear event type filter: Triathlon">Type: Triathlon <span class="chip-x" aria-hidden="true">×</span></button>
    <button type="button" class="choice selected filter-chip" aria-label="Clear club focus filter">Club focus <span class="chip-x" aria-hidden="true">×</span></button>
  </div>
  <div class="empty-state-actions" id="emptyStateActions">
    <button type="button" class="text-button" id="clearAllFiltersButton">Clear all filters</button>
  </div>
</div>
```

Copy — generated, not eight hardcoded strings (fixes the combinatorial bug at the root):

```js
function emptyStateSentence({hasQuery, query, hasType, type, isClub}) {
  const scope = isClub ? 'club ' : '';
  if (hasQuery && hasType) return `No ${scope}races found for "${query}" matching "${type}".`;
  if (hasQuery)            return `No ${scope}races found for "${query}".`;
  if (hasType)              return `No upcoming ${scope}races match "${type}".`;
  return 'No upcoming club-focussed races yet.'; // isClub only, no other filter active
}
```

Chip rules:
- One chip per *active* filter: query, eventType, and club-view — all three, independently, every time they're active. This is the actual fix — previously `query` silently swallowed the other two.
- Chip label text carries the filter's identity (`Type:`, `Club focus`, or the bare quoted name for search) — never rely on background color alone to distinguish which chip is which (WCAG 1.4.1, use-of-color).
- `#clearAllFiltersButton` only renders when **2 or more** chips are active. With exactly one chip, the chip itself is the "clear all" — don't show a redundant second control.
- Each chip's `onclick` mutates exactly one `state` field (`state.filter=''`, `state.eventTypeFilter=''`, or `state.viewFilter='all'`) then calls the existing `persist(); render();` pair — identical pattern to the current `.view-toggle-btn.onclick` and `#eventTypeFilter.onchange` handlers at `app.js:130-131`. `render()` already re-syncs `#athleteFilter.value` and `#eventTypeFilter.value` from `state` (`app.js:125`) and already re-toggles `.view-toggle-btn.selected` (`app.js:119`) — no new sync code needed anywhere else.
- `#clearAllFiltersButton.onclick` sets `state.filter=''; state.eventTypeFilter=''; state.viewFilter='all';` then `persist(); render();`.
- Long values: truncate chip label text at ~24 characters with an ellipsis and put the full value in the button's `title` attribute — I could not test this against real Supabase content (see §7), so this is a defensive rule, not an observed bug.

CSS — add to `styles-additions.css`, reusing existing classes/tokens, nothing new invented:
```css
.filter-chip{display:inline-flex;align-items:center;gap:6px}
.filter-chip:hover{background:#e2e9f8}
.filter-chip .chip-x{font-weight:700}
.empty-state-chips{display:flex;flex-wrap:wrap;justify-content:center;gap:8px;margin:14px 0 0}
.empty-state-actions{margin-top:12px}
.empty-state-message.is-first-run{color:var(--ink);font-weight:700;font-size:17px}
```
Because `.filter-chip` is applied alongside the existing `choice selected` classes, it inherits: `min-height:44px` (existing tap-target convention), `border-radius:999px`, `border-color:#92a4c6`, `background:var(--navy-bg)`, `color:var(--ink)`, `cursor:pointer`, and the global `button:focus-visible` outline — zero new color tokens, zero new focus CSS.

### State 3 — Connection error

Trigger: `loadError === 'fetch-failed'`. Currently rendered in the *identical* neutral dashed box as "no results" — an outage looks exactly like "you just have zero races," which is the kind of state-conflation step 5 exists to catch.

```html
<div class="empty-state is-error" id="emptyState" role="alert">
  <p class="empty-state-message">Could not reach the Supabase backend. Check your connection and try again.</p>
  <div class="empty-state-actions">
    <button type="button" class="secondary-button" id="emptyStateRetryButton">Try again</button>
  </div>
</div>
```
```css
.empty-state.is-error{background:#fdecec;border-color:#e3a3a3;color:#b3261e}
.empty-state.is-error .empty-state-message{color:#b3261e}
```
Reuses the app's *only* existing red palette (`.roster-remove:hover`'s `#b3261e`/`#fdecec`/`#e3a3a3`) rather than inventing a new error token. `role="status"` becomes `role="alert"` for this variant specifically, since a failed fetch is the one case that should interrupt rather than politely wait (`alert` is assertive; `status` is polite). `#emptyStateRetryButton.onclick = () => loadRaces()` — plain retry, deliberately does **not** reset `state.viewFilter` the way `#resetButton` does, since a connection failure isn't a reason to also silently change what the user was looking at.

### State 4 — Loading (noted, not required by this task)

Not asked for, but worth surfacing since I went looking for it: there is currently **no loading state at all**. Between the `loadRaces()` call at the bottom of `app.js` and its resolution, the page shows hero + toolbar + nothing — no spinner, no message, `#emptyState` stays `hidden`. On a slow connection this is indistinguishable from "broken." Minimal fix, same component family, no new visual language: `<div class="empty-state is-loading" role="status"><p>Loading races…</p></div>`, no border (`.empty-state.is-loading{border-style:none}`), no chips, no button. Flagging this as an explicit gap rather than silently fixing it, since it's adjacent to but outside "the races list empty state" as scoped.

### Mobile

At the existing `max-width:700px` breakpoint, reduce `.empty-state` padding from `34px` to `24px` (matches the existing pattern of `.add-panel{padding:22px 18px}` at the same breakpoint). Chips already wrap via `flex-wrap:wrap`; no further changes needed. Nothing here needs the `390px` breakpoint — chip button height/padding is already fine at that width since it inherits `.choice`'s existing mobile-tested sizing.

---

## 6. Full build spec (for `cody`)

**Files touched:**
- `index.html` — replace the `<p id="emptyState">` line with a `<div id="emptyState" role="status">` shell (children are populated by JS each render, same pattern already used for `#raceList`). Static fallback text (visible only before JS attaches or if JS fails): `No races on the calendar yet.`
- `styles-additions.css` — add the rules in §5 (`.filter-chip`, `.empty-state-chips`, `.empty-state-actions`, `.empty-state-message.is-first-run`, `.empty-state.is-error`, `.empty-state.is-loading` and its `max-width:700px` padding override).
- `app.js` — in `render()` (currently `app.js:125`), replace the single `$('#emptyState').textContent=...` line with a function that: (1) picks the state (first-run / filtered-zero / error — error is already checked earlier at `app.js:122` and returns early, so only first-run vs filtered-zero need branching here), (2) builds the sentence via `emptyStateSentence()` (§5), (3) builds the chip list and wires each chip's `onclick`, (4) conditionally appends `#clearAllFiltersButton` when `chips.length > 1`, (5) toggles `.hidden` exactly as today (`shown.length>0` / `futureRaces.length>0`).
- No changes needed to `saveEntry`, `addRace`, `makeDetails`, or anything below the race-card level — this task is scoped to the list-level empty state only.

**Interaction model:** every new control is a plain `<button type="button">` mutating one or more `state.*` fields, then calling the existing `persist(); render();` pair — identical to every other filter control already in this file (`app.js:130-131`). No new state shape, no new render path, no new event-delegation pattern. This was a deliberate choice: cody shouldn't need to introduce architecture this codebase doesn't already have.

---

## 7. What I could not verify

- **Contrast**, computed by hand from the CSS custom-property hex values, not measured in a rendered browser: `--muted` (#566177) on white ≈ 6.22:1; `--ink` (#182542) on `--navy-bg` (#eef2fb) ≈ 13.55:1; `--ink` on `--yellow` (#f8c44f) ≈ 9.41:1; the reused error pair `#b3261e` on `#fdecec` ≈ 5.72:1; the global focus ring `#285ba8` on white ≈ 6.66:1. All comfortably clear WCAG AA (4.5:1 text, 3:1 UI components), but I'd want cody's own automated check (axe / DevTools) to confirm at actual render time, especially around the 999px-radius chip edges where anti-aliasing isn't something I can hand-calculate.
- **Long filter values**: the README documents `event_type` as free text for an "Other" case. I could not query live Supabase data to see how long real values get, so the 24-character chip-truncation rule in §5 is a defensive default, not a measured one.
- **The `state.viewFilter` reset bug** (`app.js:11`) — confirmed by reading the code, but I have not run the app to confirm there isn't some other code path that saves it back correctly; flagging it as "as read," not as fully verified end-to-end behavior.
- I did not check whether any other page/screen in this app (outside `index.html`) also renders `#emptyState` or reuses `.empty-state` — only one HTML file was found in this checkout, so I'm assuming this is the only surface, but I did not have a way to list/search the full repo tree beyond direct file reads.

---

## Summary

- **Options presented:** 3 (§3) — inline actionable chips on the existing box; icon+heading+CTA card; persistent filter-chip row above the toolbar (systemic).
- **Direction chosen:** Option 1, by me, on the reasoning in §4 (matches this app's existing density, completes rather than replaces the 2026-09-11 copy commit, smallest diff for a no-build-step codebase). No user review round happened before this handoff — flagging that explicitly, since a countermand on this pick would be a real directional disagreement worth an `agent-improver` look, not routine revision.
- **Polish score:** 8.5/10 against the bar stated in §5.
- **Accessibility notes carried into handoff:** contrast ratios listed in §7 (all pass AA), 44px tap targets on every new control (reusing this app's own existing `.choice`/`.text-button` convention, nothing new invented), focus states free via the existing global `button:focus-visible` rule, `role="status"`/`role="alert"` added to give screen-reader users an announcement that doesn't exist today, color never used as the only signal for which chip is which.
- **Amendment-feedback flag:** not applicable yet — this is a first pass with no prior mock to compare against. If the direction gets reworked substantially once reviewed, that's the signal to loop back into `agent-improver`, not this handoff.
