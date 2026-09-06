# content-writing — retired 2026-09-06

Archived unmodified (as of v1.0.2) from `.claude/skills/content-writing/SKILL.md`.
Superseded by **`content-research-writer`** (`.claude/skills/content-research-writer/SKILL.md`).

## Why

Both skills applied the **same methodology** — Ann Handley's *Everybody Writes* — to the **same
trigger surface** (blog posts, email, social, thought leadership). `content-research-writer` is a
strict superset: same methodology, plus collaborative research, citation management, and
section-by-section feedback, plus explicit coverage of Justin's actual projects (triathlon club
comms, icare programme narratives).

`content-writing` was an unmodified third-party import (`author: ClawFu`). It arrived carrying five
dead `Related Skills` links pointing at skills that never existed in this library, a
"What Claude Does vs What You Decide" table whose rows described **video production**, and a
`Skill Boundaries` section about **audio engineering**. All were repaired on 2026-09-05, but the
duplication underneath them was not.

## The evidence

A blind three-condition gauntlet on 2026-09-06 (`skills-librarian` workflow 6). Three realistic
writing tasks — a club blog post, a flat newsletter opening to rescue, and a research-grounded
argument piece. Three conditions: no skill at all, `content-writing`, `content-research-writer`.
Positions were randomised per task **by script**, and a separate agent graded all nine outputs
blind to which condition produced which.

| Condition | Placings (1 = best) | Average |
|---|---|---|
| `content-research-writer` | 1, 1, 2 | **1.33** |
| no skill at all | 3, 2, 1 | 2.00 |
| `content-writing` | 2, 3, 3 | 2.67 |

- **`content-writing` lost to `content-research-writer` on all three tasks — 0 of 3.**
- **`content-writing` lost to using no skill at all on two of three tasks.**

That second line is what settles it. Under this library's own retirement criteria, a skill that
performs worse than the no-skill baseline is not a rewrite candidate — it is a retirement
candidate. Keeping it also meant two skills competing for the same trigger, which makes *both*
fire unreliably.

The blind grader's note on the losing margin: on the research task, `content-writing` produced
genuinely real, verifiable, accurately-represented citations (the grader fact-checked them), but
offered **no disclosure at all** about how far it had verified them — the exact failure mode the
requester had asked to avoid. The no-skill condition won that task purely by being honest about
what it had not checked.

## Caveats, stated plainly

One sample per condition per task, three tasks, one grader. The head-to-head result is clean
(0 of 3) rather than marginal, which is why this was actioned — but it is not a large study.

## Reversal

Restore if `content-research-writer` proves worse at short-form work (social posts, subject lines)
than the retired skill was, or if its research/citation layer gets in the way of a quick draft.
Restoring is `git mv` back, or recovering from git history.

See `.claude/skills/CHANGELOG.md`, 2026-09-06.
