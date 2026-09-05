# Work samples

Durable store for agent output that `agent-improver` needs to score **Dimension 6 (observed performance)**.

**Why this exists.** Work samples were previously written to the per-session `/private/tmp/claude-501/<project>/<uuid>/scratchpad/` directory. That is session-scoped and project-scoped, so samples scattered across unrelated project directories and were unreachable by the next review. On 2026-09-05 a tree-wide `find` returned four surviving samples across four directories — and the one the ledger had explicitly ordered graded (`code-improver`'s Balance bolt output, follow-up written 2026-09-04) was **not** among them. A user-signed-off trial lapsed on lost evidence rather than on a verdict.

**Naming:** `<agent>-<YYYY-MM-DD>.md` (add `-passN` if one run produced several).

**Contents:** the brief verbatim, the output verbatim, and any disk-verified outcome data — the four things `CPO.md` step 5 requires handing to `agent-improver`.

**This directory is committed.** That is the point: a sample that only exists in a temp directory is not evidence.
