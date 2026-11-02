## Text 1. Race-day transition briefing

### Edited version

Transition opens at 5:30am. Get there early so you have time to set up your gear.

Rack your bike by the seat post and lay your gear out on a small towel next to the front wheel.

After the swim, take your wetsuit off in the change area, not at your rack. The rack area gets slippery.

Buckle your helmet before you unrack your bike. Officials check this: an unbuckled helmet means instant disqualification, and it's a crash risk.

Mount your bike after the mount line, not before. If marshals are there, follow their directions.

When you're back from the ride, re-rack your bike and head out on the run. Turn your race belt so your number is at the front.

### What I changed

- **Order:** I put the steps in race order (set up, swim, bike out, mount, bike in, run). The wetsuit note sat in the middle of the bike section, after the mount line.
- **Direct instructions:** "Racking your bike should be done by", "you may want to" and "make sure that" became plain commands, so members can scan it on the morning.
- **Clarity:** "DQ" is now "disqualification" for newer members. I fixed the run-on sentence about the mount line and cut the trailing "etc.", which left readers guessing what else they'd missed.
- **Two things to check:** the briefing doesn't mention the dismount line, or keeping the helmet buckled until the bike is back on the rack. Most races enforce both. Worth adding if they apply at this event.

---

## Text 2. README setup section

### Edited version

## Setup

1. Install dependencies:
   ```
   npm install
   ```
2. Make sure you have a `.env` file containing your API key and the target database. Without it, the script fails with `ERR_NO_CONFIG`.
3. Preview what the sync will do:
   ```
   npm run sync -- --dry-run
   ```
4. Run the sync:
   ```
   npm run sync
   ```
   If the first attempt times out, run it again.

> **Warning:** using `--force` against production can delete rows that don't match the source.

### What I changed

- **One name for one file:** the original called it the "config file", the "settings file" and the ".env". I've assumed these are the same file and used `.env` throughout. If they're different files, tell me and I'll separate them.
- **Steps in the order you run them:** install, config, dry run, then the real sync. The dry run came last in the original, after the reader had already been told to run the sync.
- **Plainer words:** "ensure" became "make sure", "in the event that" became "if", "utilise" became "use" and "prior to" became "before".
- **The risky part stands out:** the `--force` warning is now a separate callout. It says what happens rather than "so be careful".

---

## Text 3. Review agent instructions

### Edited version

You are the reviewer for this pull request.

1. Read the spec first.
2. If the diff touches auth or payments, stop and report back to the integrator.
3. Run the tests if you judge they would help. You may also flag style issues.
4. Never edit files.
5. When you finish, produce a list of findings ranked by severity, most severe first.

### What I changed

- **One role, one voice:** the original called the agent "the reviewer", "the checker" and "the auditor", and switched between "you" and the third person. An agent may read those as three different roles and assume some rules don't apply to it. I've assumed all three mean this agent and used "you" throughout. The integrator stays as a separate role. If the checker or auditor is really a different agent, those lines belong in that agent's instructions.
- **Clear rules:** "You should read the spec first" is now a plain instruction. Running tests and flagging style stay optional, but the wording now says clearly that they're the agent's call.
- **Order:** the stop condition now comes straight after reading the spec, so the agent checks it before doing any review work.
- **Last line:** "ranked findings list, i.e. most severe first" became "ranked by severity, most severe first", which names what the ranking is based on.

---

## Text 4. Member update paragraph

### Edited version

What a weekend! Forty-two of us lined up at Husky, and the energy on the beach was something else. Sarah finished her first Olympic distance after two DNFs last season – there wasn't a dry eye at the finish chute. Huge thanks to the volunteers who handed out more bananas than anyone thought possible. We'll be back next year, hopefully with even more of you in green.

### What I changed

- One fix: "more bananas **then**" became "more bananas **than**".
- I left everything else as it was. It's warm, it sounds like you, and it works for club members. More editing would only make it flatter.
