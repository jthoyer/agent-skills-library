# Scores: editor upgrade blind grading (2026-11-02)

Grader read only `briefs/grader-brief.md`, `briefs/task-brief.md`, `answer-key.md` and
`blinded/reply-A.md` to `reply-D.md`. Scores are based on the edited text. Change notes were used only to check
whether a flag was raised.

## Totals

| Reply | Text 1 (6) | Text 2 (6) | Text 3 (5) | Text 4 (4) | Total (21) |
|---|---|---|---|---|---|
| A | 6 | 6 | 5 | 4 | **21** |
| B | 6 | 6 | 5 | 4 | **21** |
| C | 4 | 5 | 4 | 4 | **17** |
| D | 4 | 5 | 4 | 4 | **17** |

C and D drop the same three separating points: K1.4 (the towel), K2.2 (`--force` command)
and K3.2 (a "may" left in). Both also miss K1.5 (belt and run order).

---

## Reply A: 21/21

**Text 1**
- K1.1 **1**: "**WARNING: Buckle your helmet before you unrack your bike.** An unbuckled helmet is a crash risk…": command first, risk after.
- K1.2 **1**: "Mount your bike after the mount line, not before." / "If marshals are at the mount line, follow their directions.": split, condition first.
- K1.3 **1**: "3. Take off your wetsuit in the change area.": a step, no "Note:".
- K1.4 **1**: "Rack your bike by its seat post." / "You can lay your gear out…": firm vs optional.
- K1.5 **1**: arrive → rack → towel → wetsuit (under "After the swim") → helmet → unrack → mount → re-rack → belt → "Start the run.": one per step, race order.
- K1.6 **1**: "etc." cut, "organise your gear", "5:30am", "your number is at the front".

**Text 2**
- K2.1 **1**: "`.env` file" throughout ("Add your API key and the target database to the `.env` file").
- K2.2 **1**: "**CAUTION: Do not use the `--force` flag against production.** It can delete rows…"
- K2.3 **1**: step 4 dry run, step 5 `npm run sync`.
- K2.4 **1**: "If the first run times out, run `npm run sync` again."
- K2.5 **1**: "Make sure that", "before", "If it is missing", "utilise" gone.
- K2.6 **1**: `npm run sync -- --dry-run`, `ERR_NO_CONFIG` exact. "behaviour" not retained (allowed).

**Text 3**
- K3.1 **1**: "You are the reviewer…": "you" throughout, checker/auditor gone.
- K3.2 **1**: "You can run tests…", "You can flag style issues.", "Do not edit files.": no should/may/could.
- K3.3 **1**: "If the diff touches auth or payments: 1. Stop the review. 2. Report back to the integrator."
- K3.4 **1**: "Read the spec.", "Do not edit files.", "Produce a findings list…"
- K3.5 **1**: "ranked by severity, most severe first": i.e. gone. All five rules present.

**Text 4**
- K4.1 **1**: "What a weekend!", "something else", "there wasn't a dry eye", "Huge thanks" intact.
- K4.2 **1**: unchanged prose, contractions and "hopefully" kept.
- K4.3 **1**: "more bananas than anyone".
- K4.4 **1**: Forty-two, Husky, first Olympic, two DNFs last season, green.

## Reply B: 21/21

**Text 1**
- K1.1 **1**: "WARNING: Buckle your helmet before you unrack your bike. An unbuckled helmet is a crash risk. Officials check this…"
- K1.2 **1**: "Mount your bike after the mount line, not before." / "If marshals are present, follow their directions."
- K1.3 **1**: "4. Remove your wetsuit in the change area, not at the rack.": a step.
- K1.4 **1**: "Rack your bike by the seat post." / "You can lay your gear out…"
- K1.5 **1**: "Arrive early" → rack → towel → wetsuit → helmet → mount → re-rack → belt → "Start the run."
- K1.6 **1**: "etc." cut, "organise your gear", "5:30am", "number at the front".

**Text 2**
- K2.1 **1**: "`.env` file" throughout. "If the `.env` file is missing…"
- K2.2 **1**: "CAUTION: Do not use the `--force` flag against production. It can delete rows…"
- K2.3 **1**: step 3 dry run, step 4 `npm run sync`.
- K2.4 **1**: "If the first attempt times out, run `npm run sync` again."
- K2.5 **1**: "Make sure that", "To preview…" (no utilise), no "prior to", "If the `.env` file is missing".
- K2.6 **1**: commands and `ERR_NO_CONFIG` exact. "the script's behaviour" keeps British spelling.

**Text 3**
- K3.1 **1**: "You are the reviewer…": "you" throughout.
- K3.2 **1**: "Never edit files.", "If the tests will help your review, run them.", "You can also flag style issues.": no should/may/could.
- K3.3 **1**: "Check whether the diff touches auth or payments. If it does: a. Stop the review. b. Report to the integrator."
- K3.4 **1**: "Read the spec.", "Never edit files.", "list your findings…"
- K3.5 **1**: "in order of severity, most severe first": i.e. gone. Tests are still conditional, and all rules are kept.

**Text 4**
- K4.1–K4.4 **1 each**: text identical to the original except "than anyone". Voice, contractions, "hopefully" and all facts kept.

## Reply C: 17/21

**Text 1**
- K1.1 **1**: own step "3. **Before you unrack.** Buckle your helmet before you unrack your bike. Officials check this…": command first, risk after. It has no WARNING label, but the key accepts its own step.
- K1.2 **1**: "Don't get on your bike until you've crossed the mount line. If marshals are there, follow their directions."
- K1.3 **1**: "2. **After the swim.** Take your wetsuit off in the change area": a step, "Note:" dropped.
- K1.4 **0**: "Lay your gear out on a small towel next to the front wheel.": the optional towel is now a firm command.
- K1.5 **0**: "Re-rack your bike, then head out on the run. Turn your race belt so your number faces the front.": two actions per sentence, and the belt comes after the run starts.
- K1.6 **1**: "etc." cut, "5:30am", "number faces the front". "organise" became "set up", but no US spelling was introduced.

**Text 2**
- K2.1 **1**: "`.env`" throughout.
- K2.2 **0**: "**Warning:** Take care using `--force` against production.": it restates "be careful" and gives no clear do/don't command. It also sits after the sync step.
- K2.3 **1**: step 3 dry run, step 4 sync.
- K2.4 **1**: "If the first attempt times out, run it again."
- K2.5 **1**: "Make sure", "Preview… without applying anything", "If `.env` is missing".
- K2.6 **1**: commands and `ERR_NO_CONFIG` exact. "behaviour" was dropped (allowed).

**Text 3**
- K3.1 **1**: "you" throughout, checker/auditor gone.
- K3.2 **0**: "You may also flag style issues.": "may" left, and the notes don't flag it as ambiguous.
- K3.3 **1**: "If the diff touches auth or payments, stop and report back to the integrator."
- K3.4 **1**: "Read the spec first.", "Never edit files.", "produce a list of findings…": the commands are imperative. The leftover "may" is scored under K3.2.
- K3.5 **1**: "ranked by severity, most severe first": i.e. gone. All rules kept.

**Text 4**
- K4.1–K4.4 **1 each**: identical apart from "than". Voice and facts kept.

## Reply D: 17/21

**Text 1**
- K1.1 **1** (borderline): "Buckle your helmet before you unrack your bike. Officials check this: an unbuckled helmet means instant disqualification, and it's a crash risk.": its own paragraph, command first, risk after. It isn't numbered or labelled.
- K1.2 **1**: "Mount your bike after the mount line, not before. If marshals are there, follow their directions."
- K1.3 **1**: "After the swim, take your wetsuit off in the change area…": a plain instruction, no "Note:".
- K1.4 **0**: "Rack your bike by the seat post and lay your gear out on a small towel…": the towel is now mandatory.
- K1.5 **0**: "re-rack your bike and head out on the run. Turn your race belt…": the actions are combined, the belt comes after the run, and rack plus towel share one sentence.
- K1.6 **1**: "etc." cut, "5:30am", "number is at the front". "organise" became "set up" (no US spelling).

**Text 2**
- K2.1 **1**: "`.env`" throughout.
- K2.2 **0**: "**Warning:** using `--force` against production can delete rows…": risk only, with no command at all.
- K2.3 **1**: step 3 dry run, step 4 sync.
- K2.4 **1**: "If the first attempt times out, run it again."
- K2.5 **1**: "Make sure", "Without it", "Preview what the sync will do". All four phrases are gone.
- K2.6 **1**: commands and `ERR_NO_CONFIG` exact.

**Text 3**
- K3.1 **1**: "you" throughout.
- K3.2 **0**: "You may also flag style issues.": "may" left, not flagged.
- K3.3 **1**: "If the diff touches auth or payments, stop and report back to the integrator."
- K3.4 **1**: "Read the spec first.", "Never edit files.", "produce a list of findings…"
- K3.5 **1**: "ranked by severity, most severe first": i.e. gone. All rules kept.

**Text 4**
- K4.1–K4.4 **1 each**: identical apart from "than". Voice and facts kept.

---

## Ranking: which I would send to the client as-is

1. **B**: It hits every key item. Its notes are the tightest and it asks the right questions: are the config files the same, is `--force` ever safe, is "must contain" right? The CAUTION sits at the top of Setup, before anyone runs anything.
2. **A**: The edits are just as good, but the reply is heavier than a "short note" brief invites: summary, key improvements and an unrequested "Suggestions for future writing" for every text. The `--force` caution sits mid-list under step 5, not up front.
3. **C**: The numbered race-day steps are scannable, but the towel becomes compulsory, the belt comes after "head out on the run", the `--force` warning just says "take care", and "may" survives in the agent prompt.
4. **D**: It has the same errors as C, plus the race-day briefing stays prose (despite its note saying members can "scan it") and the `--force` warning gives no instruction at all.

## What the key missed

- **Meaning changes, flagged:** A and B turn "so be careful" into a flat "Do not use `--force` against production". That is stronger than the source, but both flag it and offer to soften it. B turns "should contain" into "must contain" and flags it. A rewrites "should contain" as an action ("Add your API key… to the `.env` file") without comment.
- **Meaning changes, not flagged:** C and D make the optional towel compulsory, and neither note mentions it. D's `--force` warning drops the source's instruction entirely ("be careful" becomes risk only).
- **Placement:** C and D put the `--force` warning after the sync steps, where a reader may already have run the command. A puts it under step 5. Only B puts it before step 1.
- **Agent prompt order:** C runs the optional tests (step 2) before the auth/payments stop check (step 3), so the agent may spend effort before learning it should hand back. A, B and D put the stop check straight after the spec.
- **Additions:** A adds an explicit "Unrack your bike" step, which is harmless. A and D suggest a dismount-line step in the notes only. D also suggests keeping the helmet buckled until re-racking. These are notes, not text changes.
- **Spelling:** C and D replace "organise your gear" with "set up". This is not an Americanisation, but the key's "organise kept" was arguably meant to test for that. Neither reply introduces US spellings.
- **No reply** changed any fact in Text 4. All four left it verbatim apart from "than".
