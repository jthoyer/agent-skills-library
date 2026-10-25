# Routing boundaries

Read this when the agent and skill descriptions in context don't settle a route. It holds
only the boundaries descriptions can't express. The roster itself is the live listing.

## Contents

- Agents: which one, and where the lines fall
- Skills: which method for which work
- Common skill stacks
- Things that look like routes but are not

## Agents: which one, and where the lines fall

| Shape of the work | Route to | The boundary |
|---|---|---|
| UI or backend implementation, one pass | `cody` | Self-reviews its own diff. Nothing else checks a standalone dispatch unless the next row applies |
| A standalone `cody` change that touches shared code, live data, auth or tests | `cody`, then `mc-verifier` | `cody` reports its own runs, and those reports have overclaimed. The Verifier runs the work itself against the brief's "done when", with no spec needed. If the Verifier finds a defect, send it back to `cody` and verify again. Once it passes, save the Verifier's verify recipe in the app repo as `mc-orchestrator` Stage 4 does, in the same PR as the change. Still a small job, not the pipeline. If it needs a spec or a code read, climb to `mc-orchestrator` |
| The look and interaction aren't settled | `ux-designer`, then `cody` | It decides the look; `cody` builds it. Sequence, never instead |
| Code where a late defect is expensive | the `mc-orchestrator` skill: `mc-planner` → `cody` → `mc-reviewer` + `mc-verifier` → `mc-integrator` | A conducting skill. It runs in this thread and dispatches each stage |
| A spec that must be persisted and built from | `mc-planner` | Not `Plan`. If nothing downstream reads it, use `Plan` |
| A quick "what's the approach", nothing consumes it | `Plan` | No `Write` tool; the plan lives only in the transcript |
| A live defect, cause unknown | `investigator`, then `cody` | Investigator runs code, cannot edit. No fix without a demonstrated cause |
| Security is the whole ask | `security-auditor`, then `cody` | For a quick inline pass use the `security-review` skill instead. Inside the coding pipeline, dispatch it beside `mc-reviewer` when the change touches auth, payments or member data |
| A reviewed branch to prep for release | `release-engineer` | Asks the user directly before any push or PR. Never merges or deploys |
| Read-only code quality pass, no spec | `code-improver` | Cannot edit |
| Cross-work duplication and errors | `watchdog` | Grades the work, not the agent |
| Reviewing or improving an agent | `agent-improver` | Grades the agent, not the work |
| Broad search where only the conclusion matters | `Explore` | State the breadth |
| Personal planning against Justin's own mandate | the `cos` skill | The subject decides: Justin's week is `cos`; which agent does a job is here |

The user named an agent? Honour it. Flag a mismatch in one sentence only if it lacks the
tools: `code-improver` cannot edit, `mc-reviewer` cannot execute.

**Owed: audit of the first `cody` → `mc-verifier` pair** (the owner asked for it on
2026-10-22). Run it on the first job routed by the row above, standalone or not.
1. Save both briefs and reports to `work-samples/`.
2. Dispatch `agent-improver` on the pair. Ask: did the Verifier find anything `cody`'s
   report missed or overclaimed? What did the extra dispatch cost? Does the rule's
   trigger (shared code, live data, auth, tests) match the job?
3. Log it in `CHANGELOG.md`. It counts toward the rule's reversal condition: no catches
   over five risky jobs (portfolio entry of 2026-10-22).
4. Delete this paragraph in the same PR.

## Skills: which method for which work

| The work is about | Skill |
|---|---|
| Research feeding a strategy, investment or executive decision | `multi-actor-research` |
| Research already held, ask is ranked ideas and a cheap test | `research-to-ideas` (conducts four agents) |
| One product or idea: should we build it, what's the riskiest assumption, design the test | `discovery-loop` (light and weekly; no agents) |
| "What should we do", options appraisal | `multi-actor-strategy` (conducts a blind challenger and jurors) |
| General research, no high-stakes decision riding on it | `deep-research` |
| Academic literature, methodology critique, citations | `academic-researcher` |
| What people are saying now, last 30 days | `recent-pulse` |
| Structuring a recommendation or executive message | `scr-pyramid-communicator` (its short-memo mode, SCQA, for a memo or email) |
| Stakeholder or difficult-conversation prep | `read-the-room` |
| Making a message memorable | `made-to-stick` |
| Writing or editing content | `content-research-writer`, `editor` |
| Anything for Balance Triathlon Club | `balance-tri-club-brand` |
| Product requirements or feature scope | `product-requirement-document` |
| Business case or investment justification | `business-case-builder` |
| Project comms, agendas, updates | `project-management` |
| Problem decomposition, root cause, MECE | `issue-tree` |
| Challenging assumptions | `first-principles` |
| Adversarial critique of a plan or artefact | `red-team` |
| Multi-perspective stress test, or a pre-mortem | `six-thinking-hats` (its Extended Black Hat module is the pre-mortem) |
| Customer motivation, JTBD, value proposition | `customer-insight` (deep JTBD and VPC in its references) |
| Positioning an offering | `positioning` |
| App-market landscape | `market-analyst` |
| Team management, 1:1s, OKRs | `high-output-management` |
| Notion architecture or capture | `notion-second-brain` |
| Training, race prep | `triathlon-coach` |
| ETF investing and tax | `etf-investing-advisor`, `etf-investing-coach` |
| Resume, CV, cover letter | `resume-builder` |
| The skills library itself | `skills-librarian` |

Check the session's skill listing before naming one. A skill on disk but not listed
exists; say so rather than calling it unavailable.

## Common skill stacks

- **Justin-authored content:** `content-research-writer` → `justin-voice` → `humanizer`.
- **High-stakes recommendation:** `multi-actor-strategy` → `scr-pyramid-communicator`. The strategy skill already runs a blind challenger and jurors; add `red-team` only when it ran without agents.
- **Customer understanding and positioning:** `customer-insight` → `positioning`.
- **Should we build it:** `customer-insight` (interviews) → `discovery-loop` → `product-requirement-document`.
- **Club comms:** `content-research-writer` → `balance-tri-club-brand` → `humanizer`.

## Things that look like routes but are not

- Strategy, writing, voice and frameworks are skills, never agents. Wrapping one in an
  agent to feel thorough is the wrong call.
- Never spawn to answer what one tool call answers, to re-read files already in context,
  or to run two agents over the same files toward the same question.
- A built-in agent (`Explore`, `Plan`, `general-purpose`) that does badly is a routing
  miss. Fix this file, not the agent.
- The same agent underperforming twice on the same class of task: suspect the route
  first. Edit this file and record it as a `library — portfolio` entry.
