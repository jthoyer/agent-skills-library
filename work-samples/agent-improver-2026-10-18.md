# agent-improver — library audit of 18 agents, 2026-10-18 (delegated)

## Brief (summary)
Propose-only library audit of `.claude/agents/*.md` against `routing.md` and the ledger. Queue: cpo, cody (incl. an independent pass on the two REDUCED-INDEPENDENCE reviews of 2026-10-13), cos, watchdog, idea-challenger, cluster-analyst, source-scout, ux-designer, mc-reviewer + mc-verifier retire test. Grep for stale references to retired items. ≤900 words: ratings table, ranked before→after proposals, stale-reference list, Next audit targets line.

## Output (condensed; full text in the session transcript)
Independence: dispatched context, produced none of the reviewed work. Could not see the session's skill listing.

Proposals:
- P1 HIGH watchdog — `watchdog.md:52` bounces single-artefact reviews, but `cpo/SKILL.md:81` and `close-out.md:45` dispatch it on one member-facing artefact. Rewrite the line to accept that case.
- P2 HIGH cody (+ mc-planner:35, mc-verifier:15) — `cody.md:5` lists no Skill tool; step 4 (`:62`) tells it to run `code-review`. Make the step conditional and say "self-read" when the skill is absent. Probe on first dispatch.
- P3 HIGH 13 agent files — `Glob '**/references/…'` fallbacks search from cwd, which is the app repo when the library is a second working directory. Search each listed working directory.
- P4 MED mc-integrator — no slot for `security-auditor` findings that `mc-orchestrator:56` now dispatches.
- P5 MED idea-challenger — intake mode has no inputs contract or missing-input rule.
- P6 MED cody — `:73` cites a non-existent "step 5"; `:42`/`:71` duplicate a rule.
- P7 MED ux-designer — styleguide Glob lacks `**/`.
- P8 LOW cody — count matches before a scripted find-and-replace.

Independent cody pass: 1 A · 2 S · 3 A · 4 A · 5 A · 6 A · 7 S. Disagrees with both 2026-10-13 self-reviews (Instructions not Strong: dangling "step 5", duplicated rule; Observed not Strong: deploy-order defect missed at build). Both samples were the main thread embodying cody, so they cannot show P2.

Stale references: cody.md:73; release-engineer.md:4; watchdog.md:30; mc-reviewer.md:26; agent-improver.md:175; CHANGELOG.md:3 ("appends") and template missing `Scores:`.

## Main-thread verification (2026-10-18)
P1 (`watchdog.md:52`), P2 (`cody.md:5`, `:62`) and P6 (`cody.md:73`) confirmed by reading the lines. Others not re-checked.
