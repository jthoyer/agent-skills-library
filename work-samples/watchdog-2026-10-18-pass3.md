# watchdog — review of the merge commit d30afcc, 2026-10-18 (delegated)

Brief: read-only review of the three skill merges, four retirements and Low items against the archived originals; check content loss, stale names, contradictions, trimmed triggers and ledger accuracy. ≤400 words.

Findings (all fixed in the following commit):
1. Medium — scr intake asked twice (SKILL.md Step 1 vs scqa-short-memo Step 0). Fixed: short-memo mode skips Step 0 when Step 1 settled it.
2. Medium — README "Twelve skills carry references/ … other 29" stale. Fixed: Thirteen (adds customer-insight), other 24.
3. Medium — the retired pre-mortem's red-team boundary was lost. Fixed: six-thinking-hats description points to red-team.
4. Low-Med — skills-librarian change-safety still snapshotted /mnt and said "all four" over five steps. Fixed: edit in the repo on a branch; git history is the snapshot.
5. Low — two one-page templates in scr; "product briefs" collided with PRD. Fixed: short-memo mode names its 1-pager; PRD boundary added.
6. Low — no `_superseded-by.md` for the four retirements. Fixed: one each.
7. Low — pre-mortem content not carried: solo running, design/security-review redirect, first-principles pointer, Kahneman. Fixed.
8. Low — VPC self-reference; "entering a new segment", "jobs-oriented organisation" triggers missing. Fixed.
9. Low, pre-existing — the ~30% finding credited to Klein; it is Mitchell, Russo & Pennington (1989). Fixed.

Cleared: no live file names the retired skills; routing.md agrees with parents; counts 38 everywhere; SCQA/VPC bodies verbatim.
