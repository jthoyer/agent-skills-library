from datetime import datetime


def hours_until(start: datetime, now: datetime) -> float:
    """Whole hours from now until start (negative once started)."""
    delta = start - now
    return delta.seconds / 3600
