**Scope:** I read all 9 files under `.../fixtures/watchdog/library/`: the 8 handbook files plus that folder's own `CHANGELOG.md`. That is the only ledger I checked. I had `review-gates.md` §1 and §3 in front of me while judging. I edited nothing.

**Findings, most costly first**

1. **Two different refund windows.**
   - `handbook/committee-guide.md:3` says "cancel within **30 days** of joining for a full refund".
   - `handbook/faq.md:3` and `handbook/welcome-pack.md:4` both say "within **14 days**".
   - **Cost:** the committee will approve refunds that members have been told they can't get, or the reverse. That causes disputes and makes the club look inconsistent.
   - **Kind:** this is a structural problem. The same policy is written out in three places with nothing marking one as the master copy.
   - **Fix:** the user needs to decide which window is right. Then keep the policy in one place and have the other two point to it.

2. **The welcome pack has the wrong fee.**
   - `handbook/welcome-pack.md:2` says "Your annual membership fee is **$160**".
   - `handbook/fees.md:2` (approved 2026-09-01) and `handbook/renewal-email.md:2` both say the adult fee is **$180**.
   - **Cost:** new members are told the wrong price in writing. The welcome pack also leaves out the junior fee ($90).
   - **Fix:** change it to $180, or point to `fees.md`. The likely cause is a hand-copied number that was never updated after the fees were approved.

3. **The season launch has the wrong weekday. This is already in the ledger.**
   - `handbook/season-launch.md:2` says "**Sunday** 14 November 2026". I worked it out, and 14 Nov 2026 is a **Saturday**.
   - `renewal-email.md:4` already says Saturday, so the other half of the ledger's follow-up is done.
   - This is already tracked in `CHANGELOG.md` (2026-10-12 entry, "Changed: nothing yet"). Treat it as that open item, not a new finding.
   - **Cost:** members turn up on the wrong day.
   - **Fix:** correct the weekday and close the ledger entry.

4. **Broken link.**
   - `handbook/season-launch.md:3` points to `handbook/junior-policy.md`. I searched the folder and that file doesn't exist.
   - **Cost:** juniors and guardians reach a dead end.
   - **Fix:** the guardian rule is already in `faq.md:7` and `committee-guide.md:7`, so either link to the FAQ section or create the policy file and point all three at it.

5. **Training times are written out twice.**
   - `handbook/welcome-pack.md:3` and `handbook/faq.md:10` repeat the same schedule word for word.
   - They match today, but finding 1 shows this handbook already lets copies drift.
   - **Cost:** low for now; there is a risk they drift later.
   - **Fix:** keep one copy and point the other to it.

**Lower priority (no action needed):**
- The early-bird maths is right (15% off $180 = $153). But neither `fees.md` nor `renewal-email.md` gives the junior early-bird price ($76.50). Worth stating it if juniors get the discount.

**Not a finding:**
- `ride-brief-short.md` and `ride-brief-long.md` follow the same layout and share the same safety line. That's a deliberate template, and their distances, meet times and pace groups differ where they should.
- The guardian rule appears in both the FAQ and the committee guide, and the two agree.

Before logging any of these, check the Notion backlog for an existing row.

**Not covered:** I did not read the real library ledgers (`CHANGELOG.md`, `changelog/`, the skills ledger) because they are outside this fixture. Nothing outside the fixture folder was checked to confirm the fees or refund window, and I didn't review tone or style. "Ridgeway Tri Club" appears only in the welcome pack, so I could not check the club name against anything.
