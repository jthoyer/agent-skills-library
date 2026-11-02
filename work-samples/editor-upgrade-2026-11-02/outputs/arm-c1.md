# Text 1. Race-day transition briefing

## Summary of changes
I turned the paragraph into numbered steps in the order members do them on the day, and gave the helmet rule a clear warning.

## Edited version

**Transition**

Transition opens at 5:30am. Arrive early so you have time to organise your gear.

**Before the swim**

1. Rack your bike by its seat post.
2. You can lay your gear out on a small towel next to the front wheel.

**After the swim**

3. Take off your wetsuit in the change area. Do not take it off at the rack, because the rack area gets slippery.
4. **WARNING: Buckle your helmet before you unrack your bike.** An unbuckled helmet is a crash risk. Officials check helmets, and an unbuckled helmet means instant disqualification.
5. Unrack your bike.
6. Mount your bike after the mount line, not before.
7. If marshals are at the mount line, follow their directions.

**After the ride**

8. Re-rack your bike.
9. Turn your race belt so that your number is at the front.
10. Start the run.

## Key improvements
1. **Order**: The wetsuit rule sat after the bike mount. I moved it to where it happens, straight after the swim.
2. **One action per step**: "Re-rack and then head out on the run" is now two steps, with the race belt between them.
3. **Helmet warning**: The command now comes first, then the two reasons (crash risk, disqualification).
4. **Note turned into a step**: The wetsuit rule was hidden in a "Note:". It is now step 3.
5. **Direct instructions**: "You should", "you'll want to" and "should be done by" are now plain commands. "You may want to" (the towel) is now "you can", because it is optional.
6. **Condition first**: "If marshals are at the mount line, follow their directions."

**Two things to check:**
- **Seat post racking.** Is this a race rule or just good practice? I've written it as a plain instruction. If it's a rule, I'd add "You must".
- **"etc." after the race belt.** I cut it. If there's more to do before the run (cap, sunglasses, nutrition), tell me and I'll add the steps. You may also want a step for the dismount line, which the briefing doesn't mention.

## Suggestions for future writing
- Put any rule that could disqualify someone in its own numbered step, not in a note.

---

# Text 2. README setup section

## Summary of changes
I turned the paragraph into numbered steps, put the dry run before the real run, used one name for the config file, and turned "be careful" into a clear caution.

## Edited version

## Setup

1. Make sure that your `.env` file is in place. If it is missing, the script fails with `ERR_NO_CONFIG`.
2. Add your API key and the target database to the `.env` file.
3. Run `npm install`.
4. Run `npm run sync -- --dry-run` to see what the script will change before it changes anything.
5. Run `npm run sync`.

   **CAUTION: Do not use the `--force` flag against production.** It can delete rows that do not match the source.

6. If the first run times out, run `npm run sync` again.

## Key improvements
1. **One name for the file**: "config file", "settings file" and ".env" now all read "`.env` file". I've assumed they are the same file, because the missing-file error is `ERR_NO_CONFIG`. If they are different files, tell me and I'll split them out.
2. **Step order**: The dry run now comes before the real sync, which is when a reader needs it.
3. **One action per step**: `npm install` and `npm run sync` are separate steps.
4. **Condition first**: "If the first run times out, run `npm run sync` again" replaces "you may need to run it twice if…".
5. **Caution**: "Be careful" didn't say what to do. The caution now gives the command first, then the risk of lost data. If `--force` on production is ever legitimate, tell me when and I'll write that in instead of a flat "do not".
6. **Plainer words**: "utilise" → "run", "prior to" → "before", "in the event that" → "if", "ensure" → "make sure that". Commands and the error code are unchanged.

## Suggestions for future writing
- Say where the `.env` file lives (project root?). A new reader will look for it.

---

# Text 3. Review agent instructions

## Summary of changes
I addressed the agent as "you" throughout, put the stop condition right after reading the spec, and made each permission and ban unambiguous.

## Edited version

You are the reviewer for this pull request. Do not edit files.

1. Read the spec.
2. If the diff touches auth or payments:
   1. Stop the review.
   2. Report back to the integrator.
3. You can run tests if they help the review.
4. You can flag style issues.
5. Produce a findings list ranked by severity, most severe first.

## Key improvements
1. **One name for the agent**: The original called it "the reviewer", "the checker", "the auditor" and "you". An agent may read those as four different roles and ignore rules aimed at the others. It is now "you" throughout, with "the integrator" as the only other party. I've assumed checker and auditor meant this same agent.
2. **Stop condition moved up**: The auth/payments check now comes straight after the spec, so the agent stops before it spends effort on a review it should hand back.
3. **Condition first, one action per step**: "If the diff touches auth or payments" leads, and "stop" and "report" are separate sub-steps.
4. **Clear permissions**: "May run tests if it seems useful" is now "can run tests if they help the review". "Should never edit files" is now a flat "Do not edit files", near the top where the agent can't miss it.
5. **Plainer words**: "i.e. most severe first" is now "ranked by severity, most severe first".

**One thing to check:**
- **Style issues.** "Could flag style issues too" can mean "you're allowed to", "please do" or "only if they matter". I've written "you can". If you want style issues every time, change it to "Flag style issues." If you want them kept out of the main findings, tell me and I'll add that.

## Suggestions for future writing
- Pick one name for each agent and use it in every sentence. Agents take a new name to mean a new role.

---

# Text 4. Member update paragraph

## Summary of changes
One typo fixed. Everything else stays as you wrote it.

## Edited version

What a weekend! Forty-two of us lined up at Husky, and the energy on the beach was something else. Sarah finished her first Olympic distance after two DNFs last season – there wasn't a dry eye at the finish chute. Huge thanks to the volunteers who handed out more bananas than anyone thought possible. We'll be back next year, hopefully with even more of you in green.

## Key improvements
1. **Typo**: "more bananas then anyone thought possible" → "more bananas than anyone thought possible".

The rest reads well and sounds like you: warm, quick and specific. I left it alone on purpose. Tightening it further would flatten the voice.
