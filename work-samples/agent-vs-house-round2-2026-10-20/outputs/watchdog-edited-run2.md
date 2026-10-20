**Scope:** all 9 files under `work-samples/agent-vs-house-round2-2026-10-20/fixtures/watchdog/library/` (8 handbook pages + `CHANGELOG.md`). I read every one in full, and checked the shared gate (`.claude/references/review-gates.md`) before reporting.

## Findings, most costly first

**1. The refund window disagrees between member pages and the committee guide (structural error).**
- `handbook/faq.md:3` and `handbook/welcome-pack.md:4` say "cancel within **14 days** of joining for a full refund".
- `handbook/committee-guide.md:3` says "within **30 days** of joining".
- **Cost:** a member who asks on day 20 is told no by the FAQ and yes by the committee. That's a money and fairness dispute, and the club can't say which rule it actually holds.
- **Cause:** the policy is written out in three places instead of being stated once.
- **Fix:** the committee confirms the real window. Then state it in one page and point the other two pages to it. This is a policy question, so it's flagged for the user to decide.

**2. The welcome pack quotes the wrong adult fee.**
- `handbook/welcome-pack.md:2` says "Your annual membership fee is **$160**".
- `handbook/fees.md:2` (approved 2026-09-01) and `handbook/renewal-email.md:2` both say **$180**.
- **Cost:** every new member is quoted $20 too little when they join. It's probably a stale number that was never updated after the 2026-09-01 approval.
- **Fix:** change it to $180, or better, link to `fees.md`.

**3. The season-launch page has the wrong weekday. This is already tracked.**
- `handbook/season-launch.md:2` says "Sunday 14 November 2026". I worked it out by hand: 14 Nov 2026 is a **Saturday**.
- This is the open entry in `CHANGELOG.md` (2026-10-12). It is still not fixed. The follow-up that entry asked for is done: `renewal-email.md:4` already says Saturday, which is correct.
- Don't log it again. Close the existing entry once it's fixed.

**4. The season-launch page links to a file that doesn't exist.**
- `handbook/season-launch.md:3` points juniors to `handbook/junior-policy.md`. I searched the folder with Glob and found no such file.
- **Cost:** a dead link in a page going to members.
- **Fix:** link to `faq.md` instead ("Do juniors need a guardian?"), or write the missing policy page.

**5. Training times are repeated word for word (duplication, low cost today).**
- The same text, "swim Tuesday and Thursday 6am, run Wednesday 6pm", appears in `welcome-pack.md:3` and `faq.md:10`.
- The two agree for now. Finding 1 shows how this kind of copy drifts apart.
- **Fix:** keep one copy and link to it from the other page.

## Not findings
- **The two ride briefs** (`ride-brief-short.md` and `ride-brief-long.md`) are two pages that follow the same template. The distance, meeting time and pace groups are meant to differ, and the shared safety line is meant to repeat.
- **The junior guardian rule** appears in both the FAQ and the committee guide, but the two versions say the same thing. It's worth keeping an eye on, but nothing is wrong.
- **Early-bird price:** 15% off $180 is $153. That's correct in both `fees.md:4` and `renewal-email.md:3`.

## Ledgers
- **Read:** the handbook's own `CHANGELOG.md`, which tracks finding 3.
- **Skipped:** the library ledger at `/home/user/agent-skills-library/CHANGELOG.md`, because this is a test handbook, not library work.

Before logging, check the Notion backlog for an existing row.

## Not covered
- Whether $180, $90 and 14 or 30 days are the club's real current figures. No source outside these files exists to check them against, so I didn't use web lookups.
- No junior early-bird price is stated anywhere. That's a gap to note, not a confirmed error.
- Brand and tone, and anything outside the fixture folder.
