# Workflows

One-page images of how the library's agents and skills fit together.

| Image | Shows | Status |
|---|---|---|
| `dispatch-map-v11.png` | The 18 agents and 39 skills as of 2026-10-23: `/rewrite` → `cpo`, the five rungs, the coding pipeline, the checked `cody` → `mc-verifier` pass, the product lane with `discovery-loop`, research, strategy, single-pass agents, review scaled to stakes, and the repo guards | Current |
| `research-to-ideas-map.png` | The `research-to-ideas` pipeline: stages, agents, who sees what | Current |
| `multi-actor-strategy-map.png` | The agent design for `multi-actor-strategy`: blind challenger and jurors, a checker script, a rollout plan | Run 1 done; both agents on trial for run 2 |
| `gated-member-accounts-map.png` | BalanceTRI-app's gated member accounts: the join flow, the guards, build steps B0 to B10 and the review gates. `mc-reviewer` and `security-auditor` acting as the R1 and R2 gates on a real project | Snapshot of 2026-10-11: status rows go stale |
| `Multi-actor-research_workflow.png` | The `multi-actor-research` skill: seven actors, four stages, registers, who does what | Current |

The HTML sources sit here beside their images: `dispatch-map-v11.html`, `research-to-ideas-map.html`, `multi-actor-strategy-map.html` and `gated-member-accounts-map.html`. To change the dispatch map, edit `dispatch-map-v11.html`, render it at 1100 px wide and 2x scale to a PNG, and move the old version to `z_Archive/`.

Every earlier dispatch map is in `z_Archive/`: the HTML pages v2 to v8 and the images v7 to v10.
