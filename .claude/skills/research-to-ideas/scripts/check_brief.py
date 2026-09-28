#!/usr/bin/env python3
"""Mechanical checks for a research-to-ideas brief. Stdlib only.

Usage: check_brief.py brief.json      (exit 1 on any FAIL, 0 otherwise)

Input JSON:
{
  "weights":  {"reach": 3, "cost": 2, "time": 1, "fit": 3, "viability": 2, "speed": 2},
  "coverage": {"forums": "Reached", "verified revenue": "Not reached"},
  "ideas": [{
    "name": "Sell X", "confidence": "Medium",        # High | Medium | Low (as stated)
    "grade": "Inferred",                              # Tested | Confirmed | Inferred | Asserted
    "sources": 4, "source_classes": ["forums", "case studies"],
    "dominant_class_share": 0.6,                      # share of evidence from one class
    "denominator": "Unknown",                         # "Unknown" or e.g. "12 of 200"
    "blocker": false,                                 # true = blocker with no workaround
    "scores": {"reach": 4, "cost": 3, ...},           # 1-5, one per weight key
    "stated_total": 41.0,                             # optional: total the brief printed
    "outcome": {"low": 0, "base": 400, "high": 1200}
  }],
  "decision_rule": [                                  # metric ranges, min inclusive, max exclusive
    {"outcome": "Stop", "max": 5}, {"outcome": "Change", "min": 5, "max": 20},
    {"outcome": "Continue", "min": 20}
  ]
}
"""
import json, sys

TIERS = {"High": 3, "Medium": 2, "Low": 1}
STRONG = {"Tested", "Confirmed"}
out = []


def flag(level, msg):
    out.append((level, msg))


def max_conf(idea, not_reached):
    """Highest confidence the SKILL.md rules allow; the brief may state lower, never higher."""
    weak = (idea["grade"] not in STRONG or idea["sources"] < 5 or idea["denominator"] == "Unknown"
            or idea.get("blocker") or not_reached)
    if idea["grade"] == "Asserted" or idea["sources"] < 3 or idea.get("blocker"):
        return "Low"
    if weak or idea.get("dominant_class_share", 0) > 0.5 or len(idea["source_classes"]) < 2:
        return "Medium"
    return "High"


def check(brief):
    w = brief["weights"]
    not_reached = [c for c, s in brief.get("coverage", {}).items() if s != "Reached"]
    ranked = []
    for i in brief["ideas"]:
        n = i["name"]
        if set(i["scores"]) != set(w):
            flag("FAIL", f"{n}: scores {sorted(i['scores'])} do not match weights {sorted(w)}")
            continue
        if not all(1 <= v <= 5 for v in i["scores"].values()):
            flag("FAIL", f"{n}: a score is outside 1-5")
        total = sum(w[k] * i["scores"][k] for k in w)
        if "stated_total" in i and abs(i["stated_total"] - total) > 0.01:
            flag("FAIL", f"{n}: stated total {i['stated_total']} != computed {total}")
        cap = max_conf(i, not_reached)
        if TIERS[i["confidence"]] > TIERS[cap]:
            flag("FAIL", f"{n}: confidence {i['confidence']} exceeds the cap ({cap}) the evidence allows")
        o = i.get("outcome", {})
        if o and not (o["low"] <= o["base"] <= o["high"]):
            flag("FAIL", f"{n}: outcome range is not low <= base <= high")
        ranked.append((n, TIERS[i["confidence"]], total))
    order = [n for n, _, _ in sorted(ranked, key=lambda r: (-r[1], -r[2]))]
    flag("INFO", "Ranking (confidence tier, then score): " + " > ".join(order))
    if not_reached:
        flag("INFO", f"Not reached: {', '.join(not_reached)}; confidence caps at Medium")

    rule = brief.get("decision_rule")
    if rule:
        pts = sorted(rule, key=lambda r: r.get("min", float("-inf")))
        edge = float("-inf")
        for r in pts:
            lo, hi = r.get("min", float("-inf")), r.get("max", float("inf"))
            if lo > edge:
                flag("FAIL", f"decision rule gap: nothing covers [{edge}, {lo}) before {r['outcome']}")
            if lo < edge:
                flag("FAIL", f"decision rule overlap: {r['outcome']} starts at {lo}, below {edge}")
            edge = max(edge, hi)
        if edge != float("inf"):
            flag("FAIL", f"decision rule gap: nothing covers results from {edge} upward")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    check(json.load(open(sys.argv[1])))
    for level, msg in out:
        print(f"{level}: {msg}")
    fails = sum(1 for l, _ in out if l == "FAIL")
    print(f"{'FAIL' if fails else 'PASS'}: {fails} defect(s)")
    sys.exit(1 if fails else 0)
