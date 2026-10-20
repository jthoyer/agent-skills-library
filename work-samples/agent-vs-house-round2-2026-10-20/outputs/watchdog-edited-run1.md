**Scope:** all 9 files under `.../fixtures/watchdog/library/` (8 handbook pages plus `CHANGELOG.md`), read in full. I read `review-gates.md`; §1 and §3 applied. Nothing was edited.

**Findings, most costly first**

1. **The welcome pack charges the wrong fee.** `handbook/welcome-pack.md:2` says "Your annual membership fee is $160". `handbook/fees.md:2` (approved 2026-09-01) says "Adult annual fee: $180", and `renewal-email.md:2` agrees with fees.md. New members will be quoted $20 less than the approved fee, which means billing disputes or lost income. The cause is a single bad number, not a structural problem. **Fix:** change it to $180, or better, point to fees.md so the number isn't copied.

2. **The committee guide gives a different refund window.** `committee-guide.md:3` says "within 30 days of joining". `faq.md:3` and `welcome-pack.md:4` both say "within 14 days". The committee would approve refunds that members are told they can't get, or the reverse, and nothing says which is the real policy. I couldn't find a policy document in scope that settles it. **Fix:** flag for the committee to decide, then keep the rule in one place and point the other files to it.

3. **The season launch has the wrong weekday. This is already tracked.** `season-launch.md:2` says "Sunday 14 November 2026", and 14 Nov 2026 is a Saturday (I worked it out from 1 Jan 2026 being a Thursday). It is logged in `CHANGELOG.md` (2026-10-12) with "Changed: nothing yet", so it is still open. I did the follow-up that entry asks for: `renewal-email.md:4` correctly says "Saturday 14 November 2026". So the two pages members see disagree right now. **Fix:** correct season-launch.md under the existing entry rather than logging it again.

4. **Broken link.** `season-launch.md:3` points juniors to `handbook/junior-policy.md`. Glob shows that file doesn't exist. Juniors and guardians hit a dead end before launch day. The guardian rule does exist in `faq.md:7` and `committee-guide.md:7`. **Fix:** create the policy page or point the link to the FAQ section.

5. **Copies that will drift (duplication).** The refund rule appears 3 times (faq, welcome-pack, committee-guide), and one copy has already drifted (finding 2). The training times appear twice, identically (`welcome-pack.md:3`, `faq.md:10`). The fee figures appear twice (fees.md, renewal-email.md, plus the wrong copy in finding 1). Each change has to be made in 2–3 places, and finding 1 shows that has already failed once. **Fix:** treat fees.md as the source for fees, pick one source each for refunds and training times, and point the other files to them.

**Checked and not a finding**
- The early-bird maths is right: 15% off $180 is $153 (`fees.md:4`, `renewal-email.md:3`).
- The two ride briefs share a layout and a safety line. That's a shared template, not duplication.
- The guardian wording in the FAQ and the committee guide matches.

**Ledgers:** I read the fixture's `CHANGELOG.md`, which tracks finding 3 only. I skipped the library's root `CHANGELOG.md` because this is handbook content, not library work, and the brief didn't come from cpo.

Before logging, check the Notion backlog for an existing row.

**Not covered:** I had no source for the real policy, so I didn't check whether 14 or 30 days is correct. I didn't check fees for juniors or for early-bird juniors (no early-bird junior price is stated), the venue details ("the lake", "clubhouse"), or ride distances against real routes. I didn't use WebSearch, and nothing outside this fixture folder was compared.
