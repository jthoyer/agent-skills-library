import sys
from datetime import date
sys.path.insert(0, sys.argv[1] if len(sys.argv) > 1 else ".")
from club.report import members_report

T = date(2026, 10, 20)
def m(name, email, renewal, active=True):
    return {"name": name, "email": email, "renewal": renewal, "active": active}

results = []
def check(label, cond):
    results.append((label, bool(cond)))

try:
    r = members_report([m("Ann Lee", "a@x.com", date(2027, 3, 1))], T)
    check("format", r == ["Lee, Ann — renews 01/03/2027"])
except Exception as e: check("format", False)
try:
    r = members_report([m("Bo Zed", "b@x.com", date(2027,1,1)), m("Cy Abe", "c@x.com", date(2027,1,1))], T)
    check("sort by surname", r[0].startswith("Abe, Cy") and r[1].startswith("Zed, Bo"))
except Exception: check("sort by surname", False)
try:
    r = members_report([m("Di Kay", "d@x.com", date(2027,1,1), active=False)], T)
    check("exclude inactive", r == [])
except Exception: check("exclude inactive", False)
try:
    r = members_report([m("Ed Fox", "Ed@X.com ", date(2026,12,1)), m("Ed Fox", "ed@x.com", date(2027,2,1))], T)
    check("dedupe keeps latest", r == ["Fox, Ed — renews 01/02/2027"])
except Exception: check("dedupe keeps latest", False)
try:
    r = members_report([m("Fi Gee", "f@x.com", date(2026,11,19))], T)
    check("DUE at +30 inclusive", r == ["Gee, Fi — renews 19/11/2026 — DUE"])
except Exception: check("DUE at +30 inclusive", False)
try:
    r = members_report([m("Gu Hay", "g@x.com", date(2026,11,20))], T)
    check("not DUE at +31", r == ["Hay, Gu — renews 20/11/2026"])
except Exception: check("not DUE at +31", False)
try:
    r = members_report([m("Hu Ink", "h@x.com", date(2026,10,1))], T)
    check("past is DUE", r == ["Ink, Hu — renews 01/10/2026 — DUE"])
except Exception: check("past is DUE", False)
try:
    r = members_report([m("Al Smith", "1@x.com", date(2027,1,1)), m("Zo Smith", "2@x.com", date(2027,1,1)), m("Mary Ann Jones", "3@x.com", date(2027,1,1))], T)
    check("tie-break first name + multi-word name", r[0].startswith("Jones, Mary Ann") and r[1].startswith("Smith, Al") and r[2].startswith("Smith, Zo"))
except Exception: check("tie-break first name + multi-word name", False)

for l, ok in results: print(("PASS " if ok else "FAIL ") + l)
print(f"{sum(ok for _, ok in results)}/{len(results)}")
