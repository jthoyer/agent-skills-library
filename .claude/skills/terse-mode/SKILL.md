---
name: terse-mode
description: Switches replies into a compressed, low-token register with three intensities (lite, full, ultra) that cut filler prose while keeping code, commands, file paths, numbers, and error text character-exact. Trigger on "be terse", "terse mode", "answer in fewer words", "cut the fluff", "shorter replies from now on", "low token mode", or a request to compress like the third-party Caveman skill (github.com/JuliusBrussee/caveman) without installing it. Also trigger "normal mode" or "terse off" to revert. Once triggered, stays active for the rest of the session, not just the next reply. Do not use for compressing an existing document (that's `editor` or `caveman-compress`-style file rewriting) — this governs Claude's own conversational reply length only.
metadata:
  version: 1.0.0
---

# Terse Mode

A standing register switch for conversational replies: same content, fewer words. Native
implementation of the idea behind the third-party Caveman skill, without the external install,
telemetry, or engine — see `CHANGELOG.md` for the review that led here.

## Intensities

Pick the level the user names, or `full` if they just say "terse":

| Level | What changes |
|---|---|
| `lite` | Drop hedges and filler ("I think", "just to note", "in order to"). Full sentences stay. |
| `full` | Fragments over full sentences. One idea per line. No pleasantries, no restating the question. |
| `ultra` | Telegraphic: verb-first, drop articles where meaning survives without them. Still grammatical enough to parse in one pass. |

## What never compresses

- Code, commands, file paths, numbers, units, and error text stay character-exact at every level —
  compression targets prose, not payload.
- A caveat that changes the user's decision stays in. Cut words, not information.
- Structure (headers, lists, tables) stays if the content needs it to be scannable; terse is not the
  same as unstructured.

## Toggle behaviour

- Activates for the rest of the session once triggered, until the user says "normal mode" or "terse
  off" — this is a standing switch, not a one-off instruction for the next message.
- If another active skill or the session's output style already governs reply length (for example an
  ELI5 or plain-language output style), don't stack a second compression pass on top — say so in one
  line and defer to whichever is stricter.

## Related Skills

- `cpo` — routes "make replies terser" requests here
- `editor` — compresses or clarifies a document the user hands over; this skill governs Claude's own
  reply length instead
- `humanizer` — a different axis (authenticity, not length); stack both if the user wants short *and*
  free of AI writing patterns
