#!/usr/bin/env python3
"""Mechanical checks for a multi-actor-strategy run. Stdlib only.

Usage: check_strategy.py run.json      (exit 1 on any FAIL, 0 otherwise)

Checks the nine rules in references/agent-plan.md ("What the script checks") that need no
judgment. Each rule applies from the stage where SKILL.md makes it due, so the same file can be
checked after Stage 1, 2, 3 and 4 as the run fills it in. A malformed run is reported as FAIL
lines, never as a traceback.

Rules, and the stage each starts at:
  R1 options      (1)  at least three options, one of them marked "sustain"
  R2 challenged   (2)  every option has a Stage 2 challenge entry (for, against, verdict)
  R3 removed      (2)  every eliminated option, or one demoted to a condition, has a reason
  R4 no-assumed   (4)  no Assumed grade in the recommendation's confidence or rationale
  R5 premortem    (3)  every surviving option (survived or qualified) has a pre-mortem entry
  R6 bets         (3)  a main-thread bet exists, and every juror who answered has a bet
  R7 pick-gap     (3)  if the challenger's strongest pick is not the preference, a written answer
  R8 wording      (4)  an embodied run, or one whose agent reported NOT BLIND, may not claim
                       "blind" or "independently stress-tested" in the final brief
  R9 metric       (3)  at least one decision criterion names a business metric, or
                       skipped.metric says why none applies

Input JSON (keys marked optional may be left out):
{
  "stage": 4,                              # last stage completed, 1-4
  "embodied": false,                       # true if any role ran in the main thread
  "preference": "B",                       # option the main thread favoured entering Stage 2
  "skipped": {"bets": "fast pass, owner asked"},   # optional: step -> reason (council, bets, metric)
  "options": [{
    "id": "A", "name": "Sustain",
    "sustain": true,                       # optional: marks the sustain / do-nothing option
    "status": "qualified",                 # survived | qualified | eliminated | condition
    "reason": "",                          # required when eliminated or condition
    "challenge": {"for": "...", "against": "...", "verdict": "..."},     # from Stage 2
    "premortem": [{"failure": "...", "warning": "...", "mitigation": "..."}]   # from Stage 3
  }],
  "challenger": {"mode": "dispatched",     # dispatched | embodied
                 "blind": true,            # the agent's BLIND line: yes -> true
                 "strongest_pick": "A"},
  "pick_gap_answer": "",                   # required when strongest_pick != preference
  "criteria": [{"criterion": "...",        # Decision Architect's criteria, from Stage 3
                "metric": "90-day retention"}],   # at least one names a metric (R9)
  "council": {"mode": "dispatched",        # dispatched | embodied | skipped
              "answers": [{"by": "juror-1", "role": "juror", "blind": true,
                           "strongest": "A", "blind_spot": "B", "missed": "..."}]},
  "bets": [{"by": "juror-1", "role": "juror", "option": "A", "confidence": 60},
           {"by": "main thread", "role": "main", "option": "B", "confidence": 70}],
                                           # role: juror | main | advocate (advocate bets are
                                           # written by the main thread, so they count as its bet)
  "recommendation": {"option": "B", "confidence": "Reasoned",   # Supported | Reasoned | Assumed
                     "rationale": [{"claim": "...", "grade": "Supported"}]},
  "brief_text": "the final Stage 4 brief as communicated"
}
"""
import json
import re
import sys

STATUSES = {"survived", "qualified", "eliminated", "condition"}
SURVIVING = {"survived", "qualified"}
REMOVED = {"eliminated", "condition"}
GRADES = {"Supported", "Reasoned", "Assumed"}
MODES = {"dispatched", "embodied"}
COUNCIL_MODES = MODES | {"skipped"}
BET_ROLES = {"juror", "main", "advocate"}
MIN_OPTIONS = 3
# Words an embodied or not-blind run may not use about itself (SKILL.md, agent-workflow.md).
# "blind spot" is ordinary strategy vocabulary, not a claim about the process.
BLIND_CLAIMS = [r"\bblind(?![\s-]*spots?\b)", r"\bindependent(ly)?[\s-]+stress[\s-]*test"]

out = []


def flag(level, rule, msg):
    out.append((level, rule, msg))


def text(v):
    return isinstance(v, str) and v.strip() != ""


def valid_options(run):
    """Return the options that are well formed, reporting the rest."""
    opts = run.get("options")
    if not isinstance(opts, list):
        flag("FAIL", "schema", "options must be a list")
        return []
    good, seen = [], set()
    for o in opts:
        if not isinstance(o, dict):
            flag("FAIL", "schema", f"option {o!r} is not an object")
            continue
        oid = o.get("id")
        if not text(oid):
            flag("FAIL", "schema", f"option {o.get('name', '?')!r} has no id")
            continue
        if oid in seen:
            flag("FAIL", "schema", f"option id {oid} appears twice")
            continue
        seen.add(oid)
        if o.get("status") not in STATUSES:
            flag("FAIL", "schema", f"option {oid}: status {o.get('status')!r} is not one of {sorted(STATUSES)}")
            continue
        good.append(o)
    return good


def r1_options(opts):
    if len(opts) < MIN_OPTIONS:
        flag("FAIL", "R1", f"{len(opts)} options; Stage 1 needs at least {MIN_OPTIONS}")
    if not any(o.get("sustain") is True for o in opts):
        flag("FAIL", "R1", 'no option is marked "sustain": true; Stage 1 needs a sustain / do-nothing option')


def r2_challenged(opts):
    for o in opts:
        c = o.get("challenge")
        if not isinstance(c, dict) or not all(text(c.get(k)) for k in ("for", "against", "verdict")):
            flag("FAIL", "R2", f"option {o['id']}: no Stage 2 challenge entry (needs for, against and verdict)")


def r3_removed(opts):
    for o in opts:
        if o["status"] in REMOVED and not text(o.get("reason")):
            flag("FAIL", "R3", f"option {o['id']}: {o['status']} with no recorded reason")


def r5_premortem(opts):
    for o in opts:
        if o["status"] not in SURVIVING:
            continue
        pm = o.get("premortem")
        if not isinstance(pm, list) or not any(isinstance(p, dict) and text(p.get("failure")) for p in pm):
            flag("FAIL", "R5", f"option {o['id']}: surviving ({o['status']}) with no pre-mortem entry")


def r6_bets(run, ids):
    skipped = run.get("skipped") or {}
    bets = run.get("bets") or []
    if not isinstance(bets, list):
        flag("FAIL", "R6", "bets must be a list")
        return
    if text(skipped.get("bets")):
        flag("INFO", "R6", f"conviction bets skipped: {skipped['bets']}")
        return
    ok = []
    for b in bets:
        if not isinstance(b, dict) or b.get("role") not in BET_ROLES or not text(b.get("by")):
            flag("FAIL", "R6", f"bet {b!r} needs by and a role from {sorted(BET_ROLES)}")
            continue
        conf = b.get("confidence")
        if b.get("option") not in ids:
            flag("FAIL", "R6", f"bet by {b['by']}: option {b.get('option')!r} is not an option id")
        elif isinstance(conf, bool) or not isinstance(conf, (int, float)) or not 0 <= conf <= 100:
            flag("FAIL", "R6", f"bet by {b['by']}: confidence must be a number 0-100")
        else:
            ok.append(b)
    if not any(b["role"] in ("main", "advocate") for b in ok):
        flag("FAIL", "R6", "no main-thread bet recorded (role main, or advocate bets in an embodied run)")
    council = run.get("council") or {}
    answers = council.get("answers") or []
    betters = {b["by"] for b in ok if b["role"] == "juror"}
    for a in answers:
        if isinstance(a, dict) and a.get("role") == "juror" and a.get("by") not in betters:
            flag("FAIL", "R6", f"juror {a.get('by')!r} answered the council but has no bet recorded")


def r7_pick_gap(run, ids):
    ch = run.get("challenger")
    pref = run.get("preference")
    if not isinstance(ch, dict) or ch.get("mode") not in MODES:
        flag("FAIL", "R7", f"challenger needs a mode from {sorted(MODES)}")
        return
    pick = ch.get("strongest_pick")
    if pick not in ids or pref not in ids:
        flag("FAIL", "R7", f"challenger strongest_pick {pick!r} and preference {pref!r} must both be option ids")
        return
    if pick != pref and not text(run.get("pick_gap_answer")):
        flag("FAIL", "R7", f"challenger's strongest pick is {pick}, the preference is {pref}, "
             "and no pick_gap_answer is written")
    elif pick != pref:
        flag("INFO", "R7", f"pick gap {pick} vs {pref} answered in writing")


def r9_metric(run):
    skipped = run.get("skipped")
    if isinstance(skipped, dict) and text(skipped.get("metric")):
        flag("INFO", "R9", f"no business metric: {skipped['metric']}")
        return
    crit = run.get("criteria")
    if not isinstance(crit, list) or not any(isinstance(c, dict) and text(c.get("metric")) for c in crit):
        flag("FAIL", "R9", "no decision criterion names a business metric; add one from the "
             "Decision Hook, or say why none applies in skipped.metric")


def r4_no_assumed(run):
    rec = run.get("recommendation")
    if not isinstance(rec, dict):
        flag("FAIL", "R4", "stage 4 run has no recommendation")
        return
    if rec.get("confidence") not in GRADES:
        flag("FAIL", "R4", f"recommendation confidence {rec.get('confidence')!r} is not one of {sorted(GRADES)}")
    elif rec["confidence"] == "Assumed":
        flag("FAIL", "R4", "recommendation confidence is Assumed; reclassify or remove before Stage 4")
    for r in rec.get("rationale") or []:
        g = r.get("grade") if isinstance(r, dict) else None
        if g not in GRADES:
            flag("FAIL", "R4", f"rationale {r!r} needs a grade from {sorted(GRADES)}")
        elif g == "Assumed":
            flag("FAIL", "R4", f"rationale graded Assumed reaches Stage 4: {r.get('claim', '')[:60]!r}")


def r8_wording(run):
    embodied = run.get("embodied")
    if not isinstance(embodied, bool):
        flag("FAIL", "R8", "embodied must be true or false")
        return
    ch = run.get("challenger") or {}
    council = run.get("council") or {}
    roles = [("challenger", ch.get("mode"))] + [("council", council.get("mode"))]
    ran_inline = [n for n, m in roles if m == "embodied"]
    if ran_inline and not embodied:
        flag("FAIL", "R8", f"{', '.join(ran_inline)} ran embodied but the run says embodied: false")
    not_blind = []
    if ch.get("mode") == "dispatched" and ch.get("blind") is not True:
        not_blind.append("challenger")
    for a in council.get("answers") or []:
        if isinstance(a, dict) and a.get("role") == "juror" and a.get("blind") is not True:
            not_blind.append(str(a.get("by")))
    if not (embodied or ran_inline or not_blind):
        return
    why = "embodied run" if (embodied or ran_inline) else f"NOT BLIND: {', '.join(not_blind)}"
    brief = run.get("brief_text")
    if not isinstance(brief, str):
        flag("FAIL", "R8", "stage 4 run has no brief_text to check")
        return
    for pat in BLIND_CLAIMS:
        m = re.search(pat, brief, re.IGNORECASE)
        if m:
            flag("FAIL", "R8", f"{why}, but the brief claims {m.group(0)!r}; write "
                 "\"stress-tested by author\" / \"self-reviewed council\" instead")


def check(run):
    stage = run.get("stage")
    if isinstance(stage, bool) or stage not in (1, 2, 3, 4):
        flag("FAIL", "schema", f"stage must be 1, 2, 3 or 4, got {stage!r}")
        return
    opts = valid_options(run)
    ids = {o["id"] for o in opts}
    r1_options(opts)
    if stage >= 2:
        r2_challenged(opts)
        r3_removed(opts)
    if stage >= 3:
        r5_premortem(opts)
        r6_bets(run, ids)
        r7_pick_gap(run, ids)
        r9_metric(run)
        council = run.get("council") or {}
        if council.get("mode") not in COUNCIL_MODES:
            flag("FAIL", "schema", f"council needs a mode from {sorted(COUNCIL_MODES)}")
        elif council["mode"] == "skipped" and not text((run.get("skipped") or {}).get("council")):
            flag("FAIL", "schema", "council skipped with no reason in skipped.council")
    if stage >= 4:
        r4_no_assumed(run)
        r8_wording(run)
    flag("INFO", "-", f"stage {stage}; {len(opts)} options; "
         f"surviving {sorted(o['id'] for o in opts if o['status'] in SURVIVING)}")


def main(argv):
    if len(argv) != 2:
        sys.exit(__doc__)
    try:
        with open(argv[1], encoding="utf-8") as fh:
            run = json.load(fh)
    except (OSError, json.JSONDecodeError) as e:
        print(f"FAIL [schema]: cannot read run: {e}")
        return 1
    if not isinstance(run, dict):
        print("FAIL [schema]: run must be a JSON object")
        return 1
    try:
        check(run)
    except (AttributeError, TypeError, KeyError) as e:
        flag("FAIL", "schema", f"malformed run: {type(e).__name__}: {e}")
    for level, rule, msg in out:
        print(f"{level} [{rule}]: {msg}")
    fails = sum(1 for level, _, _ in out if level == "FAIL")
    print(f"{'FAIL' if fails else 'PASS'}: {fails} defect(s)")
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
