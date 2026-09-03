---
name: editor
description: |
  Mechanical proofreading — grammar, punctuation, spelling, and consistency errors in a document
  the user hands over. Use when: proofreading a document, fixing typos, checking grammar,
  correcting punctuation, or verifying subject-verb agreement, tense, or pronoun consistency.
  For clarity, concision, style, or voice work on the same document, this skill hands off to
  `content-research-writer` (drafting/structure), `justin-voice` (analytical register), or
  `humanizer` (removing AI writing patterns) rather than duplicating their checklists.
license: MIT
metadata:
  author: awesome-llm-apps
  version: "2.0.0"
---

# Editor

Mechanical proofreader: fixes what's objectively wrong (spelling, grammar, punctuation,
consistency), not what's stylistically improvable. Style, concision, and voice are handled by
other skills — see Related Skills.

## When to apply

- Proofreading a document for surface errors before it goes out
- Checking grammar, punctuation, or capitalization
- Verifying consistency (terminology, formatting, tense) across a document
- Fixing unclear pronoun references or subject-verb agreement

## Not this skill

- Improving clarity, concision, or flow → `content-research-writer` (drafting a piece from
  scratch or under revision) has an explicit Edit-for-Clarity / Edit-for-Length step
- Matching or sharpening a specific voice → `justin-voice` (analytical register) or the relevant
  content-voice catalogue for other registers
- Removing AI-sounding phrasing (puffery, signposting, filler) → `humanizer`
- Compressing Claude's own conversational replies → `terse-mode` (that's reply length, not a
  handed-over document)

If a proofreading pass surfaces a clarity or voice problem, name it in one line and route to the
right skill rather than fixing it here.

## Checklist

**Mechanics**
- [ ] Spelling and typos
- [ ] Subject-verb agreement
- [ ] Verb tense consistent throughout
- [ ] Pronoun references unambiguous
- [ ] Punctuation correct (including quotation marks, apostrophes, serial commas per house style)
- [ ] Capitalization consistent
- [ ] No unintentional sentence fragments

**Consistency**
- [ ] Terminology used the same way throughout (not "customer" here, "client" there)
- [ ] Formatting consistent (heading levels, list style, date format, number style)
- [ ] Names, figures, and citations match across the document

## Output format

For a short document, edit inline and list the corrections. For a longer one:

```markdown
## Corrections
1. [Location] — [error] → [fix] — [why, if not obvious]
2. ...

## Flagged (not fixed here)
- [Clarity/concision/voice issue] — route to [skill name]
```

Don't rewrite for style while proofreading. A sentence that's grammatically correct but wordy or
flat is not an error — flag it and move on.

## Related Skills

- `content-research-writer` — clarity, concision, and structural editing for content being drafted
- `justin-voice` — analytical register for icare/executive work
- `humanizer` — strips AI writing patterns (puffery, signposting, filler)
- `terse-mode` — governs Claude's own conversational reply length, not document editing
