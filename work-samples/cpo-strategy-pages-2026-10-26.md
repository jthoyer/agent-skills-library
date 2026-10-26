# Strategy pages for the six backlog products (2026-10-26)

Evidence for the CHANGELOG entry of the same date. The pages live in Notion, not in this repo.

## The brief (owner, verbatim, via `/rewrite`)

> for each product in the backlog
> write a strategy page - serving as the north star
> use previous sessions to inform
> where questions exist - ask
> add to https://app.notion.com/p/jthoyer/3b9cfee1ca1880c1af40eb8674cb7dc9?v=3b9cfee1ca1880958cfb000c1e9d2fdd
> use the attached for reference questions
> write each separate product with a different page - the strategic intent should be higher level than the delivery specifics

The attachment was an image, "The 2026 AI-Era PRD Template": 1 Decision this records, 2 Opportunity framing, 3 Prototype, 4 Features and behaviour contract, 5 Success measurement and evals, 6 Scope and non-goals, 7 Rollout and rollback, 8 Release criteria and change log. Its golden standard: hand the page to an agent with no other context.

## Route

`cpo` rung 1, written directly in the main thread. One `AskUserQuestion` round of four questions. Owner answers:

| Question | Answer |
|---|---|
| Placement | One row per product, Key `<PREFIX>-000`, Priority P0, Status blank |
| Tri Momentum's north star | Personal tool first. The commercial plan becomes a later option |
| Club apps (BalanceTRI-app, Balance Bolt) | Owner keeps owning them, with no handover |
| Strategy fit | All four: career proof for lead roles, the club and community, own training and learning, building with AI agents |

## Output

Six rows in Product backlog-db, each with the eight template sections lifted to strategy level: the bet, the opportunity, what exists, guardrails plus decision tests, measures, scope, rollout and stop rules, and done-for-horizon plus change log. Each also has open questions and sources.

| Key | Page |
|---|---|
| BB-000 | https://app.notion.com/p/405cfee1ca188133a75bdd298c6d03e3 |
| BT-000 | https://app.notion.com/p/405cfee1ca18810faf18ce6fa55ada13 |
| TM-000 | https://app.notion.com/p/405cfee1ca18812aa307fc653b5e403e |
| CF-000 | https://app.notion.com/p/405cfee1ca1881bc9c33ce3ea641157d |
| ASL-000 | https://app.notion.com/p/405cfee1ca18811ab15bdd533ea3b265 |
| PM-000 | https://app.notion.com/p/405cfee1ca18818d8237ede5c4a73639 |

## Independent check (`general-purpose` playing `watchdog`, read only)

`watchdog` itself has no Notion tools, so it could not read the pages. A `general-purpose` agent ran the watchdog brief instead. Verdict: five PASS WITH FIXES, PM 2.0 PASS. Most figures were confirmed: 18 agents, 39 skills, 96 and 97 blueprint cards, 162 against 3, 41 races, 825 rows and 92%, 147 of 705, 24 drifted copies, 161 checks, 48 decisions.

Findings, each verified on disk before fixing:

| Page | Finding | Fixed to |
|---|---|---|
| ASL | The `content-writing` result was backwards ("lost 0 of 3"). `.claude/skills/CHANGELOG.md` says it lost 3 of 3, and 2 of 3 to no skill | Corrected. The ASL-043 row title has the same error; left for the owner |
| ASL | The stop rule said "retire", but `portfolio.md` needs a written case and the owner's yes | Now "becomes a retirement candidate" |
| BT | "An open P0 blocks features" contradicted practice (BT-032 open while features shipped) | Now applies from 26 Oct 2026, stated as new |
| BT | "Never show a child's name" had no source; members see full names | Now proposed, with an open question |
| BB | "Every prize ranks the gap": ad hoc prizes don't | Narrowed to automatic prizes |
| BB | "Wave winners" prize: not in the README or code | Real prize list used |
| BB | Race control is `boltresults.html`, not `admin.html` | Link fixed |
| BB | "Plus browser checks": no committed script | Dropped |
| CF | CF-010 regrouping was deferred, not needed | Corrected |
| TM | The race calendar is decision 22, not 28 | Corrected |
| TM | The Strava decision test contradicted open question 2 | Marked pending |
| TM | Check-in time is not measured | Marked proposed, with a hand-timing method |
| BT/TM | Overlapping race calendars | Open question added to BT |
| PM | 147 classified includes the set-up run | Reworded |
| All | Rollout and stop rules had no source | Section 7 marked "(proposed)" on all six |
| All | P0 priority inflates open-P0 counts | Kept: the owner chose it. Raised in the reply |

Also fixed: Notion auto-linked "CLAUDE.md" as `http://CLAUDE.md` on three pages. Those are now code spans.

Outside the brief: the "All products links and descriptions" page (GEN-001) holds a live Telegram bot token in plain text. Raised with the owner; the value is not copied here.
