# multi-actor-strategy — phase 5 verdict (watchdog), 2026-09-29

`watchdog`, dispatched from the top-level session, compared the phase 1 baseline
(`multi-actor-strategy-2026-09-29-baseline.md`) with the phase 4 agents run
(`multi-actor-strategy-2026-09-29-agents.md`) against the plan's "How we know it worked" table.
Run 1 of 2. Read-only; it edited nothing. The report below is verbatim.

**Owner decisions on this verdict (2026-09-29):** keep `strategy-challenger` for run 2 and fix
its path contradiction; fix `strategy-juror` (strip Stage 2 verdicts from juror cases), then run 2;
run 2 uses a new real decision whose inputs are gathered by a session with no prior view.

---

## Phase 5 verdict — baseline vs agents run (run 1 of 2)

**Bottom line:** on this run, the challenger added real value, the jurors added one real finding but no spread on the question that matters, and the script added nothing. The ledger's predicted signal — "a challenger pick or juror spread that differs from the preference" (`CHANGELOG.md` line 76) — did not occur: challenger picked C, jurors picked C′, preference was C.

### 1. Verdict per signal

**Challenger's strongest pick — MET, on the second clause only.**
- Pick matched preference: agents line 133 "STRONGEST PICK: C"; line 95 preference C; line 188 "No pick gap." First clause not met this run.
- Catch 1 (clearly absent from baseline): the usage check. Agents line 117 (MISSING OPTION): "Justin checks the session history in the five other repos… The invisibility is only from this repo, not from Justin." This became C′'s gate on the trio (line 364). The baseline treated the same data gap as an open question it could not act on — line 80 "(E3, not reachable)", lines 205–206 "exists but was not reachable here", line 293 — and never made the owner's lookup a precondition; it retires the four now (line 241). The catch changed the action.
- Catch 2 (absent from baseline): nested dispatch. Agents lines 134–135: "By default, a subagent can spawn subagents of its own, up to three layers below the main conversation." I fetched https://code.claude.com/docs/en/sub-agents today and the sentence is there verbatim, with `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH`. The baseline never questions whether the orchestrator can fan out — A3 (line 32) concerns top-level dispatch only. Real catch; the phase 4 run itself kept it non-load-bearing (line 344).
- Catch 3: the B steelman (agents line 137) — a fresh read-only dispatch may make standing tool-bounded definitions redundant — directly contests the baseline's asserted-not-tested load-bearing claim "their tool limits… can't be copied into a skill" (baseline lines 307–308).
- Not new: the hinge (agent vs skill conductor, agents line 139) is in the baseline's counterfactual (line 243).
- Caveat: the attack again ended as a condition the favourite absorbed — "qualifying, not fatal… C should be amended to…" (line 135) — the same pattern baseline line 366 criticised, but reached blind.

**Juror spread — MET, narrowly, on the second clause only.**
- No disagreement on strongest: all three picked C′ (agents lines 276, 291, 311; table 329–334).
- Bets agreed more than the baseline's: all three bet 65% on C′ (lines 279, 297, 321), versus the baseline's one-mind bets spread across three options at 75/80/25 (lines 212–214). This contradicts the juror file's own rationale, "When one mind writes every bet, the bets agree; yours can disagree" (`strategy-juror.md` line 14).
- Shared blind spot the baseline missed: rule-settlement. All three name that the rule is never settled (lines 278, 295, 316). In the baseline I checked A5 (line 34, flagged Assumed), the Stage 1 register line 73 ("flagged for challenge"), all of Stage 2, and the recommendation and brief (lines 230–245, 300–322): A5 is never challenged after Stage 1, and nothing says sign, withdraw or replace. Genuinely absent. Confound: the phase 4 main thread had already widened the question to "should the rule be the basis" (line 33), so the jurors measured cases against a question the baseline never asked.
- Partly counts: whether the five-repo check is feasible (juror lines 278, 295, 317). The baseline asserts the opposite without support ("The data… exists", line 206).
- Not counted: "no keep-bar for the pair" — the baseline had one (condition 2, line 239).

**Recommendation — MET (changes and gains conditions; no Assumed was lost, since the baseline had none).**

| | Baseline (lines 230–241) | Agents run (lines 362–365) |
|---|---|---|
| Implementer | folded into a new skill; the merge-into-cody option was **eliminated** (line 121) | **folded into cody** |
| Orchestrator, planner, integrator | retired now | retired only after the 2026-10-08 usage check |
| The rule | not addressed | withdrawn |
| Pair retire test | graded work sample by 11-01 | 12-31, with a numeric bar, counting only sessions with the Agent tool |

Traceable to agents: the 10-08 gate (challenger) and the rule withdrawal (jurors, seeded by the main thread's framing). Main-thread only: the fold into cody, the 12-31 date, the Agent-tool counting rule. **Lost:** the baseline's condition 1, the spec-on-disk gate (lines 237–238). A grep of the agents file for "spec" finds only "specific"; the phase 4 run never raises it. The signal counts change, not improvement, and this is a regression.

**Script — NOT MET.** The agents run reports "PASS: 0 defect(s)" at every stage (lines 91, 223, 546) with no intermediate FAIL. The baseline JSON was rendered afterwards as the passing fixture. The script caught no rule break in either run, and cannot catch the factual errors in section 5. I could not verify phase 4's PASS claims: the run JSON was not on disk where I could read it. *(Main-session note: the JSON is on the Launch B branch; re-run by the main session, `check_strategy.py` exit 0, "PASS: 0 defect(s)".)*

### 2. Confounds
1. **The inputs pre-shape the options.** Both runs produced the same five options in the same letter order (baseline 50–54; agents 40–53), and both main threads preferred C. The inputs were curated by the baseline author, who "leaned towards C while framing" (baseline line 365); E5/E6/E9/E10/E11 each point at one option. Little room for the challenger's pick to differ. Weakens what this run can say about the first clause, not the MET.
2. **Different main-thread authors.** Several differences are the phase 4 main thread's, not the agents': the widened question, the fold into cody, the dates, the Agent-tool counting rule. Weakens Recommendation MET to "partly agent-attributable". The PM retrospective's "Without the council, step 1 would not be in the brief" (line 541) is an unverifiable counterfactual from an interested party.
3. **Newer SKILL.md and templates.** Phase 4 had the MISSING OPTION field, a per-option pre-mortem and the live script. B was eliminated at Stage 2, so the jurors saw three cases where the baseline council saw four; the council sets are not comparable on blind spot.
4. **Sustain arrived pre-judged.** Case text: "kept as the do-nothing baseline" (line 583); all three jurors flagged it. Jurors also received the challenger's verdicts inside every case, so their agreement is not independent of the challenger's pick. Weakens any reading of juror unanimity. Does not weaken the rule-settlement catch.
5. **Web use.** The nested-dispatch catch came from the challenger's step 7 ("open the source"). The baseline main thread could have fetched the same page and did not. That value may come from a fact-check mandate a skill instruction could replicate, not from blindness. Weakens the case for the agent, not the MET.
6. **Run order and stakes.** The baseline declares its author had a stake in it looking weak (lines 12–15); the phase 4 main thread read agent files saying the agents exist because the baseline failed. Both authors had a stake in the agents looking useful.
7. **N = 1.**

### 3. Deviations and blindness
- Challenger dispatched in the background, Proxy map written the next turn (line 542): does not break blindness; the challenger never received the map.
- Case asymmetry (line 543): not a preference leak, but biases the council (confound 4).
- Erratum, "fourth review" reached the jurors (line 544); juror-1 echoes "three reviews that ended in deferral" (line 277). Factual contamination, not a leak.
- Persistence path (line 545): harmless, but the JSON was not findable by this reviewer.
- **Not reported: the agent definitions carry baseline results.** `strategy-challenger.md` line 14 ("The 2026-09-29 baseline run did exactly that") and `strategy-juror.md` line 14 ("its 'strongest' pick matched its own preference"). The main thread read both (agents line 7), and the agents run with them as instructions. This leaks the baseline's *process outcome*, not its option or recommendation. Option-level blindness holds; line 3's "Baseline not seen" is true only of the file.
- **Not reported: the definitions contradict themselves.** Both say "Open only the paths the brief names" and also "Read `.claude/references/external-content.md`" (challenger lines 24 vs 57; juror 25 vs 55). The challenger resolved it by skipping the file (agents line 116).
- Two near-matches between runs, most likely convergence, not leakage: the challenger's "Priya" is almost the baseline's "Dana" (a platform lead who deletes an "unused" job; agents line 120 vs baseline line 101), and both runs use "fourth" deferral wording. Under the retire test (`agent-plan.md` line 142), output that matches the inline version counts against the agent.

### 4. Per agent (recommendation for the owner)
- **`strategy-challenger`: too early, leaning keep.** Two catches absent from the baseline (the usage-check precondition; the verified nested-dispatch fact), both of which changed the recommendation. Its pick matched the preference, so the blind-pick mechanism is untested, and its value may be the fact-check mandate rather than blindness.
- **`strategy-juror`: too early, leaning retire unless run 2 differs.** Unanimous on strongest, matching the preference and the challenger's pick, and all bet 65%: less spread than the baseline's one-mind bets. Its one real catch was seeded by the main thread's framing and needed only one juror. Before run 2, strip Stage 2 verdicts from the cases, or accept that jurors are downstream of the challenger.

### 5. Factual errors against the inputs
**Agents run:**
1. "20 commits in about a month (E1)" — structural. E1 gives no window, only last-edit dates. Starts with the challenger (lines 122, 127), propagates to the juror case (583), juror-1 (277), juror-2 (293) and the final brief (491). It is the main reason Sustain was called "not cheap". The 276-lines figure is correct.
2. "brought back agents on exactly the pair's grounds (E9)" — repeated (brief line 489; Stage 2 decision 1, line 194; the challenger's "re-added", line 128). E9 says `research-to-ideas` added four *new* agents on blindness or tool grounds; no `mar-*` agents came back. Overstates a reason for eliminating B.
3. Minor: "22 of 26 sessions" (lines 106, 484) drops E3's window ("the week to 2026-09-11"); Sustain graded "Supported" at Stage 1 (line 40) though its core bet is contradicted by E1 and E10.

**Baseline:**
1. "deferred a fourth time" — structural (lines 190, 262, 309; also in the fixture JSON). It rests on "A was the implicit decision on 2026-08-18 and 2026-09-11 too" (line 117), but E6 records 08-18 as an explicit survival for a stated reason; only 09-11 is a recorded deferral. The count is also internally inconsistent (line 190 vs line 309). Phase 4 made and corrected the same error; the baseline did not.
2. "The data to check this… exists" (line 206): not supported by the inputs.
3. "The other four have no run on record, ever" (line 308): E2 covers this repo only, and E3 says use elsewhere is unknown. The brief hedges two lines later.

**What run 1 shows:** a blind challenger can surface action-changing catches one context missed, and jurors can surface a question-level gap. **What it cannot yet show:** that the challenger's pick ever departs from the preference, that jurors ever split on the strongest case, or that any of this repeats. Run 2 should use a decision whose inputs were not curated by an author who already had a preference.
