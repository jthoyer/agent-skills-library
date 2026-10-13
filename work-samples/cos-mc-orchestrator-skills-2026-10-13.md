# cos and mc-orchestrator become skills: test evidence, 2026-10-13

Owner-approved as the second PR after the `cpo` redesign. All roles below were
delegated (real dispatches from the main thread).

## CI flag — reproduce, then fix

`scripts/check-frontmatter.sh` gained `AGENT-TOOL`: any agent whose `tools:` line lists
`Agent` or `Task`. On the tree before conversion it flagged exactly `cos` and
`mc-orchestrator`. On a scratch copy with two planted fixtures it flagged `planted-bad`
(`tools: Read, Grep, Task`), passed `planted-ok` (`tools: Read, Grep, Glob`) and exited 1.
After conversion: no flags, exit 0.

## Blind routing gate, 8 requests

| # | Request | Expected | Result |
|---|---|---|---|
| 1 | brief me | `cos` | pass |
| 2 | job hunt or finance review this week? | `cos` | pass (collides with multi-actor-strategy, high-output-management) |
| 3 | build the race calendar properly, go through the stages | `mc-orchestrator` | pass (collided with multi-actor-research — fixed) |
| 4 | should we retire mc-planner? | `cpo` portfolio | pass |
| 5 | which agent should fix my flaky login test? | `cpo` → investigator → cody | pass |
| 6 | switch my ETF provider? | `cos` or an ETF skill | pass (ETF skills tie) |
| 7 | one-line CSS typo | direct | pass |
| 8 | /rewrite run the coding playbook on the Strava fix | rewrite → cpo → mc-orchestrator | pass |

Fixed in this PR: `mc-orchestrator` now adds `security-auditor` for auth, payments or
member data; its trigger says "go through the coding stages"; `cos` sends product decisions
to `multi-actor-strategy` and `product-requirement-document`, not to `cpo`.

Left for an audit (pre-existing): the two ETF skills share triggers; "help me decide" is
claimed by `cos`, `multi-actor-strategy` and `high-output-management`; skill retirement is
named in both `cos` (to `skills-librarian`) and `cpo/references/portfolio.md`.
