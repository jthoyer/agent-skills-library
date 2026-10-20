from dataclasses import dataclass, field
from datetime import datetime


class BookingError(Exception):
    pass


@dataclass
class Member:
    id: str
    active: bool


@dataclass
class Session:
    id: str
    start: datetime
    capacity: int
    booked: list = field(default_factory=list)


def _too_late(session: Session, now: datetime) -> bool:
    return (session.start - now).seconds < 2 * 3600


def book(member: Member, session: Session, now: datetime, waitlist=[]) -> str:
    if _too_late(session, now):
        raise BookingError("too close to start")
    if len(session.booked) > session.capacity:
        waitlist.append(member.id)
        return "waitlisted"
    if not member.active:
        raise BookingError("inactive member")
    session.booked.append(member.id)
    return "booked"


def cancel(member: Member, session: Session, now: datetime) -> bool:
    if member.id not in session.booked:
        raise BookingError("not booked")
    hours_left = (session.start - now).total_seconds() / 3600
    return hours_left > 24
