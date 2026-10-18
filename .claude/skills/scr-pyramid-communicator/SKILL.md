---
name: scr-pyramid-communicator
description: >
  Structures any communication — emails, slide decks, briefs, recommendations, escalations,
  or verbal pitches — using the McKinsey SCR framework (Situation–Complication–
  Resolution) combined with Barbara Minto's Pyramid Principle (answer first, MECE supporting
  arguments, evidence last). Use this skill whenever the user wants to write something
  persuasive, structured, or executive-facing; whenever they mention SCR, Pyramid Principle,
  MECE, structured communication, or "how do I frame this?"; whenever they need to present a
  recommendation, business case, or problem–solution narrative; or whenever they
  say things like "help me structure this", "make this more executive-ready", "frame this for
  leadership", or "how should I present this?". Always prefer this skill over ad-hoc drafting
  when the output needs to be clear, logical, and persuasive. For a short memo or email,
  scqa-framework is lighter. For project status updates, use project-management.
---

# SCR + Pyramid Principle Communicator

A skill for producing structured, executive-ready communication that combines two complementary frameworks developed at McKinsey:

- **SCR** (Situation–Complication–Resolution) — provides the *narrative arc*: context → tension → path forward
- **Pyramid Principle** (Barbara Minto) — provides the *structural logic*: answer first, MECE supporting arguments, evidence below

Together they produce communication that is easy to follow, hard to argue with, and oriented toward action.

---

## How the two frameworks fit together

Think of them as working on two levels simultaneously:

| Level | Framework | What it does |
|---|---|---|
| Macro (whole document/message) | SCR | Sets up the story: what's true, what's wrong, what to do |
| Micro (Resolution layer) | Pyramid Principle | Structures the recommendation itself: answer → arguments → evidence |

In practice: the Situation and Complication are kept **short and agreed**. The Resolution is where persuasion happens — and it should be structured as a pyramid (answer up top, MECE key points beneath, data/evidence at the base).

---

## Step-by-step process

### 1. Understand the communication task

Before drafting anything, establish:

- **Who is the audience?** (Executive, peer, client, team)
- **What format?** (Email, slide deck, brief, verbal pitch, status update)
- **What is the desired outcome?** (Approval, awareness, action, alignment)
- **What does the audience already know and accept?**

If the user hasn't provided this, ask. One or two quick questions now prevent wasted drafts.

---

### 2. Build the SCR narrative arc

#### S — Situation
A short, fact-based description of the current state that the audience already knows and agrees with. This is neutral. No problems yet.

**Rules:**
- Keep it to 1–3 sentences
- Use only facts the audience accepts as true
- Set the context without editorialising

> *Example: "Our customer satisfaction scores have declined 20% over the past two quarters."*

#### C — Complication
The disruption, tension, or problem that makes the situation no longer acceptable and demands a response. This is the hook.

**Rules:**
- Introduce genuine tension — without it, there's no reason to act
- Apply the **rule of three** where possible: three complications that reinforce each other are more memorable and harder to dismiss than one
- The complication should make the audience think: *"Yes, something must be done"*

> *Example: "Analysis indicates this is driven by longer wait times (CRM limitations), understaffing, and declining first-contact resolution rates — trends that are accelerating."*

#### R — Resolution
The specific, actionable path forward. This is where the Pyramid Principle takes over.

---

### 3. Structure the Resolution using the Pyramid Principle

The Resolution must be structured **top-down**:

```
        [Governing Thought / Answer]
               ↙        ↘
      [Key Point 1]   [Key Point 2]   [Key Point 3]
         ↓                ↓                ↓
    [Evidence/Data]  [Evidence/Data]  [Evidence/Data]
```

#### The Governing Thought (top of pyramid)
Lead with the answer. State the recommendation, conclusion, or proposed action in **one clear sentence** before anything else.

> *"We recommend a two-track intervention: upgrade the CRM platform and hire five additional service reps, targeting a 30% improvement in response time within six months."*

#### Key Supporting Points (middle of pyramid)
Provide 2–4 supporting arguments. These must be **MECE**:

- **Mutually Exclusive** — no overlap between points (if two say the same thing, merge them)
- **Collectively Exhaustive** — together they cover the full case (no important argument is missing)

Each key point should be a *so what* synthesis, not just a data label.

#### Evidence (base of pyramid)
Ground each key point in data, examples, or analysis. Keep this layer factual and specific. Executives who want detail will find it here; those who don't can stop at the key points.

---

### 4. Apply the right format for the output

#### Email
- Subject line = Governing Thought (or close to it)
- Opening paragraph = S + C compressed into 2–3 sentences
- Body = Resolution structured as key points (can use short headings or numbered points)
- Closing = clear call to action

#### Slide deck
- Slide 1 = SCR summary (3 bullets or a short paragraph per component)
- Slides 2–N = Resolution expanded using pyramid structure (one key point per slide, with supporting evidence)
- Each slide title = a complete sentence that states the *so what*, not just a topic label
- See `references/slide-principles.md` for slide-title and layout guidance

#### Verbal pitch / brief
- Open with the Governing Thought
- State the SCR arc in under 60 seconds
- Walk through key points; offer evidence only if challenged

#### One-page brief / exec summary
- Follow the structure: S (1 para) → C (1 para) → R (Governing Thought + 2–4 bullet key points + evidence table or bullets below)

---

### 5. Quality-check the output

Before presenting a draft, run it through these checks:

**SCR checks**
- [ ] Does the Situation contain only agreed, neutral facts?
- [ ] Does the Complication create genuine tension and a felt need to act?
- [ ] Does the Resolution follow logically and directly from the Complication?

**Pyramid checks**
- [ ] Does the Governing Thought lead (answer first, not buried)?
- [ ] Are the key points MECE? (No overlap. No gaps.)
- [ ] Does evidence sit below its corresponding key point?
- [ ] Can someone stop reading at the key points and still understand the recommendation?

**Audience checks**
- [ ] Is the language appropriate for the audience's level of familiarity?
- [ ] Is the tone action-oriented, not just descriptive?
- [ ] Is the call to action specific and time-bound?

---

## Common failure modes to avoid

| Failure | What it looks like | Fix |
|---|---|---|
| Situation as complication | "Our system is broken" in the S slot | Move tension to C; keep S neutral |
| Buried answer | Recommendation appears at the end | Move Governing Thought to top of Resolution |
| Non-MECE points | Two key points say the same thing | Merge or reframe so each is distinct |
| Weak complication | "We'd like to improve things" | Add quantified stakes: lost revenue, risk, missed deadline |
| Too much evidence up top | Data dump before recommendation | Push evidence to the base; lead with the point it supports |
| Missing call to action | Resolution is vague | Close with specific ask: decision, approval, next step, by when |

---

## Reference files

- `references/slide-principles.md` — Guidance on slide titles, layout, and deck structure using the Pyramid Principle
- `references/worked-examples.md` — Full worked examples across email, deck, and brief formats

Read these when the user needs format-specific guidance or a complete worked example to adapt.

---

## Quick-reference template

```
SITUATION
[1–3 sentences. Agreed facts. Neutral tone.]

COMPLICATION
[1–3 sentences. What's wrong / what's changed. Three complications if possible.]

RESOLUTION
Governing Thought: [One sentence. The answer, up front.]

  Key Point 1: [So-what synthesis]
    → Evidence: [Data, example, or analysis]

  Key Point 2: [So-what synthesis]
    → Evidence: [Data, example, or analysis]

  Key Point 3: [So-what synthesis]
    → Evidence: [Data, example, or analysis]

Call to Action: [Specific next step. Who. What. By when.]
```
