# Skill Upgrade Gauntlet

Read this first. The original design for this protocol assumed Claude Code: subagents running
in parallel, blind to each other, and a dashboard opened as a local file in a browser. This
environment is claude.ai chat. There's no subagent tool here, and no persistent workspace
between separate conversations. Every "independent agent" below becomes one Claude, working
through the roles in sequence, in the same conversation. That's the whole adaptation — everything
that follows is built around it honestly, rather than pretending the isolation is still there.

## Contents

1. [What changes, and why it's still worth doing](#1-what-changes-and-why-its-still-worth-doing)
2. [Phase 1 — inventory and the dashboard](#2-phase-1--inventory-and-the-dashboard)
3. [Phase 2 — selection checkpoint](#3-phase-2--selection-checkpoint)
4. [Phase 3 — the per-skill loop](#4-phase-3--the-per-skill-loop)
5. [Verdict standard](#5-verdict-standard)
6. [Keeping the dashboard honest](#6-keeping-the-dashboard-honest)
7. [Persistence across sessions](#7-persistence-across-sessions)
8. [What this loses, and what stands in for it](#8-what-this-loses-and-what-stands-in-for-it)

---

## 1. What changes, and why it's still worth doing

Three things the subagent version has that this one doesn't:

- **Independent runs.** One Claude drafts the contract, builds the benchmark, writes the
  candidate, and runs every arm. Nothing here is blind the way a fresh subagent is blind.
- **A model matrix for free.** Claude can't switch its own underlying model mid-task to test
  Opus against Sonnet the way independent runs could.
- **Disk that survives between sittings.** The sandbox empties out between separate chats. A
  dashboard, a skill draft, a sealed test set — none of it is there if you return tomorrow in a
  new conversation.

None of that makes the gauntlet pointless. A frozen outcome contract, a held-out set the builder
never peeked at, and a verdict that has to clear a real bar are still worth far more than "I
tweaked the wording and it feels better." The adaptations below are about admitting that one
Claude judging its own homework is weaker evidence than a blind panel, and building in what
compensates: the person's own read of the outputs, repeat sampling instead of parallel sampling,
and a held-out set that stays sealed on discipline alone rather than a second process enforcing it.

Match the depth to the stakes using the table in the parent skill. This full protocol is for a
structural rewrite, a contested trim, or "is this skill worth keeping at all" — not a typo fix.

## 2. Phase 1 — inventory and the dashboard

Run the live inventory from the parent skill's "Scopes and editability" section: every scope,
every skill, purpose, editability, overlaps.

Build the dashboard as an HTML artefact, not a local file for a browser to open — there's no
"open this on my computer" in a chat. Write it with `create_file` under `/mnt/user-data/outputs/`
and share it with `present_files` so it renders inline. One row per installed skill: scope,
editable yes/no, one-line purpose, where it came from, dependencies, and any overlap with another
skill. It's a working document the person will return to across several iterations, not a
one-off — worth loading the `frontend-design` skill so it looks considered rather than default.

The dashboard stays view-only. Selection happens in the conversation, not by clicking anything in
the artefact. Update the same file with `str_replace` as the run progresses, and re-share it after
anything worth the person's attention — a contract frozen, a benchmark built, a verdict reached.
Don't re-share on every micro-step; that's just noise.

## 3. Phase 2 — selection checkpoint

Present the inventory, ask which skills to upgrade, and stop. Don't start the loop on a guess
about what the person probably wants. This is the one place the original "wait for the reply"
instruction survives untouched — and it matters more here, not less, because Phase 3 runs long
and autonomous once it starts, with no subagent orchestrator watching over it in the background.

## 4. Phase 3 — the per-skill loop

Run this once per selected skill, worked through to a verdict before moving to the next. Don't
hold two skills' half-finished contracts open at once — see [§7](#7-persistence-across-sessions).

### 4.1 Outcome contract

This part barely changes — it depends on discipline, not on subagents.

1. Read the skill in full: `SKILL.md`, references, examples, and any real transcripts you can
   find of it firing.
2. Write down what the skill is *for* before touching how it works. Separate ends from means —
   a formatting choice, a prompting trick, a tool sequence belongs in the contract only if the
   method itself is genuinely what the person cares about, not just how it happened to be built.
3. Strip anything that would let a grader guess which version produced a given output: no
   distinctive phrasing, no giveaway examples.
4. Save the draft to a file. Then, as a separate step, re-open only the original skill and the
   draft — not your own reasoning above it — and read it as a critique: what did the draft miss,
   distort, or wrongly treat as a preference? This is a best-effort reset, not a fresh mind.
   Anything you're unsure you'd have caught cold is a reason to look harder, not skip the step.
5. Freeze the contract. Show it on the dashboard.

### 4.2 Benchmark, with a held-out set that's actually sealed

1. From the frozen contract, not the skill's implementation, write a spread of realistic tasks:
   ordinary use, hard cases, edge cases, and at least one task that should make the skill *not*
   fire.
2. For each task, write the evaluation packet: the request, the relevant slice of the contract,
   any fact that must hold, what matters most when qualities trade off, and what disqualifies an
   answer outright.
3. Split the tasks into two folders, `iteration/` and `sealed/`. Write the sealed tasks and their
   packets, then leave that folder alone — don't `view` it again until §4.5. There's no second
   process enforcing the seal the way Claude Code's separate agents would; the discipline of not
   looking is the whole mechanism. Opening it early doesn't bend the rule, it breaks the run.
4. Before editing anything, audit your own benchmark against the contract: does it cover the real
   range, or quietly favour the shape of the original skill? Fix what's weak, then freeze it. Show
   coverage on the dashboard — task count and categories, never the sealed tasks themselves.

### 4.3 Build the candidate, then run the arms

Upgrade the skill for the model running this conversation. The standing principle still holds: a
skill should mainly hold what the model couldn't reasonably know on its own. Give yourself room to
try more than one approach if the first pass doesn't clearly clear the bar in §4.4.

Run each `iteration/` task through three conditions, in sequence, on the model currently active:

1. No skill.
2. The skill exactly as it was — the snapshot copy.
3. Your candidate.

Run each condition twice per task where the task is cheap enough to justify it. Sequential
resampling in one conversation is thinner evidence of real variance than parallel independent
runs — treat a single win on a single task as noise, not signal.

Test on every model the skill will run on — Haiku, Sonnet and Opus where all three are in use.
A skill tuned on a newer model can under-specify for an older one, and detail that helps Haiku
can crowd Opus. In Claude Code, run each arm through a subagent pinned to each model (the Agent
tool's `model` parameter) and log model × arm on the dashboard. Here, ask the person to switch the
active model before a condition and confirm once they have. You can't switch your own model or verify a switch happened from inside
the conversation; take their confirmation and log which model ran which condition on the
dashboard.

### 4.4 Grade, and let the person's read outweigh your own

Grade each output against that task's evaluation packet — the same rubric a blind judge would
use. Label this on the dashboard as **self-graded**, not blind: you wrote the candidate and you're
marking it too, and calling it independent would just hide the weakest part of this adaptation.

Show the person the outputs for tasks where the arms disagreed — anonymised where you reasonably
can, in randomised order — and ask which one they'd actually want. Their read is the closest thing
this workflow has to an independent judge. On a close call, it decides the outcome, not your score.

### 4.5 Iterate, then check the seal

Loop §4.3–§4.4 on `iteration/` only. When a candidate stops improving, or clearly clears the bar,
unseal `sealed/` and run it once, cleanly, on the finished candidate against the finished original.
This is the one result that wasn't shaped by watching it improve — weight it above anything from
the iteration set.

## 5. Verdict standard

Unchanged in spirit from the original design:

- **Green.** The candidate clearly beats the original on the held-out set, holds up against
  no-skill, satisfies the contract, and introduces no regression the person would notice.
- **Green — retire.** No-skill matched or beat every skilled condition, repeatedly, including on
  the held-out set. Retiring is a successful outcome — say so plainly, and don't force a rewrite
  just to turn the dashboard green.
- **Yellow.** A real improvement on some tasks and a real loss on others, or a win that only shows
  up once. Needs another pass, not an install.
- **Red.** The candidate loses to the original, to no-skill, or to both.

A single strong sample, longer output, or a generic "sounds more thorough" reaction from you is
not evidence of green. The held-out result and the person's own preference carry the verdict.

## 6. Keeping the dashboard honest

Every skill in the run shows: its contract, benchmark coverage (never the sealed tasks), which
model ran which condition, iteration-set results, the held-out result once unsealed, the person's
calls on disputed outputs, and the final verdict with the reasoning behind it. Anyone reading the
dashboard mid-run should be able to tell that judging happened in the open, in the same context as
the building. That's the honest version of this workflow, not a diminished one.

## 7. Persistence across sessions

The sandbox resets between separate chats. Nothing on disk survives unless it leaves the sandbox.
Three things carry a run forward:

- **The conversation itself.** As long as the chat isn't deleted, `recent_chats` and
  `conversation_search` can find it again — the nearest equivalent to a resumable workspace.
- **`/mnt/user-data/outputs/`.** Deliver the finished skill, the reverting snapshot, and the
  dashboard here, and tell the person to save what they want kept — the sandbox won't.
- **The Notion AI Skills DB.** Log the frozen contract, the verdict, and the evidence there once a
  skill resolves, the same way the parent skill's workflow 9 already does. That's the durable
  record for a run spanning more than one sitting.

For a run covering several skills, finish one skill's loop before starting the next. Log its
dashboard state to Notion, then treat it as safe to pick up fresh in a new conversation — don't
try to hold several skills' half-finished contracts in one context at once.

## 8. What this loses, and what stands in for it

| Original design | Claude chat replacement |
|---|---|
| Independent subagents, blind to each other | One Claude, sequential roles, explicit self-critique passes |
| Blind independent judges | Self-graded against a frozen rubric; the person's read decides close calls |
| Four conditions across two model generations | Three conditions on the active model; cross-model checks only if the person switches models between arms |
| Parallel sampling for variance | Repeat sampling in sequence, weighted below the held-out result |
| Local dashboard, opened in a browser | HTML artefact, updated through the run |
| Workspace that survives a crash or context reset | Conversation history, the outputs folder, and a Notion log |
