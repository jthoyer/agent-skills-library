**Findings, highest cost first**

1. **The refund window disagrees (30 days vs 14).** `handbook/committee-guide.md:3` gives a 30-day full refund. `handbook/faq.md:3` and `handbook/welcome-pack.md:4` give 14 days. So the committee would honour refunds that members are told they can't get, or the other way round. There is no policy file to settle which is right, and it involves money and member disputes.

2. **The welcome pack fee is wrong.** `handbook/welcome-pack.md:2` says the annual fee is $160. `handbook/fees.md:2` (approved 2026-09-01) says the adult fee is $180, and `renewal-email.md` agrees with $180. The welcome pack also leaves out the $90 junior fee, so new members are quoted the wrong price.

3. **The launch weekday is still wrong.** `handbook/season-launch.md:2` still says "Sunday 14 November 2026". I checked: that date is a Saturday. The CHANGELOG logged this on 2026-10-12 with "Changed: nothing yet", and it is still open. `renewal-email.md:4` already says "Saturday", so the two pages now contradict each other. Fix season-launch and close the CHANGELOG entry.

4. **A link points to a missing file.** `handbook/season-launch.md:3` links to `handbook/junior-policy.md`, which isn't there. The guardian rule is stated in `faq.md:7` and `committee-guide.md:7`, so either create the file or point the link at one of those.

5. **The renewal email has a deadline problem.** `handbook/renewal-email.md` is still a draft. The early-bird cutoff is 31 October and today is 20 October, so it has 11 days left to be useful. It also doesn't say whether juniors get the 15% discount; `fees.md` only gives the adult figure. The maths is right: 15% off $180 is $153.

**Duplication** (where the copies are out of step, they are ranked above)

- **Refund policy:** written out in 3 places, and they conflict (finding 1).
- **Fees:** `fees.md` is the source, copied into `renewal-email.md` (matches) and `welcome-pack.md` (doesn't match). Both should link to `fees.md` rather than repeat the numbers.
- **Training times:** written the same in `faq.md:10` and `welcome-pack.md:3`. They agree now but will drift; keep them in one place.
- **Guardian rule:** written the same in `faq.md:7` and `committee-guide.md:7`, and the link meant to cover it is broken (finding 4).
- **Launch details:** in both `season-launch.md` and `renewal-email.md`, with different weekdays.
- **Ride briefs:** `ride-brief-long.md` and `ride-brief-short.md` share a template and an identical safety line. That is reasonable and low cost. The differences between them (distance, meet time, A/B vs A/B/C pace groups) could be intended; I couldn't verify them.

**Minor:** the CHANGELOG holds only one entry and none of the problems above, so it doesn't reflect what is wrong with the handbook.

**Not covered**

- Whether 14 or 30 days is the real refund policy, or which document has authority. I flagged the conflict but did not choose a side.
- Anything outside this folder, including whether the club name "Ridgeway Tri Club" is right (it appears only in the welcome pack).
- The safety and logistics content of the ride briefs, the training times, and the junior age cut-off beyond comparing pages with each other.
- Tone, grammar and brand style.
- Whether the renewal email has already gone out.

(Preamble line omitted: "I read all 9 files ... I did not edit anything.")
