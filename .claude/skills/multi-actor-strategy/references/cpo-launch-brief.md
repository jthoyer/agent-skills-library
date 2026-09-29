# CPO launch brief: agents behind multi-actor-strategy

Ready-to-launch instructions for phases 2–6 of `agent-plan.md` (same folder). Phase 1 is done.
Launch A (phases 2–3) was built on 2026-09-29; Launch B is next.

## How to launch

The work runs as three launches, in order. Each one ends at a stop point that needs a fresh
session or the owner's yes.

| Launch | Phases | Paste this | Where |
|---|---|---|---|
| **A** | 2–3: script, then two agents | `/prompt-refiner Launch CPO with Launch A from .claude/skills/multi-actor-strategy/references/cpo-launch-brief.md` | Any session in this repo |
| **B** | 4: the comparison run | `/prompt-refiner Run multi-actor-strategy on work-samples/multi-actor-strategy-2026-09-29-inputs.md, following Launch B in .claude/skills/multi-actor-strategy/references/cpo-launch-brief.md` | A **fresh** session with the Agent tool |
| **C** | 5–6: judge, decide, close | `/prompt-refiner Launch CPO with Launch C from .claude/skills/multi-actor-strategy/references/cpo-launch-brief.md` | Any session, after B is saved |

**Why three launches, not one.** Phase 4 needs a main thread that can dispatch agents and has
never seen the baseline. CPO can do neither. It will have read the baseline while building the
agents, and no one has ever seen an agent dispatch from inside another agent (`CPO.md`, step 4).
A fresh top-level session can do both.

## The workflow

```
Phase 1  Baseline run (done, 2026-09-29)
         inputs:   work-samples/multi-actor-strategy-2026-09-29-inputs.md
         output:   work-samples/multi-actor-strategy-2026-09-29-baseline.md
   │
Launch A (CPO)
Phase 2  Script ─────────── cody writes it + tests → mc-verifier runs it → CI
   │     gate: CI green; baseline passes, one decoy per rule fails
Phase 3  Two agents ─────── CPO drafts → agent-improver reviews (definition-only)
   │     gate: frontmatter + reference checks pass; SKILL.md still runs without agents
   ▼ STOP: hand the Launch B line to the owner
Launch B (fresh session, no CPO)
Phase 4  Re-run ────────── main thread runs the skill on the inputs file only,
   │                        dispatching strategy-challenger and 2–3 strategy-jurors
   │     gate: saved to work-samples; labelled dispatched or ABORTED (never embodied)
   ▼ STOP
Launch C (CPO)
Phase 5  Judge ─────────── watchdog compares baseline vs re-run on the plan's signal table
   │     gate: the owner's yes on keep / retire for each agent; option-premortem only if earned
Phase 6  Close ─────────── agent-improver on each agent with its work sample → CHANGELOG
```

---

## Launch A — phases 2 and 3 (CPO)

**Objective.** Build the check script and the two strongest agents from `agent-plan.md`, so a
fresh session can run the comparison. Build nothing else.

**Read first** (repo-relative; `Glob` if a path does not resolve):
- `.claude/skills/multi-actor-strategy/references/agent-plan.md`: the design; follow it.
- `.claude/skills/multi-actor-strategy/SKILL.md` and its `references/`: the skill as it stands.
- `.claude/skills/research-to-ideas/references/agent-workflow.md`: the pattern to copy.
- `.claude/agents/idea-challenger.md`, `.claude/agents/evidence-auditor.md`: the agent format.
- `work-samples/multi-actor-strategy-2026-09-29-baseline.md`: its Stage Registers are the test
  fixture for the script. Its recommendation is **not** an input to agent design.

**Phase 2 — the script.** Route to `cody`.
- Write a strategy checker at `.claude/skills/multi-actor-strategy/scripts/check_strategy.py`, with a test beside it, following `check_brief.py` in
  `research-to-ideas`. It reads a run as JSON and checks the rules in the plan's "What the script
  checks" list.
- Include a JSON rendering of the baseline as a fixture. It followed the skill, so it should
  pass. Then add one decoy per rule: a copy of the baseline with that one rule broken. Each
  decoy must fail on its own rule, the pattern `CHANGELOG.md` records for the other checks. A
  rule no decoy trips is not wired.
- Add the test to `.github/workflows/checks.yml`.
- Dispatch `mc-verifier` to run the script and its test and confirm they pass in CI's shell.
- **Gate:** CI green. The baseline passes and every decoy fails.

**Phase 3 — two agents.** CPO drafts; this is library composition, CPO's portfolio authority.
- `strategy-challenger`: opus; Read, Grep, Glob, WebSearch, WebFetch. Stage 2. Sees the operative
  question, constraints and the options longlist in shuffled order. **Never** sees which option
  the main thread prefers. Casts the Dynamic Expert Cameo personas itself. Names the option it
  thinks is strongest and attacks that one hardest.
- `strategy-juror`: opus; Read, Grep, Glob. Stage 3. Sees anonymised, shuffled cases. **Never** sees
  actor names, the preference or other jurors' answers. Answers the three council questions and
  places a Conviction Bet.
- Both follow `idea-challenger.md`'s shape: mandate, why you exist, inputs, process, fixed output
  block with a `BLIND: yes | NOT BLIND (what you saw)` line, behaviours to avoid, and the
  external-content rule. Both open only the paths their brief names.
- Add an agent-workflow.md reference (new) to the skill: the role table, the dispatch contract, the
  embodied fallback and its wording caps, the retire test.
- Edit `SKILL.md` Stages 2 and 3 to dispatch the agents when the Agent tool exists. Without it,
  the skill must still run exactly as today, labelled embodied.
- Run `scripts/check-frontmatter.sh`, `scripts/check-references.sh` and
  `scripts/sync-plugin-manifest.sh --check`.
- Dispatch `agent-improver` on both new files (definition-only; no work sample exists yet).
  Apply its High findings.
- **Gate:** all three checks pass; `agent-improver` has no open High finding.

**Do not:**
- Build `option-premortem`. Phase 5 decides whether it is earned.
- Run the comparison yourself, embodied or dispatched. You have read the baseline.
- Touch the `mc-*` agents. The baseline's recommendation about them is a proposal for the owner,
  and is out of scope here.

**Stop and return:** what was built, with paths; check results; `agent-improver`'s findings and
what was applied; then the Launch B line, verbatim, for the owner to paste into a fresh session.

---

## Launch B — phase 4 (fresh session, no CPO)

**Objective.** Re-run `multi-actor-strategy`, full orchestration, on the frozen inputs, with the
two new agents dispatched. This is the comparison run.

**Rules:**
1. **Probe first.** If this session has no Agent tool, stop and say so. Do not embody. An
   embodied re-run measures nothing the baseline did not. Save nothing; label the attempt
   ABORTED in the reply. If the Agent tool is present but `strategy-challenger` is not listed,
   check again on the next turn before aborting (`.claude/references/session-cold-start.md`).
   The session must be on a branch that holds Launch A's agents: its branch, or `main` after merge.
2. **Inputs:** `work-samples/multi-actor-strategy-2026-09-29-inputs.md` and the skill. Nothing else
   in `work-samples/`.
3. **Never open** `work-samples/multi-actor-strategy-2026-09-29-baseline.md`, or its JSON rendering
   `work-samples/multi-actor-strategy-2026-09-29-baseline.json` (the checker's test fixture), and
   never pass either path to an agent. Do not run `test_check_strategy.py`: it loads that
   fixture. Run only `check_strategy.py` on your own run's JSON. If you see the baseline by
   accident, say so in the output's first line.
4. Dispatch `strategy-challenger` once at Stage 2, in the same turn as your Stakeholder Proxy work.
   Dispatch two or three `strategy-juror`s at Stage 3 in one message, each with the cases in a
   different order.
5. Paste each agent's reply verbatim into the run, under its stage.
6. Save to work-samples/multi-actor-strategy-2026-09-29-agents.md (new file). Render the run as JSON and
   run `.claude/skills/multi-actor-strategy/scripts/check_strategy.py` on it. Fix every FAIL before saving.
7. Commit and push to the branch you were given. Do not read the baseline to compare. Launch C
   does that.

---

## Launch C — phases 5 and 6 (CPO)

**Objective.** Decide whether the agents earned their place, act on the owner's decision, and
close the loop.

**Phase 5 — judge.**
- Dispatch `watchdog` with both run files and the plan's "How we know it worked" table. It
  returns a verdict per signal, citing lines from both runs. CPO does not grade the comparison;
  it designed the agents.
- If Launch B was ABORTED, or the agents file is missing, stop. Report that phase 4 is still owed.
- Put each agent's keep or retire case to the owner, with watchdog's evidence. **Wait for the
  owner's yes** before retiring anything.
- `option-premortem`: build it only if watchdog finds the baseline's Risk Analyst row was the
  weakest step, and first check whether widening `idea-challenger` covers it instead.

**Phase 6 — close.**
- Dispatch `agent-improver` on each kept agent, with its phase 4 reply as the work sample.
- One `CHANGELOG.md` entry under 250 words per agent. Update the plan's status line.
- Retired agents go to `.claude/skills/_retired/` with a `_superseded-by.md` pointer, and their
  blindness rule goes back into `SKILL.md` as an instruction.

**Return:** watchdog's verdict table, the owner's decision, what changed, and the ledger entry.

---

## Independence, stated plainly

| Phase | Who judges | Independent? |
|---|---|---|
| 2 | `mc-verifier` runs the script | Yes, if dispatched |
| 3 | `agent-improver` reviews the files | Definition-only |
| 4 | The agents are blind to the preference | Yes, only if dispatched from a fresh session |
| 5 | `watchdog` compares the runs | Yes, if dispatched. CPO designed the agents, so CPO does not grade them. |

Any phase that runs embodied says so in its output and in the ledger entry.
