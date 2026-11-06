# Race-day blueprint: latest build screenshots (2026-11-06)

Work sample from a `/rewrite` → `cpo` run. No agent ran: the work was done directly (embodied, rung 1).

## Brief

"update https://claude.ai/artifact/Nb8ouNL2t6EYt8T5W8wa5n#strategy with latest build screenshots"

- Done when: the `#strategy` section shows current screenshots and the rest of the page is unchanged.
- Stakes: routine. The artifact is private.

## What happened

- The artifact is the blueprint for the race-day tool suite. BalanceBolt is a different product, so its screenshots were not used.
- The suite's build is `jthoyer/race-day-tools`. It was cloned read-only at commit `8ba9825` (the merge of its pull request 23).
- `node scripts/smoke.mjs` ran with `SHOTS` set. The smoke test passed. It walks the app in Chromium at 390 px wide.
- Four screens were kept: first screen, fuel step, race card, top-tube print card. Fuel and print are cropped. The pace targets screen was dropped because the floating step bar covers a row in a full-page capture.
- A "Latest build" block went inside Build strategy, and the lede no longer says "Nothing is built yet".

## Files

| File | Screen |
|---|---|
| `race-day-blueprint-screenshots-2026-11-06/home.webp` | First screen (blueprint A1) |
| `race-day-blueprint-screenshots-2026-11-06/fuel.webp` | Fuel step, top 1360 px (A2) |
| `race-day-blueprint-screenshots-2026-11-06/card.webp` | Race card (C1) |
| `race-day-blueprint-screenshots-2026-11-06/print.webp` | Top-tube card (RD-07-A2) |

All screens use made-up data (Spring 70.3). Every pacing and fuelling range in the app is still marked unchecked.

## Open

- The Journey view of the artifact still says "nothing is built yet".
- Reviews skipped: `watchdog` (private, routine page) and `agent-improver` (no agent ran).
