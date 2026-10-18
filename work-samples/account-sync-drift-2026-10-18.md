# Account-synced skills vs library repo — 2026-10-18

Method: compared each skill in the session's account-synced set (claude.ai settings, surfaced as `anthropic-skills:<name>`) with `.claude/skills/<name>/SKILL.md` at library `dae810c`. Diff lines counted after stripping quote marks, so YAML quoting alone counts as 0.

| Skill | Diff lines | Repo version | Synced version |
|---|---|---|---|
| pre-mortem | 626 | 1.1.0 | 1.0.0 |
| value-proposition-canvas | 602 | 1.1.0 | 1.0.0 |
| editor | 253 | 1.0.0 | 2.0.0 |
| deep-research | 250 | 1.0.0 |  |
| cpo | 131 | 2.0.0 | 1.0.0 |
| rewrite | 49 | 2.0.0 | 1.3.1 |
| jobs-to-be-done-jtbd | 35 | 1.1.2 | 1.1.0 |
| humanizer | 20 |  |  |
| skills-librarian | 15 | 2.3.0 | 2.3.0 |
| research-to-ideas | 15 |  |  |
| market-analyst | 14 |  |  |
| recent-pulse | 13 | 1.1.0 | 1.1.0 |
| job-scan | 13 | 1.2.0 | 1.2.0 |
| project-management | 12 |  |  |
| product-requirement-document | 10 |  |  |
| etf-investing-coach | 10 |  |  |
| balance-tri-club-brand | 10 |  |  |
| justin-voice | 9 | 1.2.0 | 1.2.0 |
| etf-investing-advisor | 4 |  |  |
| multi-actor-strategy | 3 |  |  |
| multi-actor-research | 3 |  |  |
| youtube-explainer | 2 |  |  |
| terse-mode | 2 | 1.0.0 | 1.0.0 |
| notion-second-brain | 1 |  |  |

Identical (18, quote marks ignored): academic-researcher, business-case-builder, content-research-writer, cos, customer-insight, first-principles, high-output-management, issue-tree, made-to-stick, mc-orchestrator, positioning, read-the-room, red-team, resume-builder, scqa-framework, scr-pyramid-communicator, six-thinking-hats, triathlon-coach

## Notable
- Synced `rewrite` is 1.3.1 and launches `prompt-refiner` (retired 2026-10-13). `/anthropic-skills:rewrite` did not resolve this session.
- Synced `cpo` is 1.0.0: it tells the main thread to follow `agents/CPO.md`, which now exists only in `.claude/skills/_retired/CPO/`.
- Synced `pre-mortem` (637 lines) and `value-proposition-canvas` (599 lines) are the pre-trim versions; the repo cut them to 59 and 139 lines on 2026-09-05/06.
- Synced `editor` (2.0.0, 79 lines) and `deep-research` (with `references/researcher.md`, `report-writer.md`) are not in the repo's history — different products under the same name, or edits made only in claude.ai.
- Synced `mc-orchestrator` and `cos` differ only by YAML quoting, so they count as identical above.
- 17 synced skills have no repo counterpart (Anthropic-provided: docx, pdf, pptx, xlsx, skill-creator, etc. plus `morning`, `import-memory`).
