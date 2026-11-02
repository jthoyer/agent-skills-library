# ux-designer work sample, 2026-11-02

Task: three mockups to shorten the BalanceTRI-app admin console (a very long scroll). Dispatched from the `cpo` skill after `/rewrite`. Output was a single HTML file plus a short report. The user then asked for the "Needs a look" card in Option A and for the mock to match the app's real style guide. That second request was rework.

## Brief (verbatim, trimmed only of the file listing noise)

Objective: The Balance Tri Club admin console (a static page, no framework, no build step) is one very long scroll. Propose 3 distinct options to make it easier to use, mock each up, and recommend one. Pagination is one candidate, not the only one.

Read first: public/admin.js, public/admin.css and public/styles.css ("existing look ... Reuse its tokens and class names where you can"), public/style-guide.html ("the app's style guide"), public/admin.html.

Constraints: phone width 360px and desktop; plain HTML/CSS/JS only; keep Undo, Restore and account actions reachable; keyboard and screen-reader friendly; FAKE data only; no AI-generated images.

Options: A tabs; B one page with paging, jump bar and collapsed Removed races; C the designer's own best idea.

Deliverable: one self-contained HTML file with all three as interactive mockups (switcher, phone toggle, "colours as CSS variables, include dark-mode-safe backgrounds, no external scripts"), and a reply of at most 350 words with pros, cons, front-end vs server work, size, and one recommendation.

## Output (summary of the report)

Three options delivered and a recommendation (C, "attention first"). The report said: "I read admin.css and the CSS tokens but not admin.js or style-guide.html. The row markup, class names and confirm flow in the mock are my approximations." It also said the dark colours were unmeasured and button wording was invented. It added a "Sign out" button that does not exist on the real page.

## Disk-verified outcome

- The mock rendered with no console errors (checked by the main thread in headless Chromium).
- `grep` of the delivered file: no `@font-face` or Google Fonts link, so DM Sans, Outfit and Inter never loaded. Headings and body fell back to Arial. The brief had named the font family in its own description of the look.
- The file defined a full dark theme under `prefers-color-scheme: dark`. The live app has none (`grep prefers-color-scheme public/*.css` returns nothing). The brief said "include dark-mode-safe backgrounds", which the designer read as "add a dark theme".
- The user's OS was in dark mode, so the first thing they saw was a dark card that does not exist in the product. They asked: "ensure the design is the same style guide as current version".
- Buttons were bordered 44px controls; the live app uses borderless grey `.secondary-button` and 36px `.admin-small-button`. The sign-up chart, stat tiles and diff list styling also differed from `admin.css`.
- Rework: the main thread rewrote the CSS block against `styles.css` and `admin.css` literals and added the font link, by patch script; a screenshot confirmed it stayed light under a dark OS setting.

## Gap in one sentence

The designer produced mockups for a live product without reading the product's own style guide or loading its fonts, and the brief's "dark-mode-safe" wording let it invent a dark theme the product does not have.
