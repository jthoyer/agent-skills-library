I reviewed `bookings.py` by reading only, as asked. I found 6 defects, most severe first.

1. **Line 30: one booking too many (critical).** `len(session.booked) > session.capacity` only treats the session as full once it is already over capacity. With capacity 10, the 11th member gets "booked" instead of "waitlisted". Fix: use `>=`.

2. **Line 41: cancelling never frees the place (critical).** `cancel` checks that the member is booked and works out the refund, but never removes them from `session.booked`. Cancelled places stay taken, so the session fills with ghost bookings and everyone after that is waitlisted. Cancelling twice also refunds twice. Fix: call `session.booked.remove(member.id)` before returning.

3. **Line 24: the 2-hour cutoff is wrong both ways (critical).** `timedelta.seconds` ignores whole days, and when the time difference is negative it wraps around to a large positive number.
   - A session 3 days and 1 hour away gives `.seconds == 3600`, so the booking is wrongly refused as "too close to start".
   - For a session that started 30 minutes ago, the difference is −1 day + 84,600 s. `.seconds` is 84,600, so booking a session that has already started is allowed.
   - Fix: `(session.start - now).total_seconds() < 2 * 3600`.

4. **Line 27: every session shares one waitlist (high).** `waitlist=[]` is a mutable default, so it is created once and shared by every session and every call. The spec says each session has its own waitlist. Members waitlisted for session A end up mixed with session B's, and the list keeps growing for the life of the process. The caller also can't see the waitlist unless it passes one in. Fix: add `waitlist: list = field(default_factory=list)` to `Session` and drop the parameter.

5. **Lines 30–34: inactive members can join the waitlist (high).** The active check comes after the full-session branch, so an inactive member who tries a full session gets "waitlisted". The spec says only active members may book or join the waitlist. Fix: move the `member.active` check to the top of `book`, before anything else.

6. **Line 43: no refund at exactly 24 hours (medium).** `hours_left > 24` refuses a refund to a member who cancels exactly 24 hours before start. The spec says "at least 24 hours". Fix: use `>= 24`.

**Smaller points.** The spec doesn't settle these, so they are worth confirming rather than fixing outright:
- The same member can book the same session twice; nothing checks whether their id is already in `booked`.
- A waitlisted member can't leave the waitlist: `cancel` raises "not booked".
- When a place frees up, nobody on the waitlist is moved into it. The spec doesn't say whether that should happen.
- If `now` has no timezone, comparing it with `start` raises a `TypeError`. The spec requires timezone-aware datetimes, so this is allowed, but it isn't checked.
