## Text 1. Race-day transition briefing

**Edited version**

Transition opens at 5:30am.

**Before the start**

1. Arrive early to organise your gear.
2. Rack your bike by the seat post.
3. You can lay your gear out on a small towel next to the front wheel.

**After the swim**

4. Remove your wetsuit in the change area, not at the rack. The rack area gets slippery.
5. WARNING: Buckle your helmet before you unrack your bike. An unbuckled helmet is a crash risk. Officials check this, and it means instant disqualification (DQ).
6. Mount your bike after the mount line, not before.
7. If marshals are present, follow their directions.

**After the ride**

8. Re-rack your bike.
9. Wear your race belt with the number at the front.
10. Start the run.

**What I changed**

- Put the steps in race order as numbered steps. The wetsuit point came after the mount line, but members do it straight out of the swim, so it now comes before the helmet.
- Turned the "Note" about wetsuits into a step, because it was an instruction.
- Made the helmet point a warning: the command first, then the reasons. I cut "obviously" and spelled out DQ.
- Split the run-on mount-line sentence, and put the marshal condition before the command.
- Swapped "you'll want to", "should be done" and "you should" for plain commands, and "you may want to" for "you can".
- Cut "etc." at the end.

**To check**

- Are seat-post racking and the mount line race rules, or just advice? I've written them as plain commands. If officials penalise either, say so, as you did for the helmet.
- "etc." suggested more to remember on the run. If there is more (hat, gels, bottle), list it as steps after step 9.

---

## Text 2. README setup section

**Edited version**

### Setup

CAUTION: Do not use the `--force` flag against production. It can delete rows that do not match the source.

1. Make sure that your `.env` file is in place. It must contain your API key and the target database.
   If the `.env` file is missing, the script fails with `ERR_NO_CONFIG`.
2. Run `npm install`.
3. To preview the script's behaviour without applying changes, run `npm run sync -- --dry-run`.
4. Run `npm run sync`.
5. If the first attempt times out, run `npm run sync` again.

**What I changed**

- Used one name for the file. "Config file", "settings file" and ".env" now all read "`.env` file", which matches the error message.
- Moved the dry run ahead of the real sync, so readers preview before they change anything.
- Turned "Note that… so be careful" into a caution at the top: the command first, then the risk. "Could result in deleted rows" became "can delete rows".
- Put conditions before commands ("If the first attempt times out, run… again").
- Plain swaps: "ensure" became "make sure that", "utilise" became "use", "prior to" became "before", "in the event that" became "if".
- Left every command, flag and error code exactly as written.

**To check**

- I've assumed the config file, the settings file and `.env` are the same file. If they are different files, tell me and I'll name each one.
- The original said "be careful" with `--force`, not "never". If there is a safe way to use it against production, add when that is, and I'll soften the caution.
- I changed "should contain" to "must contain", on the basis that the script can't run without an API key and a target database.

---

## Text 3. Review agent instructions

**Edited version**

You are the reviewer for this pull request. Never edit files.

1. Read the spec.
2. Check whether the diff touches auth or payments. If it does:
   a. Stop the review.
   b. Report to the integrator.
3. If the tests will help your review, run them.
4. You can also flag style issues.
5. When you finish, list your findings in order of severity, most severe first.

**What I changed**

- Used one name for the agent. "The reviewer", "the checker" and "the auditor" all seemed to mean the agent reading this, so every line now speaks to "you". "The integrator" stays, because that is a different role.
- Moved the auth and payments check to straight after reading the spec. The agent needs to know whether to stop before it does any other work.
- Put the condition before the command, and split "stop and report" into two steps.
- Swapped "should" for plain commands, and "may run tests if it seems useful" for a condition and a command.
- Moved "never edit files" to the top as a standing rule.
- Replaced "i.e." with the plain ordering.

**To check**

- "Could flag style issues too" might mean optional or expected. I've written "can". If you want style issues flagged every time, make it "Flag style issues."
- If the checker and the auditor are separate agents, their lines belong in their own instructions, not in the reviewer's.

---

## Text 4. Member update paragraph

**Edited version**

What a weekend! Forty-two of us lined up at Husky, and the energy on the beach was something else. Sarah finished her first Olympic distance after two DNFs last season – there wasn't a dry eye at the finish chute. Huge thanks to the volunteers who handed out more bananas than anyone thought possible. We'll be back next year, hopefully with even more of you in green.

**What I changed**

- Fixed one typo: "more bananas then" became "more bananas than".
- Left everything else alone. It reads warmly, sounds like the club, and the rhythm works. Tightening it further would flatten it.
