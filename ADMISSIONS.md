# Admissions

Every agent and skill in this library, and the evidence that it beats plain Claude. The rule is
in `.claude/references/admission-test.md`. `scripts/check-admissions.sh` enforces it in CI;
its header lists what it fails on.

**Status values.** `passed`: cleared the admission test. `grandfathered`: existed on 2026-10-29
and **has not passed** the test. Notes record any partial evidence. Testing the
grandfathered parts is the audit queue in `.claude/skills/cpo/references/portfolio.md`.

Adding a row: one line per part, kept in alphabetical order within its table. Evidence for
`passed` is the work-sample path alone, under `work-samples/admission-<name>-`.

## Agents

| Name | Status | Evidence or notes |
|---|---|---|
| agent-improver | grandfathered | Slight win in round 1, blind judges, one run (work-samples/agent-vs-house-2026-10-20.md) |
| cluster-analyst | grandfathered | Not tested |
| code-improver | grandfathered | Not tested |
| cody | grandfathered | Tied plain Claude, round 1, one run (work-samples/agent-vs-house-2026-10-20.md) |
| evidence-auditor | grandfathered | Not tested |
| idea-challenger | grandfathered | Not tested |
| investigator | grandfathered | Not tested |
| mc-integrator | grandfathered | Not tested |
| mc-planner | grandfathered | Not tested |
| mc-reviewer | grandfathered | Tied on detection. Lost round 1 slightly, then won on house rules in round 2, author-scored (work-samples/agent-vs-house-2026-10-20.md, work-samples/agent-vs-house-round2-2026-10-20.md). Real work: caught four defects self-review had passed (tri-momentum CLAUDE.md, decisions 32 and 34) |
| mc-verifier | grandfathered | No head-to-head. Real-work finding on 22 Oct: work-samples/mc-orchestrator-2026-10-22-registers.md |
| release-engineer | grandfathered | Not tested |
| security-auditor | grandfathered | No head-to-head. Real-work findings on 22 Oct: work-samples/mc-orchestrator-2026-10-22-registers.md |
| source-scout | grandfathered | Not tested |
| strategy-challenger | grandfathered | Not tested |
| strategy-juror | grandfathered | Not tested |
| ux-designer | grandfathered | Not tested |
| watchdog | grandfathered | Tied plain Claude on detection, 20 Oct rounds 1 and 2. Won on house rules in round 2, but the fixture author scored it (work-samples/agent-vs-house-round2-2026-10-20.md) |

## Skills

| Name | Status | Evidence or notes |
|---|---|---|
| academic-researcher | grandfathered | Not tested |
| balance-tri-club-brand | grandfathered | Not tested |
| business-case-builder | grandfathered | Not tested |
| content-research-writer | grandfathered | Beat no skill, 2 of 3 tasks, blind grader, one run each, 6 Sep (.claude/skills/CHANGELOG.md, 2026-09-06 entry) |
| cos | grandfathered | Not tested |
| cpo | grandfathered | Not tested |
| customer-insight | grandfathered | Not tested |
| deep-research | grandfathered | Not tested |
| discovery-loop | grandfathered | Not tested |
| editor | grandfathered | Not tested against no skill. The 1.1.0 procedures section beat 1.0.0 on a blind A/B, 21/21 against 17/21 twice (work-samples/editor-upgrade-2026-11-02/) |
| etf-investing-advisor | grandfathered | Not tested |
| etf-investing-coach | grandfathered | Not tested |
| first-principles | grandfathered | Not tested |
| high-output-management | grandfathered | Not tested |
| humanizer | grandfathered | Not tested |
| interview-coach | passed | work-samples/admission-interview-coach-2026-11-02/ |
| issue-tree | grandfathered | Not tested |
| job-scan | grandfathered | Not tested |
| justin-voice | grandfathered | Not tested |
| made-to-stick | grandfathered | Not tested |
| market-analyst | grandfathered | Not tested |
| mc-orchestrator | grandfathered | Not tested |
| multi-actor-research | grandfathered | Not tested |
| multi-actor-strategy | grandfathered | Not tested |
| notion-second-brain | grandfathered | Not tested |
| positioning | grandfathered | Not tested |
| product-requirement-document | grandfathered | Not tested |
| project-management | grandfathered | Not tested |
| read-the-room | grandfathered | Not tested |
| recent-pulse | grandfathered | Not tested |
| red-team | grandfathered | Not tested |
| research-to-ideas | grandfathered | Not tested |
| resume-builder | grandfathered | Not tested |
| rewrite | grandfathered | Not tested |
| scr-pyramid-communicator | grandfathered | Not tested |
| six-thinking-hats | grandfathered | Not tested |
| skills-librarian | grandfathered | Not tested |
| terse-mode | grandfathered | Not tested |
| triathlon-coach | grandfathered | Not tested |
| youtube-explainer | grandfathered | Not tested |
