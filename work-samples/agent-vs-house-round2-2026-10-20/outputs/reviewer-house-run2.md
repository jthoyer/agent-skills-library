Three defects break the spec, and one of them also breaks both existing tests.

**1. Critical: `club/timeutil.py:7`. `hours_until` gets the time to start wrong (AC3, AC5, AC6)**
`delta.seconds / 3600` uses only the leftover seconds after whole days are taken out. That value is always between 0 and 86399, so it ignores days and is never negative.
- A session 48h away gives 0 hours. Then `_too_late` (`booking.py:14`) rejects the booking with "too close to start", and `_pct` (`refunds.py:12`) gives a 0% refund instead of 100%.
- A session 1h in the past gives 23 hours. It can still be booked, and `reminders.due` (`reminders.py:10`) lists sessions that have already started.
- A session 30h away gives 6 hours. It shows up in reminders (wrong) and gets no refund (wrong).
- Because of this, both tests fail as written. `test_book_and_waitlist` raises BookingError, and `test_cancel_refund` returns 0 instead of 2500.
- **Fix:** `return (start - now).total_seconds() / 3600`. The docstring also says "whole hours" but the function returns a float. Fix the docstring so nobody later "fixes" it with `//`.

**2. High: `club/booking.py:34`. Waitlist promotes the wrong person (AC2, AC4)**
`session.waitlist.pop()` takes the *last* person who joined the waitlist, not the first.
- **Scenario:** B and then C are waitlisted. A cancels. C gets the place.
- **Fix:** `session.waitlist.pop(0)`, or use a `collections.deque` with `popleft()`.

**3. High: `club/members.py:7`. Members lose access on their expiry date (AC7)**
`member.expiry > today` marks a member inactive on the expiry date itself.
- **Scenario:** expiry 2026-11-01, booking on 2026-11-01 raises "inactive member".
- **Fix:** `member.expiry >= today`.

**4. Medium: `club/booking.py:17-26`. Duplicate bookings are allowed**
`book()` doesn't check whether the member is already in `booked` or `waitlist`.
- **Scenario:** a member books twice and holds two places, or joins the waitlist twice and gets promoted twice.
- **Fix:** if `member.id` is already in either list, raise or return the current status.
- Related: `cancel()` (`booking.py:30`) can't take a member off the waitlist. The spec says nothing on this, so confirm with the Planner.

**5. Low: `club/refunds.py:6,17-25`. Pointless cache that never shrinks**
`_CACHE` maps (price, pct) to cents. That calculation is cheap and always gives the same answer, so the cache adds nothing. It is shared module-level state that keeps growing.
- **Fix:** delete it and return `session.price_cents * pct // 100`.
- The integer arithmetic is correct for 0% and 100% (AC5, cents).

**6. Low: AC8 (timezone-aware datetimes) is not enforced**
- Nothing checks that datetimes carry a timezone. If a naive `joined` or `start` gets in, it fails with a TypeError at `members.py:11` or `timeutil.py:6` rather than a clear error.
- `reminders.due` (`reminders.py:7`) reads `datetime.now()` itself. That makes it the only function that doesn't take `now`, so tests can't pin the time.
- **Fix:** add a `now` parameter, and check for a timezone in the `Session`/`Member` `__post_init__`.

**7. Medium: tests are too thin**
- There are only two tests, and neither exercises any boundary.
- Missing tests: booking exactly 2h before start, and just under; refund at exactly 24h, and just under; the new-member grace period: 6 days 23 hours vs 7 days; booking on the expiry date (would catch #3); waitlist order: two people waitlisted, then a cancel (would catch #2); `reminders.due` with sessions in the past, at +23h and at +25h; a session more than 24h away. Every test uses 48h, which only fails because of #1. A test at, say, 30h would have caught it directly.

**Checked and clean**
- `book()` order of checks: active, then cutoff, then capacity. The cutoff blocks waitlisting too (AC3).
- The waitlist is per session (`Session.waitlist`).
- `cancel()` frees the place before promoting and returns the refund (AC4/AC5 structure).
- New-member grace: `(now - joined).days < 7` gets the boundary right, and it takes priority over the 24h rule (AC5).
- Refunds stay in integer cents with no float rounding.
- `Session` rejects a capacity below 1.
- The reminders window `0 <= h <= 24` is correct once #1 is fixed (AC6).
- `now.date()` for checking active membership is consistent with UTC (AC7/AC8).

**Planner handoff check:** the Planner said the most likely defect was in the time helpers, and it was (#1). It also explains the wrong refunds. But #2 and #3 sit outside the time helpers and would still ship after #1 is fixed.
