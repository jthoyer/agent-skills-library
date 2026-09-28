#!/usr/bin/env python3
"""Tests for check_brief.py. Stdlib only: python3 test_check_brief.py"""
import copy
import json
import os
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
SCRIPT = os.path.join(HERE, "check_brief.py")

GOOD = {
    "priority": ["reach", "speed"],
    "embodied": False,
    "coverage": {"forums": "Reached", "case studies": "Reached"},
    "ideas": [
        {"name": "Sell templates", "confidence": "High", "grade": "Confirmed", "sources": 6,
         "dominant_class_share": 0.5, "denominator": "known", "blocker": "none",
         "scores": {"reach": 4, "cost": 4, "speed": 5, "fit": 3, "upside": 3},
         "stated_total": 28, "stated_rank": 1, "outcome": {"low": 0, "base": 150, "high": 600}},
        {"name": "Run a paid audit", "confidence": "Medium", "grade": "Inferred", "sources": 4,
         "denominator": "estimated", "blocker": "workaround",
         "scores": {"reach": 5, "cost": 5, "speed": 5, "fit": 5, "upside": 5},
         "stated_total": 35, "stated_rank": 2},
    ],
    "decision_rule": [{"outcome": "Stop", "max": 3},
                      {"outcome": "Change", "min": 3, "max": 10},
                      {"outcome": "Continue", "min": 10}],
}


def run(brief):
    with tempfile.NamedTemporaryFile("w", suffix=".json", delete=False) as fh:
        fh.write(brief if isinstance(brief, str) else json.dumps(brief))
    try:
        p = subprocess.run([sys.executable, SCRIPT, fh.name], capture_output=True, text=True)
    finally:
        os.unlink(fh.name)
    return p.returncode, p.stdout + p.stderr


def edit(fn):
    b = copy.deepcopy(GOOD)
    fn(b)
    return b


class CheckBrief(unittest.TestCase):
    def fails(self, brief, needle):
        code, out = run(brief)
        self.assertEqual(code, 1, out)
        self.assertIn(needle, out)
        self.assertNotIn("Traceback", out)

    def test_good_brief_passes(self):
        code, out = run(GOOD)
        self.assertEqual(code, 0, out)
        self.assertIn("Sell templates (High, 28) > Run a paid audit (Medium, 35)", out)

    def test_wrong_total(self):
        self.fails(edit(lambda b: b["ideas"][0].update(stated_total=30)), "stated total 30")

    def test_contested_caps_low(self):
        self.fails(edit(lambda b: b["ideas"][1].update(grade="Contested")), "cap Low set by grade Contested")

    def test_estimated_denominator_caps_medium(self):
        self.fails(edit(lambda b: b["ideas"][0].update(denominator="estimated")), "cap Medium")

    def test_partial_coverage_caps_medium(self):
        self.fails(edit(lambda b: b["coverage"].update(forums="Partial")), "set by coverage")

    def test_embodied_caps_medium(self):
        self.fails(edit(lambda b: b.update(embodied=True)), "set by embodied audit")

    def test_blocks_severity_caps_low(self):
        self.fails(edit(lambda b: b["ideas"][1].update(severity="Blocks")), "challenger rated Blocks")

    def test_rank_must_follow_rule(self):
        def swap(b):
            b["ideas"][0]["stated_rank"], b["ideas"][1]["stated_rank"] = 2, 1
        self.fails(edit(swap), "ranking rule puts it at")

    def test_decision_rule_gap(self):
        self.fails(edit(lambda b: b["decision_rule"][1].update(min=4)), "decision rule gap")

    def test_decision_rule_overlap(self):
        self.fails(edit(lambda b: b["decision_rule"][2].update(min=8)), "overlap")

    def test_decision_rule_missing_outcome(self):
        self.fails(edit(lambda b: b["decision_rule"].pop()), "exactly Stop, Change and Continue")

    def test_priority_must_be_two_criteria(self):
        self.fails(edit(lambda b: b.update(priority=["reach"])), "priority must name two")

    def test_unknown_grade_reported_not_crashed(self):
        self.fails(edit(lambda b: b["ideas"][0].update(grade="Solid")), "grade 'Solid'")

    def test_missing_field_reported_not_crashed(self):
        self.fails(edit(lambda b: b["ideas"][0].pop("scores")), "missing ['scores']")

    def test_score_out_of_range(self):
        self.fails(edit(lambda b: b["ideas"][0]["scores"].update(fit=6)), "whole number 1-5")

    def test_too_many_ideas(self):
        self.fails(edit(lambda b: b["ideas"].extend([copy.deepcopy(b["ideas"][1])] * 7)), "at most 8")

    def test_bad_json(self):
        self.fails("{not json", "cannot read brief")


if __name__ == "__main__":
    unittest.main()
