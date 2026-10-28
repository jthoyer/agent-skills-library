#!/usr/bin/env python3
"""Tests for check_strategy.py. Stdlib only: python3 test_check_strategy.py

The passing fixture is the phase 1 baseline run rendered as JSON. It lives in work-samples/,
not in this skill, so a session running the skill never reads the baseline's preference. Each
decoy is a copy of it with exactly one rule broken, and must FAIL on that rule and no other.
A rule no decoy trips is not wired.
"""
import copy
import json
import os
import re
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
SCRIPT = os.path.join(HERE, "check_strategy.py")
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", "..", ".."))
FIXTURE = os.path.join(ROOT, "work-samples", "multi-actor-strategy-2026-09-29-baseline.json")

with open(FIXTURE, encoding="utf-8") as fh:
    BASE = json.load(fh)
# The baseline predates R9 (2026-10-28). Add its criterion here, not in the fixture, so the
# work sample stays the record of what that run produced.
BASE.setdefault("criteria", [{"criterion": "Adoption by the owner", "metric": "weekly runs completed"}])


def run(data):
    with tempfile.NamedTemporaryFile("w", suffix=".json", delete=False) as fh:
        fh.write(data if isinstance(data, str) else json.dumps(data))
    try:
        p = subprocess.run([sys.executable, SCRIPT, fh.name], capture_output=True, text=True)
    finally:
        os.unlink(fh.name)
    return p.returncode, p.stdout + p.stderr


def edit(fn, base=None):
    b = copy.deepcopy(base or BASE)
    fn(b)
    return b


def opt(b, pred):
    """The first option matching pred, so decoys never hard-code the baseline's letters."""
    return next(o for o in b["options"] if pred(o))


def surviving_non_preferred(b):
    return opt(b, lambda o: o["status"] in ("survived", "qualified") and o["id"] != b["preference"])


def dispatched(b):
    """The baseline re-shaped as a legitimate dispatched run: blind agents, jurors who bet."""
    other = surviving_non_preferred(b)["id"]
    b["embodied"] = False
    b["challenger"] = {"mode": "dispatched", "blind": True, "strongest_pick": other}
    b["pick_gap_answer"] = "The challenger rated the other option strongest; answered in the trade-off."
    b["council"] = {"mode": "dispatched", "answers": [
        {"by": f"juror-{n}", "role": "juror", "blind": True, "strongest": other,
         "blind_spot": b["preference"], "missed": "..."} for n in (1, 2)]}
    b["bets"] = [{"by": f"juror-{n}", "role": "juror", "option": other, "confidence": 60}
                 for n in (1, 2)] + [{"by": "main thread", "role": "main",
                                      "option": b["preference"], "confidence": 70}]
    b["brief_text"] += "\n\nThe council was blind-reviewed by two jurors."


DISPATCHED = edit(dispatched)


def rules_failed(out):
    return set(re.findall(r"^FAIL \[(\w+)\]", out, re.M))


class CheckStrategy(unittest.TestCase):
    def only(self, data, rule, needle=None):
        code, out = run(data)
        self.assertEqual(code, 1, out)
        self.assertEqual(rules_failed(out), {rule}, out)
        if needle:
            self.assertIn(needle, out)
        self.assertNotIn("Traceback", out)

    # --- passing runs ----------------------------------------------------------------
    def test_baseline_passes(self):
        code, out = run(BASE)
        self.assertEqual(code, 0, out)
        self.assertIn("PASS: 0 defect(s)", out)

    def test_dispatched_run_passes_and_may_claim_blind(self):
        code, out = run(DISPATCHED)
        self.assertEqual(code, 0, out)

    def test_embodied_brief_may_say_blind_spot(self):
        code, out = run(edit(lambda b: b.update(brief_text=b["brief_text"] + " Its blind spot: repos.")))
        self.assertEqual(code, 0, out)

    def test_rules_wait_for_their_stage(self):
        def stage2(b):
            b["stage"] = 2
            for o in b["options"]:
                o.pop("premortem", None)
            b.pop("bets")
            b.pop("recommendation")
        code, out = run(edit(stage2))
        self.assertEqual(code, 0, out)

    # --- one decoy per rule (R1-R9) ----------------------------------------------------
    def test_R1_no_sustain_option(self):
        self.only(edit(lambda b: opt(b, lambda o: o.get("sustain")).pop("sustain")), "R1", "sustain")

    def test_R1_fewer_than_three_options(self):
        def two(b):
            b["stage"] = 1
            b["options"] = [opt(b, lambda o: o.get("sustain")),
                            opt(b, lambda o: not o.get("sustain"))]
        self.only(edit(two), "R1", "at least 3")

    def test_R2_option_not_challenged(self):
        self.only(edit(lambda b: surviving_non_preferred(b).pop("challenge")), "R2", "no Stage 2 challenge")

    def test_R3_eliminated_without_reason(self):
        self.only(edit(lambda b: opt(b, lambda o: o["status"] == "eliminated").update(reason="")),
                  "R3", "no recorded reason")

    def test_R4_assumed_rationale_reaches_stage_4(self):
        self.only(edit(lambda b: b["recommendation"]["rationale"][0].update(grade="Assumed")),
                  "R4", "graded Assumed")

    def test_R4_assumed_confidence(self):
        self.only(edit(lambda b: b["recommendation"].update(confidence="Assumed")), "R4", "Assumed")

    def test_R5_surviving_option_without_premortem(self):
        self.only(edit(lambda b: surviving_non_preferred(b).pop("premortem")), "R5", "no pre-mortem")

    def test_R6_no_main_thread_bet(self):
        self.only(edit(lambda b: b.update(bets=[x for x in b["bets"]
                                                 if x["role"] not in ("main", "advocate")])),
                  "R6", "no main-thread bet")

    def test_R6_juror_without_bet(self):
        self.only(edit(lambda b: b["bets"].pop(0), DISPATCHED), "R6", "has no bet recorded")

    def test_R7_pick_gap_unanswered(self):
        def gap(b):
            b["challenger"]["strongest_pick"] = surviving_non_preferred(b)["id"]
            b["pick_gap_answer"] = ""
        self.only(edit(gap), "R7", "no pick_gap_answer")

    def test_R8_embodied_brief_claims_blind(self):
        self.only(edit(lambda b: b.update(brief_text=b["brief_text"] + " The options were blind-reviewed.")),
                  "R8", "blind")

    def test_R8_embodied_brief_claims_independent_stress_test(self):
        self.only(edit(lambda b: b.update(brief_text=b["brief_text"] + " C was independently stress-tested.")),
                  "R8", "independently stress-test")

    def test_R8_embodied_role_but_flag_false(self):
        self.only(edit(lambda b: b.update(embodied=False)), "R8", "ran embodied")

    def test_R8_not_blind_agent_cannot_back_a_blind_claim(self):
        self.only(edit(lambda b: b["challenger"].update(blind=False), DISPATCHED), "R8", "NOT BLIND")

    def test_R9_no_metric_criterion(self):
        self.only(edit(lambda b: b.update(criteria=[{"criterion": "Feels right", "metric": ""}])),
                  "R9", "business metric")

    def test_R9_missing_criteria(self):
        self.only(edit(lambda b: b.pop("criteria")), "R9", "business metric")

    def test_R9_skipped_with_reason_passes(self):
        def skip(b):
            b.pop("criteria")
            b["skipped"] = {"metric": "personal decision; no business metric applies"}
        code, out = run(edit(skip))
        self.assertEqual(code, 0, out)
        self.assertIn("INFO [R9]", out)

    # --- malformed input is a FAIL line, never a traceback -------------------------------
    def test_bad_json(self):
        self.only("{not json", "schema", "cannot read run")

    def test_unknown_status(self):
        code, out = run(edit(lambda b: b["options"][0].update(status="maybe")))
        self.assertEqual(code, 1, out)
        self.assertIn("status 'maybe'", out)
        self.assertNotIn("Traceback", out)

    def test_bad_bet_confidence(self):
        self.only(edit(lambda b: b["bets"][0].update(confidence="high")), "R6", "0-100")

    def test_missing_stage(self):
        self.only(edit(lambda b: b.pop("stage")), "schema", "stage must be")

    def test_wrong_types_do_not_crash(self):
        code, out = run(edit(lambda b: b.update(challenger="C", council=[], skipped="no")))
        self.assertEqual(code, 1, out)
        self.assertNotIn("Traceback", out)


if __name__ == "__main__":
    unittest.main()
