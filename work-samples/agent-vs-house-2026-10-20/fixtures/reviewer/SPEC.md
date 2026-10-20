# Spec: session bookings

- `book(member, session, now)`: book a member onto a session.
  - Only **active** members may book or join the waitlist.
  - A session holds at most `capacity` bookings. When full, the member joins that session's waitlist.
  - No booking or waitlisting within **2 hours** of the session start.
  - Returns "booked" or "waitlisted"; raises `BookingError` otherwise.
- `cancel(member, session, now)`: cancel a booking.
  - Frees the place.
  - Refund if cancelled **at least 24 hours** before start.
  - Returns True if refunded, else False.
- Each session has its own waitlist.
- Times are timezone-aware datetimes.
