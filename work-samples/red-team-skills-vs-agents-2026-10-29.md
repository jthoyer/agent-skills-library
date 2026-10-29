# Red team: "skills, agents or plain Claude?" — 2026-10-29

**Dispatcher:** main thread, `cpo` via `/rewrite`. **Delegated** to `general-purpose` (opus),
following the `red-team` skill. The artefact it attacked was written by the main thread, so
this was an independent attack on that thread's own work. The artefact is saved verbatim in
`red-team-skills-vs-agents-2026-10-29-artefact.md`.

No library agent ran, so no `agent-improver` review is owed (close-out: built-ins have no
editable definition).

## Brief (verbatim, paths as sent)

> You are an independent red team. Another Claude wrote an answer for the owner (Justin) about whether to use skills, agents or plain Claude, and how to make the model reliably work to an expert standard. Attack it as hard as the evidence allows. You did not write it and owe it nothing.
>
> Inputs: the artefact (scratchpad copy of the file beside this one); the method `/home/user/agent-skills-library/.claude/skills/red-team/SKILL.md` (Mode 2 plus Mode 1, five non-negotiables); the library at `/home/user/agent-skills-library` (agents, skills, ledgers, work-samples incl. agent-vs-house rounds 1 and 2, account-sync-drift, mc-usage-check; cpo references); the app repos `/home/user/BalanceTRI-app`, `/home/user/BalanceBolt`, `/home/user/tri-momentum`.
>
> Hunt: whether the evidence supports "mostly plain Claude"; factual errors (verify every number, count, date, file claim); contradictions with the library's own rules; whether "Claude already knows SCR/Six Hats" loses house content; whether the persona claim is sourced; whether the standing-rules block would fire reliably; missing options or risks; and what holds up.
>
> Constraints: read-only; no member data; don't invent objections.
>
> Return (≤900 words): steelman; findings Fatal/Major/Minor with mechanism, evidence and what it should have said; verified-facts table; what survives; bottom line.

## Output (summary of the verbatim report; findings and evidence kept whole)

**Steelman.** Upkeep is real (18 agents, 39 skills, drifting copies, ledgers). The owner's own
tests found no detection advantage. Reliable "always" behaviour needs enforcement.

**Major findings**
1. "Agents rarely find more" overreaches. A ceiling effect in 11 of 12 contests, n=1–2, the
   fixture author scored round 2, 4 of 18 agents tested, house briefs not saved. The honest
   reading: no result on detection, agents won on house rules.
2. It ignored the real-work evidence. On 22 Oct, BalanceTRI-app #118: `mc-verifier` showed
   that mutations 5a and 5b survived, contradicting the implementer, and the register reads
   "Verifier was right". `security-auditor` F1 MEDIUM and F2 LOW were fixed
   (`mc-orchestrator-2026-10-22-registers.md:507,555,575`). tri-momentum decisions 32 and 34:
   independent `mc-reviewer` caught four defects self-review had passed.
3. It cut `agent-improver`, the only clear agent win and the engine of the improvement loop.
4. It broke `portfolio.md`'s rules: no cited runs, nothing on what is lost, no reversal
   condition, and "overlap" claimed between agents on different tiers. Keeping the mc pair
   outright pre-empted the 31 Dec test.
5. The rules block contradicts itself ("Before answering…" vs "Lead with the answer"), would
   fire on every reply, and duplicates AGENTS.md. All 16 agent replies on record broke their
   length caps (`CHANGELOG.md:176`).
6. The privacy grep can't catch names without a member list. Emails only. BalanceBolt has no
   CI.

**Minor findings.** Framework skills carry house procedure (SCR memo questions, issue-tree
icare and confidence grading). Stopping claude.ai uploads may break Chat. The persona claim
was uncited: verified as Zheng et al., EMNLP 2024 Findings (arXiv 2311.10054v3), no gain on
factual QA. Internal slips: `justin-voice` both kept and merged, "8" agents where 9 were
listed, a non-existent "repo conventions" skill, the cost argument inverted, `red-team` not
kept.

**Verified facts.** 18 agents (true), 39 skills (true), 24 drifted (true, many by 1–15 lines),
round results (true), "a third of the tokens" (round 2; round 1 says a quarter), mc usage
(true, but the run was production), four research skills (true), app privacy checks (none
exist).

**Survives.** Enforcement over skills for "always". One source of truth. The beat-plain-Claude
bar. Keeping private-knowledge skills. Merging true neighbours. Keeping independent
reviewers.

**Bottom line.** Stands only with amendments: restate the evidence, keep `agent-improver`, make
each cut a portfolio proposal with a reversal condition, run a house-rule test first, fix the
rules block, narrow the privacy check, check plugin reach before stopping uploads.

## Disk-verified by the main thread afterwards
- `BalanceBolt/.github` does not exist (no CI).
- `mc-orchestrator-2026-10-22-registers.md` lines 505–507, 555 and 575 read as cited.
- `CHANGELOG.md:176` reads "every one of 16 agent replies ran 20–110% over".

## What it changed
Every amendment went into the revised plan. The library changes it led to (the admission
rule, `ADMISSIONS.md`, `scripts/check-admissions.sh`, the audit proposals in `portfolio.md`)
are logged in `CHANGELOG.md`, 2026-10-29.
