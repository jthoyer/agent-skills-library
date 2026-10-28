# ux-designer — 2026-10-28

Run: `cpo` (/rewrite), rung 3, `ux-designer` delegated for a design direction. Owner ask: "update https://races.balancetriclub.com.au/guides/#part-1-racers /design into sections to make reviewing the long page as easy as possible. provide three options before implementing". Outcome: owner picked "A, then B later"; main thread ported A into balancetriclub/BalanceTRI-app#133.

## Brief (abridged to the parts that steer)

> Design three distinct options for breaking a long how-to guide page into sections. Mock each one. Do NOT edit the live file and do NOT pick a winner for implementation.
> Live source: /home/user/BalanceTRI-app/public/guides/index.html (≈1,018 lines, static HTML, inline style, no build). 8 phone screenshots. Sticky side nav at ≥1000px only.
> Objective: a reader (mostly on a phone) finds their part and step fast; an owner can review section by section.
> Out of scope: rewriting text, framework, build step. Keep anchor ids other pages link to.
> Accessibility: WCAG 2.2 AA, keyboard and screen reader, works without JS, respects reduced motion.
> Deliver: three options that differ in kind; standalone HTML mock-ups in the scratchpad; a ≤450-word report with per-option costs (JS, deep links, print, Ctrl+F, effort), a risk, and a recommendation.

## Output (summary)

Three mock-ups, all different in kind: A contents list plus cards (no JS), B native `<details>` per step, C one section at a time with a pager. Report within budget, costs listed per option, recommendation A. It said plainly it had not opened the files in a browser.

## What the main thread found

| Check | Result |
|---|---|
| Rendered in Playwright (390px, 1280px) | No console errors in any option. All three looked as described |
| Words, ids, srcs, existing hrefs in A vs live | Unchanged (scripted diff) |
| A's `<head>` | Dropped `meta description` and `link rel=canonical`. Restored by hand |
| A's CSS | Moved `scroll-behavior: smooth` from desktop-only to all widths. On a phone, lazy screenshots loading during the smooth scroll made a deep link land 180px short. Fixed by restoring desktop-only |
| C | Section 1 of 14 has no heading (the intro), which reads oddly |
| `watchdog` on the port | Five findings, all real: part banners vanish in print (white on no background); 13 step sections each became a named region landmark (5 → 19 landmarks); the pages table sat under the Contents heading; pill focus ring 2.3:1 over the dark banner; some dead CSS |

Four of the five `watchdog` findings were in the mock's CSS and markup, not in the port. The agent could not run a browser (no Bash), so render-dependent defects (print, scroll timing) were invisible to it.
