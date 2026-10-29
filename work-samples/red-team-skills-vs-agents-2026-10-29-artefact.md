# Artefact under attack: "Skills, agents or plain Claude?" (answer given 2026-10-29)

Question asked by the owner (Justin): If you started from scratch, would you use skills or agents for the type of work I do, or just prompt the regular Claude agent? And how do I ensure the model always acts like the best in the field / always remembers to consider the right things?

## The answer given

**Verdict:** Mostly plain Claude, plus a short set of rules it always reads. Keep a few skills for things only you know. Keep agents only where a second, independent pair of eyes matters. You'd build about a third of what you have.

### Why
1. Your own test says agents rarely find more than plain Claude. On 20 Oct you ran watchdog, mc-reviewer, cody and agent-improver against plain Claude (work-samples/agent-vs-house-2026-10-20.md and -round2). Round 1: one win each, two ties. Round 2: all eight runs found every planted defect. Agents won on house rules (per-criterion coverage, guard proof, no padding) and cost (~a third of the tokens). So an agent earns its place when it enforces a rule, keeps a reviewer independent or saves money — not by being smarter.
2. Skills only help with what Claude doesn't already know. Keep: voice, club brand, job-scan workflow, Australian tax rules, repo conventions. Don't need: SCR, Six Hats, issue trees, Made to Stick, Grove — Claude knows these; "use Six Hats on this" works without a skill. Every skill description sits in context every session; neighbours compete (editor/humanizer/justin-voice/content-research-writer; four research skills).
3. Upkeep already hurts: on 18 Oct, 24 account copies had drifted (work-samples/account-sync-drift-2026-10-18.md).
4. "Always" never comes from a skill: a skill loads only when its description matches.

### Levers for "best in field / always remembers" (weakest first)
- Persona ("world-class X"): low; published tests of role prompts show small, inconsistent gains. Skip.
- Named standard (WCAG 2.2 AA, SCR, Australian CGT rules): medium–high.
- Short always-loaded rules block (user prefs, CLAUDE.md): high while short.
- Required output section (like /rewrite's contract, "Not checked:"): high.
- Enforcement (hooks, CI, tests, independent reviewer): near certain.
Pattern: name the standard, make the check visible in output, have a separate reviewer grade it.

### Changes, by payoff
1. One standing-rules block in claude.ai preferences + pointer in each repo CLAUDE.md. Draft: "Before answering: name the audience and what done looks like. State assumptions in one line. Name the strongest objection to your own answer. Say what you did not check. Never put member data or secrets in output. Ask before anything hard to undo. Use the expert standard for the field and name it. Lead with the answer."
2. Cut skills ~40 → ~15. Keep: justin-voice, balance-tri-club-brand, job-scan, resume-builder, etf-investing-*, triathlon-coach, skills-librarian, conductors (cpo, cos, mc-orchestrator, research-to-ideas, multi-actor-strategy). Merge writing four into one pass; research four into two; fold general frameworks into one "thinking toolkit" or retire.
3. Cut agents 18 → ~8. Keep mc-reviewer, mc-verifier, security-auditor, watchdog, investigator, evidence-auditor, blind challengers/jurors. Review mc-planner/mc-integrator (no use 29 Sep, one run each 22 Oct), cody (tied, cheaper), code-improver (overlaps mc-reviewer). Extend the 31 Dec retire test.
4. Turn "must always" rules into running checks: privacy grep for real names/emails in each app repo's CI, required "Not checked:" line in PR descriptions.
5. One source of truth: install the library as a plugin everywhere, stop claude.ai uploads as a second copy.
6. Make the 20 Oct test the bar for anything new: beat plain Claude on a fixture, or enforce a rule plain Claude breaks.
