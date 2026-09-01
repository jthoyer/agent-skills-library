# 10x — retired 2026-08-18

Archived unmodified from `~/.claude/agents/10x.md`. Superseded by the **`first-principles` skill**
(`~/.claude/skills/first-principles/SKILL.md`), invoked by `prody`'s launch check against recent work.

Retired under the necessity test: the job is single-pass ideation over work already in view. It never
once ran as a dispatched agent — all three `10X-LOG.md` entries were produced by `prody` embodying it
in the main thread, which is exactly a skill. A cold dispatched context is in fact *worse* here,
because it cannot see the recent work the recommendation is supposed to be about.

The once-a-day throttle and `~/.claude/agents/10X-LOG.md` survive as `prody` launch-check mechanics,
not as agent behaviour. See `~/.claude/agents/CHANGELOG.md`, 2026-08-18.

Reversal: restore if the daily check stops firing, or produces visibly worse recommendations, once
run as a skill for two weeks.
