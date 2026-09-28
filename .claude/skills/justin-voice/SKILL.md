---
name: justin-voice
description: >
  Calibrates Claude's writing to Justin's voice and analytical language patterns. Covers
  declarative structure, cause-effect precision, compression that earns its keep, and SCR
  framing as default. Use whenever Justin asks for a document, rationale, brief, or narrative
  output and wants it to sound like him rather than like generic AI prose. Trigger on: "write
  this in my voice", "make this sound like me", "apply my language style", "Justin voice",
  "voice calibration", or whenever producing analytical or executive-facing content for Justin's
  use where authenticity of authorship matters. Always apply the humanizer skill as a final pass.
metadata:
  author: Justin Hoyer
  version: 1.1.0
---

# Justin Voice

Calibrates Claude's writing to match Justin's documented analytical language style. The goal is
prose that Justin could have written, not prose that merely sounds professional.

---

## Core principle

Justin's writing earns its density. Every compressed phrase has a meaning that can be unpacked
if challenged ("what did you mean by this?"). The writing is not obscure. It is precise.
Precision is not the same as complexity.

---

## Voice characteristics

### 1. Declarative, not hedged

State the claim. Do not soften it with qualifiers before it or caveats after it.

> ✗ A percentage figure may, in certain contexts, have limited utility for root cause analysis.
> ✓ A percentage figure tells you what happened. It does not tell you why.

Where confidence is genuinely limited, say so once, directly. Then move on. Do not
hedge the prose itself.

### 2. Cause-effect legibility

The mechanism must be visible. The reader should see how one thing produces another.

> ✗ Delayed decisions are associated with longer claim duration.
> ✓ Delayed decisions extend claim duration.

Justin writes the cause-and-effect chain as a sequence, not a correlation. The verb
carries the causal logic.

### 3. Short sentences carry the key claim

The most important point in a paragraph often sits in the shortest sentence. It sits alone,
without a qualifier before it and a caveat after it.

> "Service patterns are the unit of diagnosis. Percentage figures are the confirmation
> that a diagnosis was right — or wrong."

Use this deliberately. One short sentence. Then the explanation.

### 4. Compression that earns its keep

Justin uses compressed phrases ("the programme loses the mechanism") that pack a precise
analytical claim. These are not vague shorthand. They are shorthand for a fully
articulable argument. If challenged, the phrase must unpack cleanly.

Test: can you explain the compressed phrase in three sentences without losing the
meaning? If yes, the compression is earned. If not, expand it.

### 5. Specific over vague

Name the thing. Cite the source. Give the number.

> ✗ Evidence from a recent audit suggests some inconsistency.
> ✓ The QBE NI audit (May 2025) identified handover-related decision gaps across 23% of
>   sampled claims.

Specificity is credibility. Vagueness undermines the analytical register Justin writes in.

### 6. Active voice, present tense where possible

> ✗ Duration is extended by delayed decisions.
> ✓ Delayed decisions extend duration.

Active voice keeps the causal chain legible. Passive voice obscures who or what is
responsible.

### 7. No puffery, no significance inflation

Never: "This is a pivotal moment," "this represents a transformative shift," "this
underscores the importance of."

Justin's writing does not inflate. The significance of a claim is demonstrated by the
argument, not asserted in the framing.

### 8. SCR as the default structural arc

Situation, Complication, Resolution. The Resolution leads with the governing thought
(answer first), supported by MECE key points, with evidence below each point.

This is not a rigid template. It is a default narrative arc. Even informal outputs
tend to follow this logic: here is the context, here is the tension, here is the answer.

---

## Rhythm and register

Justin's prose varies sentence length deliberately. Long sentences build context or
list evidence. Short sentences land the claim. The contrast is the rhythm.

> "The percentage figure against a driver is a useful screening tool. It tells you where
> something is worth looking at. The service pattern is the analytical unit. It tells you
> what to look at, what constitutes a failure, and what a working alternative looks like."

Short, short, short, long. The short sentences accumulate weight. The long
sentence delivers the payload.

---

## What to avoid

| Pattern | Why it breaks the voice |
|---|---|
| Hedged prose ("may," "could," "in some cases") | Undermines declarative register |
| Passive voice chains | Obscures causal logic |
| Significance inflation ("pivotal," "transformative") | Unearnable without evidence |
| Rule of three for rhythm only | Justin's lists earn membership; they are not decorative |
| Em dashes | Replace with a full stop or rewrite the sentence |
| Signposting ("let's explore," "in this section") | Announces rather than does |
| Generic positives at close ("exciting times ahead") | Justin ends on the implication, not the mood |

---

## Application process

1. Draft in Justin's voice using the characteristics above.
2. Apply the `humanizer` skill as a final pass to strip remaining AI patterns.
3. Read aloud test: does this sound like a person wrote it, or like a tool assembled it?

---

## Related skills

- `humanizer`: final pass to strip AI writing patterns; always run after drafting
- `scr-pyramid-communicator`: governs the structural logic Justin defaults to
- `content-research-writer`: for long-form content; Justin voice applies within it
