**Scope:** all 9 files under `.../fixtures/watchdog/library/`, which are 8 handbook pages plus its `CHANGELOG.md`. I checked the fixture's own CHANGELOG for existing entries. I did not read the repo-root ledger, because this fixture keeps its own. I read `review-gates.md` before writing findings.

**Findings, most costly first**

1. **The adult fee doesn't match: $160 vs $180.** It's a structural error: the fee is restated in more than one place, so one copy went stale.
   - `handbook/welcome-pack.md:2` says "Your annual membership fee is $160".
   - `handbook/fees.md:2` (approved 2026-09-01) and `handbook/renewal-email.md:2` both say $180.
   - **Cost:** new members are told the wrong price on a page that goes to members, and the club either collects $20 less or has a dispute.
   - **Fix:** change it to $180, or better, point to `fees.md` instead of repeating the number. Check the Notion backlog for an existing row before logging.

2. **The refund window doesn't match: 14 days vs 30 days.** Same cause: one policy copied into three places.
   - `handbook/welcome-pack.md:4` and `handbook/faq.md:3` say "within 14 days".
   - `handbook/committee-guide.md:3` says "within 30 days".
   - **Cost:** the committee would approve refunds that members were told they can't get. That's inconsistent and it costs money.
   - **Fix:** the user has to decide which number is right. After that, keep the policy in one place and have the other pages point to it. Check the Notion backlog before logging.

3. **Broken link in `handbook/season-launch.md:3`.** It points juniors to `handbook/junior-policy.md`, which doesn't exist (checked with Glob; the folder has only the 8 pages listed). The guardian rule is actually written in `faq.md:7` and `committee-guide.md:7`.
   - **Cost:** juniors and guardians reach a missing page from a launch notice.
   - **Fix:** link to `faq.md#do-juniors-need-a-guardian`, or create the policy page.

4. **Wrong weekday in `handbook/season-launch.md:2`: "Sunday 14 November 2026".** I worked out the date independently: 1 Jan 2026 is a Thursday, so 14 Nov 2026 is a Saturday. This one is already tracked: the `CHANGELOG.md` entry dated 2026-10-12 found it and is still open ("Changed: nothing yet"), so it isn't new. On that entry's follow-up, `renewal-email.md:4` already says "Saturday 14 November 2026" and is correct. Only `season-launch.md` needs fixing, and the entry can be closed once it's done.

5. **Low cost: the same text is repeated with no single source.** These copies agree today but could drift like findings 1 and 2.
   - Training times appear in both `welcome-pack.md:3` and `faq.md:10`.
   - The guardian sentence appears in both `faq.md:7` and `committee-guide.md:7`.
   - **Fix:** link to one copy where convenient. Optional.

**Checked and fine:**
- Early-bird $153 is correct (85% of $180), and `fees.md` and `renewal-email.md` agree on it.
- `ride-brief-short.md` and `ride-brief-long.md` use the same layout on purpose, and their shared safety line is intended. That's not duplication.

**Not covered:**
- Whether $180 or 14 days is the correct real-world figure. I treated `fees.md` as the authority because it says "approved"; the refund window has no such source.
- Any material outside this folder, such as earlier club emails or a styleguide.
- Whether there should be a junior early-bird price; `fees.md` doesn't say.
- The repo-root ledgers and the Notion backlog.
