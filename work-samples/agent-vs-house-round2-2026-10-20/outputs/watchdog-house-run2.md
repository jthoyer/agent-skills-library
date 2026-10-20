Findings are listed with the most costly first:

1. **The refund window differs between files (money and disputes).** `handbook/committee-guide.md:3` gives 30 days. `handbook/faq.md:3` and `handbook/welcome-pack.md:4` give 14 days. The committee could refund people that members were told can't get one, or the reverse. Nothing in the folder says which number is right. Someone with authority has to decide, and then all three files need to match.

2. **The season launch weekday is wrong, and it was logged 8 days ago but never fixed.** `handbook/season-launch.md:2` says "Sunday 14 November 2026". That date is a Saturday (I checked). `handbook/renewal-email.md:4` already says Saturday, so the two documents now conflict. The CHANGELOG entry from 2026-10-12 still reads "Changed: nothing yet." Members may turn up on the wrong day, and the event is 25 days away.

3. **The welcome pack has the old fee.** `handbook/welcome-pack.md:2` says $160. `handbook/fees.md:2` (approved 2026-09-01) and the renewal email say $180. New members are being quoted a fee $20 too low.

4. **A link points to a file that doesn't exist.** `handbook/season-launch.md:3` points to `handbook/junior-policy.md`. That file isn't there. Read relative to the `handbook/` folder, the path would also resolve to `handbook/handbook/junior-policy.md`. The guardian rule it means to point to is already in faq.md and committee-guide.md.

5. **The same facts are copied into several files, which is what caused findings 1 and 3.**
   - The refund policy is in 3 places (faq, welcome-pack, committee-guide).
   - Fees are in 3 places (fees.md, renewal-email, welcome-pack).
   - The training schedule is in 2 places (faq.md:10, welcome-pack.md:3). They agree today but will drift.
   - The junior guardian rule is in 2 places (faq.md:7, committee-guide.md:7). They agree.

   I'd keep one source file per fact and have the others link to it.

6. **Smaller items:**
   - The renewal email gives no junior early-bird price. 15% off $90 is $76.50.
   - The early-bird arithmetic is correct: 15% off $180 is $153.
   - The early-bird deadline of 31 October is 11 days away, so if the email still needs fixes, they're urgent.
   - `fees.md` doesn't say which membership year it covers, while the email says "Renewals for 2027".
   - The CHANGELOG follow-up "check renewal-email.md" is still open. That check passes, but nobody has recorded that.
   - The CHANGELOG doesn't record the fee approval or any other change.

7. **The two ride briefs are near-duplicates.** `ride-brief-long.md` and `ride-brief-short.md` share a template and the same safety line. That looks intentional, and the differences between them (distance, meet time, pace groups) are believable. Low cost.

**What I did not cover:**
- Whether any value is actually right outside these files. That includes which refund window the committee approved, whether $180/$90 are the real fees, and the training times, ride distances, meeting points and the lake venue. I could only check the files against each other.
- The club name ("Ridgeway Tri Club" appears only in welcome-pack.md) against any outside source.
- Tone, brand or the quality of the writing.
- Anything outside this `library/` folder, such as other fixtures or the wider repo, and whether the CHANGELOG follows the repo's close-out format.
- Git history. The folder isn't a git repository, so I couldn't see who changed what or when.
