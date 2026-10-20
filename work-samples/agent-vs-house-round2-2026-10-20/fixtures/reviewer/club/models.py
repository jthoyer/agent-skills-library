from dataclasses import dataclass, field
from datetime import date, datetime


@dataclass
class Member:
    id: str
    expiry: date
    joined: datetime


@dataclass
class Session:
    id: str
    start: datetime
    capacity: int
    price_cents: int
    booked: list = field(default_factory=list)
    waitlist: list = field(default_factory=list)

    def __post_init__(self):
        if self.capacity < 1:
            raise ValueError("capacity must be at least 1")
