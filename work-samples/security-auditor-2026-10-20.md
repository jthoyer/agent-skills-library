# security-auditor — 2026-10-20 — A/B of the new intent-audit step (step 0)

## Set-up
- Fixture: a small club app (server/api.py, web/bookings.js, docs/permissions.md, docs/data-classes.md) with three planted intent gaps:
  - I1 `export_bookings` has no ownership check; only the UI hides the button. Permissions: members see no one else's bookings.
  - I2 `public_squad_list` returns phone numbers on a no-login view. Data classes: phones are personal, never public.
  - I3 `delete_member` is admin-only in code, but the permissions doc has no delete row (stale docs, not a vulnerability).
  - Decoys: `get_bookings` and `coach_squad_bookings` are correctly enforced.
- Arm A: `security-auditor` as loaded in the session (definition before this change), dispatched.
- Arm B: plain Claude (opus) told to follow the edited definition at `.claude/agents/security-auditor.md` and `.claude/references/intent-audit.md`. The edited agent could not be dispatched: the session's agent roster loads at start.
- Same brief to both: "Security review of the small app … findings ranked by severity with file and line, the exploit scenario and the fix, then your scope note. At most 400 words."

## Result (scored by the main thread against the key: reduced independence, the same thread wrote fixture and change)
| | Arm A (old) | Arm B (new step) |
|---|---|---|
| I1 | Found (CRITICAL) | Found (CRITICAL) |
| I2 | Found (CRITICAL) | Found (CRITICAL) |
| I3 | Missed: listed `delete_member` as "correct checks" | Found: "deleting members is admin-only in code but not in the permissions doc" |
| Decoys flagged as vulnerabilities | None | None (both noted the admin mismatch on `coach_squad_bookings` as non-security: A in hardening, B as a docs question) |
| Scope names intent docs found / missing | No | Yes: permissions and data classes found; architecture, secrets, test coverage missing |
| Extra | CSV column dump via `r.values()` (useful) | Admin blocked on `coach_squad_bookings`, framed as "ask the owner which is right" (per intent-audit §3) |
| Tokens | 19.6k | 72.3k (general-purpose carries the full tool set; not the definition's cost) |

## Reading
The step adds what it claims: documented-versus-enforced comparison, the stale-docs flag and an honest scope line. Both arms found the two exploitable gaps, because the docs sat in plain view; the gain is the third class and the scope note, not detection of the obvious.

## Review of the change (delegated)
`agent-improver`, 2026-10-20: approve after fixes, reduced independence noted (the A/B was built and
scored by the authoring thread). 1 High (inferred table unconditional), 3 Medium (comparison buried
in step 0; "ask the owner" unenforceable read-only, and hygiene items leaking into ranked findings;
no stated boundary with `mc-reviewer`), 4 Low (scope wording, a policy sentence, the description
line, this sample's decoy row). All verified and applied before merge. Arm B was general-purpose
following the edited file, not the dispatched agent; a dispatched run of the merged agent is owed.
