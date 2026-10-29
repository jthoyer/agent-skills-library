# Red-team report, verbatim — 2026-10-29

Delegated `general-purpose` (opus). The brief and the summary are in `red-team-skills-vs-agents-2026-10-29.md`.

---

## 1. Steelman
The library spends a lot on upkeep: 18 agents, 39 skills, two copies that drift apart, and ledgers to maintain. The owner's own tests found no detection advantage for agents over the house model. Instructions that are meant to apply "always" are only reliable when something enforces them (hooks, CI, a reviewer). So a small rules block, a few skills holding things only Justin knows, and independent reviewers kept for high-stakes work is a reasonable target.

## 2. Findings (most severe first)

**Major 1: "Agents rarely find more than plain Claude" claims more than the evidence can show.** The tests hit their ceiling: in 11 of 12 contests, both sides found every planted defect. A test where everyone scores perfectly can't separate the two sides, so it can't show that agents add nothing. The evidence files say so themselves. Round 1 says "Ceiling effect… A harder round… is needed" and "n = 1… read slight margins as noise". Round 2 says "scored by the author of the fixtures… before anything is concluded", and "A fixture that needs a house rule to find the defect at all… has not been built" (`work-samples/agent-vs-house-*.md`). The fixtures were small toy examples. Only 4 of the 18 agents were tested, yet the answer cuts about 10. The briefs for the house side weren't saved, so we can't tell how much expertise the brief itself supplied. The answer should have said: "Inconclusive on detection: the test couldn't discriminate. Agents won every house-rule behaviour that was measured."

**Major 2: It ignores the only evidence from real work, which favours agents.** On 22 Oct the full pipeline shipped BalanceTRI-app #118, a change to who may edit what (RLS). mc-verifier showed the implementer's claim was false (mutations 5a and 5b survived), and the register records "Verifier was right." security-auditor raised F1 MEDIUM and F2 LOW, both fixed (`mc-orchestrator-2026-10-22-registers.md:507, 555, 575`). tri-momentum's CLAUDE.md (decisions 32 and 34) records an independent mc-reviewer catching four defects that self-review had already signed off as verified. The answer counts the 22 Oct run as "one run each", i.e. as a usage statistic, and never mentions what it found.

**Major 3: It cuts the one agent that won.** agent-improver took the only clear agent win in round 1 (5 found plus 1 partial, against 3 plus 2 partial plus 1 missed). It was also the most-used agent (14 delegated mentions) and drives the improvement loop (`portfolio.md`: "Paste the latest one into every agent-improver… brief"). It isn't on the keep list. Losing the improvement loop isn't discussed anywhere.

**Major 4: It breaks the library's own decision rules without saying so.** `cpo/references/portfolio.md` requires, for each retirement:
- cited CHANGELOG runs ("These feel similar is not a finding"),
- a statement of what is lost,
- a reversal condition,
- owner approval,
- an independent source.

It also says agents with different tool sets or model tiers "are not duplicates". The answer gives "code-improver overlaps mc-reviewer" (sonnet versus opus) and "neighbours compete" with no evidence. It also keeps mc-reviewer and mc-verifier unconditionally, which pre-empts the open 31 Dec retire test that the answer says to "extend". The 22 Oct verifier finding may already meet half of that test's bar.

**Major 5: The standing-rules block contradicts itself and would fire on every reply.** It starts "Before answering: name the audience… state assumptions…" and ends "Lead with the answer." Those pull in opposite directions. Applied to every trivial reply, it adds ritual text. The ledger shows that the agents' own built-in rules don't hold reliably either: "every one of 16 agent replies ran 20–110% over" their length caps (`CHANGELOG.md:176`). That supports the answer's point that only enforcement works, but it also undercuts its rating of the rules block as "high while short". Some of the rules are already in the app repos' AGENTS.md (no member data, ask before irreversible steps), so adding them again is duplication.

**Major 6: The proposed privacy check can't be built as described.** You can't write a pattern that matches unknown real names without a list of members, and that list would itself be member data. Only emails are catchable (allow-list `example.test`). BalanceBolt also has no CI at all (no `.github/`), so "add to each app repo's CI" first means creating CI there.

**Minor 1: "Claude already knows these" is only partly true.** The framework skills carry house procedure and context that a bare name won't bring with it:
- scr-pyramid-communicator's short-memo mode asks three audience questions and has its own 1-pager format,
- issue-tree has an icare section and Playbook confidence grading,
- made-to-stick and high-output-management have icare applications.

The knowledge is generic; the defaults and formats are Justin's. Folding them into a "thinking toolkit" would lose these silently.

**Minor 2: "Stop claude.ai uploads" may remove skills from claude.ai Chat.** The library's own README says the plugin covers Claude Code, while Chat "reads whatever's uploaded". Whether claude.ai Chat can load this plugin isn't checked.

**Minor 3: The persona claim is uncited and stated a little loosely.** I verified it by search: Zheng et al., EMNLP 2024 Findings (arXiv 2311.10054v3), found that personas did *not* improve factual-QA accuracy, and that the best persona was no easier to predict than chance. The earlier v1 claimed gains. The study measured factual accuracy, not expert-standard output. Anthropic's own docs recommend role prompting. "Small, inconsistent gains" is roughly fair, but it should say what was measured and cite the paper.

**Minor 4: Internal inconsistencies.**
- justin-voice is on the keep list and is also among the "writing four" to be merged.
- Cost is cited as an agent advantage, then the answer recommends the more expensive option (plain Claude). The round 1 file also says the token gap is "mostly the house arm's overhead".
- The keep list names 9 agents, not 8.
- "Repo conventions" is listed as a skill to keep, but no such skill exists.
- red-team isn't on the keep list.

## 3. Verified facts
| Claim | Verdict | Source |
|---|---|---|
| 18 agents | True | `ls .claude/agents`; `check-frontmatter.sh --list` |
| About 40 skills | True (39) | same |
| 24 copies drifted on 18 Oct | True (many by only 1–15 lines) | `account-sync-drift-2026-10-18.md` |
| Round 1: one win each, two ties | True | `agent-vs-house-2026-10-20.md` |
| Round 2: all eight runs found every defect | True | round2 file |
| About a third of the tokens | True for round 2; round 1 says a quarter | both files |
| mc-planner/integrator: no use on 29 Sep, one run each on 22 Oct | True, but that run was a merged production feature | `mc-usage-check`; `mc-planner-2026-10-22.md` |
| Four research skills | True | `skills/README.md` |
| App repos already have privacy checks | False: none have one; BalanceBolt has no CI | `.github/` in the three repos |
| Persona gains small and inconsistent | Roughly fair (actually no gain); not cited | arXiv 2311.10054v3 |

## 4. What survives
- "Always" needs enforcement, not a skill: this is correct and backed by the repo's own data.
- A single source of truth and drift reduction.
- Making "beat plain Claude on a fixture, or enforce a rule it breaks" the bar for anything new.
- Keeping the skills that hold things only Justin knows (voice, brand, job-scan, Australian tax).
- Merging overlapping neighbours to cut routing confusion.
- Keeping independent read-only reviewers.

## 5. Bottom line
The verdict stands only with amendments. As written, "build about a third" is a guess presented as a finding.

1. Restate the test result as inconclusive on detection and favourable to agents on house rules, and cite the 22 Oct real-work findings.
2. Keep agent-improver, or say what replaces the improvement loop.
3. Make each cut a portfolio proposal with its evidence, what is lost, and a reversal condition. Leave the 31 Dec retire test to decide mc-reviewer and mc-verifier.
4. Run one test where finding the defect needs a house rule before cutting anything untested.
5. Fix the rules block: answer first, apply it only to substantive replies, and drop rules already in AGENTS.md.
6. Narrow the privacy check to emails, and note that BalanceBolt needs CI first.
7. Check whether the plugin reaches claude.ai Chat before stopping uploads.

Sources: [arXiv 2311.10054v2](https://arxiv.org/abs/2311.10054v2), [ACL Anthology, EMNLP 2024 Findings 888](https://preview.aclanthology.org/new-sigs/2024.findings-emnlp.888/), [GitHub: Prompting-with-Social-Roles](https://github.com/Jiaxin-Pei/Prompting-with-Social-Roles)
