# Race-day tools service blueprint

- **Source:** the Notion page "Strategy: Race-day tool suite" and its four tool pages (Race Fuel Planner, Race Pacing Planner, Race Countdown, Race Debrief), last edited 26 October 2026. Also the design options canvas, https://claude.ai/artifact/LU5yz9bV3baEKrDteQYkdE, 2 November 2026. Both links are private to the owner. Modelled on `../balance-bolt/` and `../balancetri-app/`.
- **What it shows:** the planned service, from a first search to the next race. There are 9 stages and 7 lanes: Evidence, Athlete, App, Owner, Systems, Measure, Watch for. A Ships-in row says which build brings each stage.
- **Status:** a plan. Nothing is built. All numbers are the strategy's unvalidated assumptions.
- **Not the race calendar.** This is a separate product. It shares the calendar's look and nothing else.

## Keys

Every card has a permanent key, `RD-<stage>-<lane><number>`. For example, `RD-05-A1` is stage 5, lane A (App), card 1. Lanes: E Evidence, T Athlete, A App, O Owner, S Systems, M Measure, W Watch for. Each key is also an anchor, so `index.html#RD-05-A1` opens at that card.

- Never renumber or reuse a key.
- A new card takes the next free number in its stage and lane.
- A removed card's key is retired.
- A new stage takes the next free stage number, wherever it sits.

**Set-up flow keys.** Below the main grid, a second grid zooms into stage 5 (Plan the race): adding details and setting pace targets, one step per screen on the design canvas (F1 to F7). Its keys are `RP-<step>-<lane><number>`, for example `RP-05-A1`. Same lane letters and the same rules. It has no Owner lane.

## Using it

This is the plan and the improvement guide. Once a week (about an hour, from the time budget):

1. Read the Measure lane for every live stage.
2. Pick the one stage furthest from its target.
3. Name the card to change by its key.
4. Make one change. Log it under *Changes* below: date, key, change, expected effect.
5. Next week, check that effect before you pick the next change.

Gates decide what gets built next. Gate 1 (week 11): ~1,000 monthly visitors and ~100 email sign-ups. Gate 2: paid conversion at or above ~3% of tool users. Missing a gate changes the angle before it changes the product.

When a planned card ships, add a line under *Changes* that says the card is live. When a stage's Measure cards have real numbers, record them there too.

## Changing it

Edit `index.html` directly and follow the key rules. It started from a generator, but the HTML is now the source.

## Open decisions

- ~~D1 Design direction~~ Decided 2026-11-02: Option A's race plan, with C's race card as what every step writes to and what prints.
- D2 Restoring a purchase with no accounts.
- D3 Analytics that count without collecting health data.
- D4 Email tool, offline copy, hosting.
- D5 Name, and fit with TRI Momentum.
- D6 The paywall in pace set-up: lock the leg targets only, or the whole step, for a free user.

## History

- 2026-11-02: first version, 108 cards, drawn from the strategy and tool pages and the three design options.
- 2026-11-02: owner chose Option A plus C's race card (D1). Rewrote RD-05-E2 for the race card. Added RD-02-A4 (a guide opens one step on its own; saving it starts a race plan) and RD-02-W3 (A is weakest for guide visitors), so A's weak spot has a card to measure against.
- 2026-11-02: added the set-up flow (RP-01 to RP-07, 74 cards) from the canvas screens F1 to F7. Added RD-05-A4 (points to the flow), RD-05-W3 and decision D6 (paywall). The worked example's finish range is now 5:15–5:30, so the legs add up; the canvas boards that said 5:05–5:25 were corrected to match.

## Changes

None yet. The first entry comes from the first weekly review after Build 1 ships.
