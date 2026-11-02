## Text 1: Race-day transition briefing

### Edited version

**Race-day transition: what you need to know**

Transition opens at 5:30am. Get there early so you have time to set up.

1. **Setting up.** Rack your bike by the seat post. Lay your gear out on a small towel next to the front wheel.
2. **After the swim.** Take your wetsuit off in the change area, not at the rack. The rack area gets slippery.
3. **Before you unrack.** Buckle your helmet before you unrack your bike. Officials check this: an unbuckled helmet means instant disqualification, and it's a crash risk.
4. **Mounting.** Don't get on your bike until you've crossed the mount line. If marshals are there, follow their directions.
5. **After the ride.** Re-rack your bike, then head out on the run. Turn your race belt so your number faces the front.

### What I changed

1. **Order:** The original jumped around (wetsuit removal came after mounting the bike). I've put the steps in race order and numbered them, so members can follow them on the morning.
2. **Direct instructions:** "Racking your bike should be done by", "you may want to", "make sure that" and "you should" are now plain commands: "Rack", "Lay", "Buckle". "Prior to" is now "before".
3. **Punctuation:** Fixed the run-on sentence about the mount line ("not before, if marshals are present") by splitting it in two. Dropped "Note:", which made the wetsuit rule look like an aside when it's a rule.
4. **Clarity:** "DQ" is spelled out, since newer members may not know it. Cut "obviously". "Your race belt number goes at the front" now tells them what to do.
5. **The trailing "etc.":** Removed. A briefing should list everything or stop; if there's more members need to know for the run, add it as a sixth step.

**One to check:** Confirm with the race rules that an unbuckled helmet is a disqualification rather than a time penalty. If it's a penalty, change step 3.

---

## Text 2: README setup section

### Edited version

## Setup

1. Make sure your `.env` file is in place. It must contain your API key and the target database. If `.env` is missing, the script fails with `ERR_NO_CONFIG`.
2. Install dependencies:
   ```
   npm install
   ```
3. Preview what the sync will change, without applying anything:
   ```
   npm run sync -- --dry-run
   ```
4. Run the sync:
   ```
   npm run sync
   ```
   If the first attempt times out, run it again.

> **Warning:** Take care using `--force` against production. It can delete rows that don't match the source.

### What I changed

1. **One name for one file:** The original called it the "config file", the "settings file" and the ".env". I've assumed these are all the same file and used `.env` throughout. If they're different files, tell me and I'll split step 1.
2. **Order:** The dry run now comes before the real run, which is when a reader needs it. The missing-file error sits with the file it's about.
3. **Steps and code blocks:** Numbered the steps and put each command on its own line so it can be copied.
4. **Plain words:** "In the event that" is now "If". "Utilise … to see the script's behaviour prior to applying changes" is now "Preview what the sync will change, without applying anything".
5. **The `--force` warning:** Pulled out into a warning so it isn't buried mid-paragraph. "Could result in deleted rows" is now "can delete rows", and "so be careful" is folded into "Take care".

---

## Text 3: Review-agent instructions

### Edited version

You are the reviewer for this pull request.

1. Read the spec first.
2. Run the tests if they would help your review. You may also flag style issues.
3. If the diff touches auth or payments, stop and report back to the integrator.
4. Never edit files.
5. When you have finished, produce a list of findings ranked by severity, most severe first.

### What I changed

1. **One name for the agent:** The original called the same agent "the reviewer", "the checker" and "the auditor", and switched between "you" and "the reviewer should". An agent reading that can't tell whether the rules about the checker and auditor apply to it. I've addressed it as "you" throughout and kept "integrator", which is a different agent.
2. **Clear permissions:** "May", "could" and "should" were doing different jobs and none was clear. Reading the spec is now an instruction. Running tests and flagging style stay optional, worded as such. Never editing files is a hard rule.
3. **Order and format:** Numbered the steps in the order the agent works through them, with the stop rule ahead of the output so it's seen before the agent writes its report.
4. **Concision:** "Ranked findings list, i.e. most severe first" is now "a list of findings ranked by severity, most severe first", which drops the "i.e.".

**One to check:** If "checker" and "auditor" are actually separate agents, these rules belong in their instructions, not this one. Tell me and I'll split them out.

---

## Text 4: Member update paragraph

### Edited version

What a weekend! Forty-two of us lined up at Husky, and the energy on the beach was something else. Sarah finished her first Olympic distance after two DNFs last season – there wasn't a dry eye at the finish chute. Huge thanks to the volunteers who handed out more bananas than anyone thought possible. We'll be back next year, hopefully with even more of you in green.

### What I changed

1. **One typo:** "more bananas then anyone" is now "more bananas than anyone".

That's all. The paragraph is warm, the right length and sounds like the club, so I left the rest alone. "DNF" is fine for this audience.
