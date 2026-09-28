#!/usr/bin/env python3
"""Mechanical checks for a research-to-ideas brief. Stdlib only.

Usage: check_brief.py brief.json      (exit 1 on any FAIL, 0 otherwise)

Checks the arithmetic and rules in SKILL.md that need no judgment: weights, score range,
totals, confidence caps, the ranking rule, the Stage 6 demotion and decision-rule coverage.
A malformed brief is reported as FAIL lines, never as a traceback.

Input JSON (every key shown is required unless marked optional):
{
  "priority": ["reach", "speed"],          # the two doubled criteria (Stage 0)
  "embodied": false,                       # true = no Agent tool; audit was self-graded
  "coverage": {"forums": "Reached", "verified revenue": "Not reached"},  # Reached|Partial|Not reached
  "ideas": [{
    "name": "Sell X",
    "confidence": "Medium",                # High | Medium | Low, as the brief states it
    "grade": "Inferred",                   # Tested | Confirmed | Inferred | Asserted | Contested
    "sources": 4,                          # independent sources
    "dominant_class_share": 0.6,           # share of sources from the biggest class
    "denominator": "unknown",              # known | estimated | unknown
    "blocker": "none",                     # none | workaround | hard
    "severity": "Manageable",              # optional: idea-challenger verdict, Blocks demotes to Low
    "scores": {"reach": 4, "cost": 3, "speed": 5, "fit": 3, "upside": 2},
    "stated_total": 26,                    # optional: the total the brief printed
    "stated_rank": 1,                      # optional: the rank the brief printed
    "outcome": {"low": 0, "base": 400, "high": 1200}   # optional
  }],
  "decision_rule": [                       # optional until Stage 8; min inclusive, max exclusive
    {"outcome": "Stop", "max": 3}, {"outcome": "Change", "min": 3, "max": 10},
    {"outcome": "Continue", "min": 10}
  ]
}
"""
import json
import sys

CRITERIA = {"reach", "cost", "speed", "fit", "upside"}
TIERS = {"High": 3, "Medium": 2, "Low": 1}
NAMES = {v: k for k, v in TIERS.items()}
GRADE_TIER = {"Tested": 3, "Confirmed": 3, "Inferred": 2, "Asserted": 1, "Contested": 1}
DENOM_TIER = {"known": 3, "estimated": 2, "unknown": 1}
BLOCKER_TIER = {"none": 3, "workaround": 2, "hard": 1}
COVERAGE = {"Reached", "Partial", "Not reached"}
MAX_IDEAS = 8
INF = float("inf")

out = []


def flag(level, msg):
    out.append((level, msg))


def cap_for(idea, coverage_short, embodied):
    """Lowest tier any SKILL.md Stage 5 check allows, with the check that set it."""
    s = idea["sources"]
    checks = [
        (GRADE_TIER[idea["grade"]], f"grade {idea['grade']}"),
        (3 if s >= 5 else 2 if s >= 3 else 1, f"{s} independent sources"),
        (DENOM_TIER[idea["denominator"]], f"denominator {idea['denominator']}"),
        (BLOCKER_TIER[idea["blocker"]], f"blocker {idea['blocker']}"),
    ]
    if coverage_short or idea.get("dominant_class_share", 0) > 0.5:
        checks.append((2, "coverage"))
    if embodied:
        checks.append((2, "embodied audit"))
    if idea.get("severity") == "Blocks":
        checks.append((1, "challenger rated Blocks"))
    return min(checks)


def valid(idea):
    """Report a malformed idea and return False, so one bad row never crashes the run."""
    n = idea.get("name", "<unnamed>")
    need = {"name", "confidence", "grade", "sources", "denominator", "blocker", "scores"}
    missing = need - set(idea)
    if missing:
        flag("FAIL", f"{n}: missing {sorted(missing)}")
        return False
    for key, allowed in (("confidence", TIERS), ("grade", GRADE_TIER),
                         ("denominator", DENOM_TIER), ("blocker", BLOCKER_TIER)):
        if idea[key] not in allowed:
            flag("FAIL", f"{n}: {key} '{idea[key]}' is not one of {sorted(allowed)}")
            return False
    if set(idea["scores"]) != CRITERIA:
        flag("FAIL", f"{n}: scores {sorted(idea['scores'])} must be exactly {sorted(CRITERIA)}")
        return False
    return True


def check_rule(rule):
    names = sorted(r.get("outcome", "?") for r in rule)
    if names != ["Change", "Continue", "Stop"]:
        flag("FAIL", f"decision rule needs exactly Stop, Change and Continue, got {names}")
    edge = -INF
    for r in sorted(rule, key=lambda r: r.get("min", -INF)):
        lo, hi = r.get("min", -INF), r.get("max", INF)
        if hi <= lo:
            flag("FAIL", f"decision rule: {r.get('outcome')} range [{lo}, {hi}) is empty")
        if lo > edge:
            flag("FAIL", f"decision rule gap: nothing covers [{edge}, {lo}) before {r.get('outcome')}")
        elif lo < edge:
            flag("FAIL", f"decision rule overlap: {r.get('outcome')} starts at {lo}, below {edge}")
        edge = max(edge, hi)
    if edge != INF:
        flag("FAIL", f"decision rule gap: nothing covers results from {edge} upward")


def check(brief):
    priority = brief.get("priority", [])
    if len(priority) != 2 or len(set(priority)) != 2 or not set(priority) <= CRITERIA:
        flag("FAIL", f"priority must name two different criteria from {sorted(CRITERIA)}, got {priority}")
        priority = []
    weights = {c: 2 if c in priority else 1 for c in CRITERIA}

    coverage = brief.get("coverage", {})
    bad = {c: s for c, s in coverage.items() if s not in COVERAGE}
    if bad:
        flag("FAIL", f"coverage values must be one of {sorted(COVERAGE)}: {bad}")
    short = [c for c, s in coverage.items() if s != "Reached"]
    embodied = bool(brief.get("embodied", False))

    ideas = brief.get("ideas", [])
    if not ideas:
        flag("FAIL", "no ideas in the brief")
    if len(ideas) > MAX_IDEAS:
        flag("FAIL", f"{len(ideas)} ideas; Stage 3 carries at most {MAX_IDEAS} into scoring")

    ranked = []
    for i in ideas:
        if not valid(i):
            continue
        n = i["name"]
        if not all(isinstance(v, int) and 1 <= v <= 5 for v in i["scores"].values()):
            flag("FAIL", f"{n}: every score must be a whole number 1-5")
            continue
        total = sum(weights[k] * v for k, v in i["scores"].items())
        if "stated_total" in i and abs(i["stated_total"] - total) > 0.01:
            flag("FAIL", f"{n}: stated total {i['stated_total']} != computed {total}")
        tier, why = cap_for(i, short, embodied)
        if TIERS[i["confidence"]] > tier:
            flag("FAIL", f"{n}: confidence {i['confidence']} exceeds the cap {NAMES[tier]} set by {why}")
        o = i.get("outcome")
        if o is not None:
            try:
                if not o["low"] <= o["base"] <= o["high"]:
                    flag("FAIL", f"{n}: outcome range is not low <= base <= high")
            except (KeyError, TypeError):
                flag("FAIL", f"{n}: outcome needs numeric low, base and high")
        ranked.append((n, TIERS[i["confidence"]], total, i.get("stated_rank")))

    ranked.sort(key=lambda r: (-r[1], -r[2]))
    for pos, (n, _, _, stated) in enumerate(ranked, 1):
        if stated is not None and stated != pos:
            flag("FAIL", f"{n}: stated rank {stated}, but the ranking rule puts it at {pos}")
    for a, b in zip(ranked, ranked[1:]):
        if a[1:3] == b[1:3]:
            flag("WARN", f"{a[0]} and {b[0]} tie on tier and score; say how the tie was broken")
    flag("INFO", "Ranking (confidence tier, then score): "
         + " > ".join(f"{n} ({NAMES[t]}, {s})" for n, t, s, _ in ranked))
    if short:
        flag("INFO", f"Not fully reached: {', '.join(short)}; confidence caps at Medium")
    if embodied:
        flag("INFO", "Embodied run: confidence caps at Medium")
    if not any(t >= 2 for _, t, _, _ in ranked) and ranked:
        flag("INFO", "No idea reaches Medium; SKILL.md Stage 7 says the call is 'back nothing yet'")

    if brief.get("decision_rule"):
        check_rule(brief["decision_rule"])


def main(argv):
    if len(argv) != 2:
        sys.exit(__doc__)
    try:
        with open(argv[1], encoding="utf-8") as fh:
            brief = json.load(fh)
    except (OSError, json.JSONDecodeError) as e:
        print(f"FAIL: cannot read brief: {e}")
        return 1
    if not isinstance(brief, dict):
        print("FAIL: brief must be a JSON object")
        return 1
    check(brief)
    for level, msg in out:
        print(f"{level}: {msg}")
    fails = sum(1 for level, _ in out if level == "FAIL")
    print(f"{'FAIL' if fails else 'PASS'}: {fails} defect(s)")
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
