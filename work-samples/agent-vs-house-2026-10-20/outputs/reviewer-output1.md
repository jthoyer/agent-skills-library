I found six defects in `bookings.py`, five of them merge-blocking. I only read the code and the spec; I didn't run anything.

**1. Line 24 blocks merge: the 2-hour cutoff is wrong in both directions.**
- **Problem:** `timedelta.seconds` drops the days and wraps negative values.
- **Failure:** a session 1 day 1 hour away gives `.seconds == 3600`, so the booking is wrongly refused. A session that started an hour ago gives `-1 day + 82800s`, so `.seconds == 82800` and the booking is accepted for a session already under way.
- **Fix:** `(session.start - now).total_seconds() < 2 * 3600`

**2. Line 30 blocks merge: one booking too many.**
- **Problem:** the check `len(booked) > capacity` only trips once the list is already over capacity.
- **Failure:** with capacity 2, a third member gets "booked".
- **Fix:** `>=`

**3. Line 27 blocks merge: one waitlist shared by every session.**
- **Problem:** `waitlist=[]` is a mutable default, so it is created once and reused by every call.
- **Failure:** a member waitlisted for session A shows up on session B's list. This breaks the spec rule "each session has its own waitlist". Callers also can't see the list at all.
- **Fix:** add `waitlist: list = field(default_factory=list)` to `Session` and append to `session.waitlist`.

**4. Lines 30–34 block merge: inactive members get onto the waitlist.**
- **Problem:** the `active` check runs after the full-session branch.
- **Failure:** an inactive member booking a full session gets "waitlisted" when they should get `BookingError`.
- **Fix:** move the `if not member.active` check to the top of `book`.

**5. Lines 39–43 block merge: cancelling doesn't free the place.**
- **Problem:** `cancel` never removes the member from `session.booked`.
- **Failure:** the session stays full after a cancellation. A second `cancel` by the same member succeeds and may refund again.
- **Fix:** `session.booked.remove(member.id)` before returning.

**6. Line 43 should fix: no refund at exactly 24 hours.**
- **Problem:** the spec says "at least 24 hours", but the code uses `>`.
- **Failure:** cancelling exactly 24h before start returns False.
- **Fix:** `>= 24`. Better still, compare `timedelta`s directly to avoid float rounding.

**Spec criteria:**
- Active only: #4.
- Capacity: #2.
- 2-hour cutoff: #1.
- Return values: fine once the above are fixed.
- Frees place: #5.
- 24h refund: #6.
- Per-session waitlist: #3.
- Timezone-aware times: nothing I can check by reading. Mixing naive and aware datetimes raises `TypeError`, which is acceptable under the spec.

**Things to check that the spec doesn't settle:**
- The same member can book the same session twice, or join its waitlist twice. Nothing prevents it.
- Cancelling never promotes anyone from the waitlist.
- Both of these are product decisions to confirm, not defects I can prove.
