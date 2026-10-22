# BalanceTRI-app service blueprint

- **Source:** claude.ai artifact "Race App Service Blueprint", https://claude.ai/artifact/HkJDNFXaE8S12FCfe7Ng1U (version 3). That link is private to the owner.
- **Date:** 22 October 2026, after the owner-only commitments migrations went live.
- **What it shows:** a member's path from a first visit to a posted race result. There are 10 stages and 6 lanes: Evidence, Member, App, Club admin, Systems, Watch for. Each step is grounded in the app's README, guide and code on `main` that day.

## Keys

Every card has a permanent key, `RB-<stage>-<lane><number>`. For example, `RB-06-A2` is stage 6, lane A (App), card 2. Stages are `RB-01` to `RB-10`. The lane letters are:

- E Evidence
- M Member
- A App
- C Club admin
- S Systems
- W Watch for

Each key is also an anchor, so `index.html#RB-06-A2` opens at that card.

- Never renumber or reuse a key.
- A new card takes the next free number in its stage and lane.
- A removed card's key is retired.
- A new stage takes the next free stage number, wherever it sits.

## Changing it

The page is generated: every card is a `<p class="card">` with its key in the `id`. For a small change, edit `index.html` directly and follow the key rules above. When the app changes, update the matching cards and add a line here.

## History

- 2026-10-22: first version, 97 cards. It fits end to end on a wide screen and scrolls sideways below about 1,200px.
