## mc-reviewer: club/ against SPEC.md (static reading only)

I read `.claude/references/review-gates.md` before writing any finding. Paths below are relative to `.../fixtures/reviewer/`.

### Findings

**1. critical, blocks merge. `club/timeutil.py:7`**
- **Defect:** `return delta.seconds / 3600` uses `timedelta.seconds`. That field holds only the 0–86399 seconds left over after whole days, so whole days are dropped and a negative delta wraps to a positive number.
- **Three call sites, all affected:**
  - `booking.py:14` (`_too_late`): a session 25h away reads as 1h, so the booking is rejected (breaks AC1). A session that started 1h ago reads as 23h, so booking is allowed (breaks AC3).
  - `refunds.py:12`: the result can never reach 24, so every member who isn't new gets a 0% refund, even a week ahead (breaks AC5).
  - `reminders.py:10`: a session 30h out reads as 6h, and one that started 2h ago reads as 22h. Both are returned as due (breaks AC6).
- **Why existing guards miss it:** there is no type or range check. The only tests, in `tests/test_booking.py`, use a start 48h out. That gives `delta.seconds = 0`, so `hours_until` returns 0 and `book()` raises "too close to start". By reading, both tests fail at their first `book` call, so they pin nothing.
- **Fix:** `delta.total_seconds() / 3600`. Also fix the docstring: it says "whole hours" but the function returns a float.

**2. high, blocks merge. `club/booking.py:34`**
- **Defect:** `session.waitlist.pop()` takes the last person on the list (LIFO).
- **Scenario:** B waitlists, then C waitlists, then A cancels. C is promoted ahead of B (breaks AC2 and AC4).
- **Why existing guards miss it:** no test covers promotion or waitlist order.
- **Fix:** `pop(0)`, or use a `deque` with `popleft()`.

**3. medium, blocks merge (breaks AC7). `club/members.py:7`**
- **Defect:** `member.expiry > today` excludes the expiry date itself.
- **Scenario:** a member whose expiry is 2026-11-01 calls `book()` on 2026-11-01 and gets "inactive member".
- **Why existing guards miss it:** no test sets `expiry` equal to today. The fixture uses 2027-01-01.
- **Fix:** `>=`.

**4. medium, should fix (spec silent: Planner decides). `club/booking.py:22-25`**
- **Defect:** nothing checks whether the member is already in `booked` or `waitlist`.
- **Scenario:** member A calls `book()` twice on a capacity-2 session and takes both places. Or A is booked and also waitlisted, and is later "promoted" into a second place.
- **Fix:** if `member.id` is already in either list, return the current status or raise.

### Completeness gaps
- **Leaving the waitlist:** `cancel()` (`booking.py:30`) raises "not booked" for a waitlisted member, so there is no way off the waitlist. Closing it: if the member is on the waitlist, remove them and return 0.
- **Promotion checks:** promotion at `booking.py:34` doesn't check that the promoted member is still active or that the cutoff hasn't passed. The spec is silent; Planner to decide.
- **Untestable clock:** `reminders.due()` (`reminders.py:7`) reads `datetime.now()` itself, so AC6 can't be tested at a fixed time. Closing it: take `now` as a parameter, as `book` and `cancel` already do.
- **Thin tests:** none cover the 2h or 24h boundaries, the new-member grace period, the expiry day, waitlist order or reminders.

### Coverage close

**Per AC**
- AC1: finding 1 (sessions are wrongly rejected).
- AC2: findings 2 and 4.
- AC3: finding 1. The `< 2` boundary itself is correct, so exactly 2h is allowed.
- AC4: finding 2.
- AC5: finding 1. Reviewed and clean: integer-cent maths (`price*pct//100` with pct of 0 or 100 is exact), the `>= 24` boundary, and `is_new`'s `.days < 7`.
- AC6: finding 1, plus the untestable-clock gap.
- AC7: finding 3.
- AC8: reviewed, no finding. `reminders` uses UTC, and the other modules take `now` from the caller. Inputs aren't checked to be timezone-aware, but the spec says they are.

**Per Planner risk item**
- Time arithmetic: confirmed as finding 1. One root cause, all 3 call sites.
- Money: clean once finding 1 is fixed. I checked `refunds._CACHE` and dropped it. The key `(price_cents, pct)` fully determines the value, so cached results can't be wrong.
- Waitlist order and promotion: finding 2.
- Handoff "defect most likely in time helpers": confirmed (finding 1).
- Handoff "refunds needs attention most": the refund maths is correct, but every member who isn't new gets nothing, through finding 1.

**Flagged areas**
- (a) Sub-bar hunch: `_CACHE` grows without limit across prices. It is harmless at club scale.
- (b) Spec questions: double booking (finding 4), promotion checks, and whether "joined less than 7 days ago" means calendar days or elapsed time. The code uses elapsed time.

### Handoff Note
- Fixing finding 1 alone repairs AC1, AC3, AC5 and AC6, and should make both existing tests pass.
- Verifier: run the existing tests to confirm they currently fail. Then add boundary tests at 2h, 24h and 48h, at minus 1h (already started), and on the expiry day, plus a three-person waitlist.
- Planner: rule on double booking and on the promotion checks.
