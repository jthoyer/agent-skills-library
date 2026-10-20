from datetime import datetime, timezone

from club.timeutil import hours_until


def due(member_id: str, sessions: list) -> list:
    now = datetime.now(timezone.utc)
    return [
        s for s in sessions
        if member_id in s.booked and 0 <= hours_until(s.start, now) <= 24
    ]
