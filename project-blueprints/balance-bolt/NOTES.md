# Balance Bolt service blueprint

- **Source:** built from the Balance Bolt README on `main` ([jthoyer/BalanceBolt](https://github.com/jthoyer/BalanceBolt)), 22 October 2026. Modelled on `../balancetri-app/`.
- **What it shows:** a race from set-up to series standings. There are 8 stages and 6 lanes: Evidence, Racer, App, Timer, Systems, Watch for.

## Keys

Every card has a permanent key, `BB-<stage>-<lane><number>`. For example, `BB-04-A2` is stage 4, lane A (App), card 2. Lanes: E Evidence, R Racer, A App, C Timer, S Systems, W Watch for. Each key is also an anchor, so `index.html#BB-04-A2` opens at that card.

- Never renumber or reuse a key.
- A new card takes the next free number in its stage and lane.
- A removed card's key is retired.

## Changing it

Edit `index.html` directly and follow the key rules. When the app changes, update the matching cards and add a line below.

## History

- 2026-10-22: first version, 95 cards. Drawn from the README only; not yet checked against the code.
