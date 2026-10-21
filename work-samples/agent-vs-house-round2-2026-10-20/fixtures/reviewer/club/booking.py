from club.members import is_active
from club.timeutil import hours_until
from club.models import Member, Session
from club.refunds import refund_cents

CUTOFF_HOURS = 2


class BookingError(Exception):
    pass


def _too_late(session: Session, now) -> bool:
    return hours_until(session.start, now) < CUTOFF_HOURS


def book(member: Member, session: Session, now) -> str:
    if not is_active(member, now.date()):
        raise BookingError("inactive member")
    if _too_late(session, now):
        raise BookingError("too close to start")
    if len(session.booked) >= session.capacity:
        session.waitlist.append(member.id)
        return "waitlisted"
    session.booked.append(member.id)
    return "booked"


def cancel(member: Member, session: Session, now) -> int:
    if member.id not in session.booked:
        raise BookingError("not booked")
    session.booked.remove(member.id)
    if session.waitlist:
        session.booked.append(session.waitlist.pop())
    return refund_cents(member, session, now)
