# mc-implementer — retired 2026-09-29

Archived unmodified from `.claude/agents/mc-implementer.md`. Superseded by the **`cody` agent**
(`.claude/agents/cody.md`), which now carries this actor's distinct discipline in its "Building
to an approved spec" section: build the spec, no more, no less; flag spec ambiguity rather
than reinterpreting it; never declare its own work verified. `mc-orchestrator` Stage 2 now
dispatches `cody` against the persisted Stage 1 spec.

Retired on the owner's yes ("Proceed with recommendations", 2026-09-29), adopting the
`multi-actor-strategy` agents run (`work-samples/multi-actor-strategy-2026-09-29-agents.md`,
decision brief step 2). Evidence: E10 in `work-samples/multi-actor-strategy-2026-09-29-inputs.md`.
`cody` implements coding tasks, frontend and backend, which is this actor's whole job, so the
two split one route. The rest of this file (UI accessibility pass, search for an existing
helper, harness vs product defect) was already in `cody.md`.

What is lost: a sonnet implementer with no web tools. `cody` holds `WebFetch`/`WebSearch` and
reads `.claude/references/external-content.md` before acting on fetched content.

See `CHANGELOG.md`, 2026-09-29 `library — portfolio` entry.

Reversal: restore this file (one `mv`) if a pipeline run shows `cody` expanding scope past the
spec or grading its own work in a way this actor's narrower mandate would have prevented.
