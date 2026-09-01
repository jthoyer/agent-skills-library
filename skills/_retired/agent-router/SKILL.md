---
name: agent-router
description: >
  Reviews an incoming prompt, decides which agent should handle it — or that none should — and
  dispatches with a self-contained brief. Use whenever work is about to start and no executor has
  been named, especially coding, code review, research, and codebase-search tasks where a
  specialist agent beats a generic pass. Trigger on: "route this", "which agent should do this",
  "pick the right agent", "load the appropriate agent", "use the best agent", "should this go to a
  subagent", "delegate this", or any task handed over without an executor named. Also use before
  starting non-trivial coding work to choose between an inline pass, cody, and the mc-* pipeline.
  Enumerates agents live rather than trusting a remembered list, matches on frontmatter name
  (filenames diverge), and defaults to no agent whenever an inline pass would do the same job
  cheaper. Closes every dispatch by offering an agent-improver review of the agent that just ran,
  handing over the brief and the output as the work sample.
metadata:
  version: 1.1.0
  retired: 2026-08-15
---

> **RETIRED 2026-08-15 — superseded by the `prody` agent.** Moved here from
> `~/.claude/skills/agent-router/` so it no longer appears in skill discovery; content below is
> unchanged and the move is reversible with a single `mv`. Its routing method (live inventory,
> escalation ladder, brief mechanics, agent-improver close-out) has been merged into
> `~/.claude/agents/prody.md` — **read that instead.** The one capability not carried over:
> this skill auto-triggered on description match, whereas prody must be explicitly launched.

# Agent Router

Decide who does the work: this session, one specialist agent, or a multi-actor pipeline. Then
dispatch with a brief that survives a cold start.

Spawning is normally opt-in — the harness tells the main session not to spawn agents unless asked.
**Invoking this skill is that ask.** Routing to "no agent" is still a valid, common outcome.

---

## 1. Inventory before routing

Never route against a remembered list. The agent library changes; frontmatter `name:` and filename
diverge (`orchestrator.md` declares `mar-orchestrator`, `researcher.md` declares `mar-researcher`).
**The `name:` field is the address — a filename will not dispatch.**

```bash
for d in ~/.claude/agents .claude/agents; do
  [ -d "$d" ] || continue
  grep -h -m1 '^name:' "$d"/*.md 2>/dev/null | sed 's/^name: *//'
done | sort -u
```

Guard the directory with `[ -d ]` rather than globbing directly — under zsh an unmatched glob
aborts the whole command, and the project-level `.claude/agents` usually does not exist.

Cross-check against the agent types listed in context — plugin and built-in agents (`Explore`,
`Plan`, `general-purpose`) never appear on disk.

---

## 2. Classify the prompt

Assess silently, then route. Four dimensions decide everything:

| Dimension | Question | Why it changes the route |
|---|---|---|
| **Verb** | Build, review, verify, search, plan, research, advise? | Maps directly to the table below |
| **Blast radius** | Shared code, merged work, external audience — or a scratch edit? | Drives the escalation ladder |
| **Context cost** | Would this dump hundreds of lines into the transcript for one answer? | Fan-out search is the strongest case for delegating |
| **Reversibility** | How expensive is a defect found later? | Cheap to fix → inline. Expensive → pipeline |

---

## 3. Routing table

| Prompt is about... | Route to |
|---|---|
| UI or frontend implementation (any project) | `cody` — carries WCAG 2.1 AA + styleguide update per turn |
| Coding where a defect would be expensive to find later | `mc-orchestrator` — full Planner→Implementer→Reviewer+Verifier→Integrator loop |
| One named stage of that loop, with its upstream artefact in hand | the single `mc-*` actor |
| Read-only code critique, no edits wanted | `code-improver` |
| Bug hunt on a real diff or PR | the `code-review` skill, not an agent |
| Broad fan-out search across files, only the conclusion matters | `Explore` — state breadth ("medium" / "very thorough") |
| Designing an implementation approach before any code | `Plan` |
| Research feeding a strategy, investment, or leadership decision | `mar-orchestrator` |
| One named research stage with its upstream register | the single `mar-*` actor |
| Reviewing or improving an agent definition | `agent-improver` — supply a work sample or its findings are unverified |
| Claude Code, Agent SDK, Claude API, Claude-in-Slack questions | `claude-code-guide` |
| Strategy, options appraisal, communication, writing, domain expertise | **no agent** — these are skills (`multi-actor-strategy`, `scr-pyramid-communicator`, scheme experts). Route via `prompt-refiner` |
| Anything genuinely unclassifiable and multi-step | `general-purpose` |

---

## 4. Escalation ladder

Climb only as far as the blast radius justifies. Each rung costs a cold start and a context reload.

1. **Inline** — default. One-file edits, single questions, anything a Read or Grep answers, and
   every case where re-deriving context would cost more than doing the work.
2. **Single agent** — one bounded specialist job with a clean input and a clean output.
3. **Pipeline** (`mc-orchestrator` / `mar-orchestrator`) — the result will be merged, shipped, or
   put in front of leadership, and no actor should grade its own work.

**Never spawn** to answer what one tool call answers, to re-read files already in context, or to
run two agents over the same files toward the same question.

---

## 5. Write the brief

Agents start cold — no conversation, no prior turn, no assumed cwd. A brief that reads like a
follow-up produces confident nonsense. Every dispatch carries:

- **Objective** — one sentence, stated as the outcome, not the activity
- **Absolute paths** to every file, directory, and artefact involved
- **Constraints** — what not to touch, what not to change, what already failed
- **Definition of done** — how the agent knows it has finished
- **Return format** — what to hand back, given the user never sees the agent's report

For `mc-*` and `mar-*` actors run individually: paste the upstream artefact (spec, source register,
Stage Register) into the brief. An actor invoked without its input invents one.

Dispatch rules that catch people out:

- **Background by default.** Pass `run_in_background: false` only when the very next action depends
  on the result and nothing else could usefully happen meanwhile.
- **Reviewer and Verifier are the one concurrent pair** — static reading and actual execution are
  independent checks. Everything else in a pipeline is sequential.
- **Continuing beats respawning.** `SendMessage` to a live agent keeps its context; a fresh `Agent`
  call throws it away.
- **Relay the result.** The agent's final report is invisible to the user. Summarise what matters.
- **Keep the sample.** That same invisibility means the work sample is gone once the transcript
  moves on. If the output runs long, write it to the scratchpad now and hold the path for step 7.

---

## 6. Report the routing decision

Before dispatching, state in two or three lines: the chosen route, the one reason it beat the next
option, and what comes back. If the route is "no agent", say that and get on with the work — an
unspawned agent needs no justification beyond being unnecessary.

---

## 7. Close the loop — review the agent that ran

Every dispatch ends with an offer to improve the agent. Routing is only worth doing if the roster
gets better over time, and the moment right after a job finishes is the only moment when both
inputs `agent-improver` needs are in hand.

**When to raise it.** After the result has been relayed. One line, at the end, never before the
user has the deliverable:

> Route complete via `cody`. Want me to run `agent-improver` over it? I have the brief and the
> output to hand as a work sample.

**When to recommend rather than offer.** If any of these happened, say so and press:

- The output needed material rework before it was usable
- The agent ignored a constraint the brief stated explicitly
- It returned in a shape other than the one the brief requested
- It stopped early, or asked a question it had the context to answer
- A pipeline stage had to be re-run

**What to hand over.** `agent-improver` marks every performance finding "unverified" when it gets no
work sample, which is the failure mode this step exists to prevent. The router always has one, so
never hand off without:

- Absolute path to the agent's definition file
- The brief, verbatim — the improver needs to see what it was actually asked for
- The output, verbatim, or the scratchpad path from step 5
- The specific gap, in one sentence. "Review this agent" produces generic findings

Its edits land in the definition file and a dated entry goes to
`~/.claude/agents/CHANGELOG.md`.

**When to skip.**

- Route was "no agent" — nothing ran, nothing to review
- Built-in agents (`Explore`, `Plan`, `general-purpose`) have no editable definition. A bad result
  from one of these is a *routing* miss, not an agent defect: fix this skill's routing table instead
- The user declined for this agent already this session. Ask once, then drop it

**Where a repeat miss belongs.** If the same agent underperforms on the same class of task twice,
the fault is more likely the route than the agent. Say that plainly and propose the routing-table
edit alongside the `agent-improver` run.

---

## Boundaries

- **Agents vs skills.** Agents are executors with their own context window and tool set. Skills are
  instructions loaded into the current turn. Domain, voice, framework, and communication work are
  skills — do not wrap them in an agent to feel thorough.
- **`prompt-refiner` handoff.** That skill rewrites an underspecified prompt and routes to *skills*.
  This one routes to *agents*. A vague prompt goes through `prompt-refiner` first; the rewritten
  prompt is what gets routed here.
- **Stay quiet** when the user has already named an agent. Honour the choice; flag a mismatch in one
  sentence only if the named agent lacks the tools for the job (e.g. `code-improver` cannot edit,
  `mc-reviewer` cannot execute).
