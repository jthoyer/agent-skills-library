# Design principles — shared by the UI agents

**Read this before you mock, polish or score a UI.** It holds the principles that outlast any
design system: what makes a design good, not what this year's component library looks like.

**Who reads this:** `ux-designer` (steps 3 and 5: weigh options, set the polish bar) and `cody`
(step 2's visual quality score). One file, two pointers. When a principle changes, it changes
once.

**Order of authority.** The brief, then the project's styleguide, then WCAG, then this file.
A principle here never overrides a measured contrast ratio or an existing design system. It
tells you which of two compliant options is better, and why.

## Contents

1. Dieter Rams: ten principles of good design
2. Craft principles: hierarchy, contrast, alignment, space, consistency
3. Using them in a score or a trade-off

---

## 1. Dieter Rams: ten principles of good design

Rams set these out at Braun around 1980. Each line ends with the question to ask of a screen.

| # | Good design… | On a screen it means | Ask |
|---|---|---|---|
| 1 | is innovative | New only where new helps. Innovation follows technology; it is never an end in itself | Does the novel part solve something the standard pattern can't? |
| 2 | makes a product useful | The one task the surface exists for comes first, and nothing gets in its way | Can a user finish the main task without hunting? |
| 3 | is aesthetic | Beauty is part of usefulness: people trust and return to what looks cared for | Would this look finished beside the best screen in the app? |
| 4 | makes a product understandable | The layout explains itself. Labels, grouping and affordances do the work a manual would | Could a new user say what each control does before touching it? |
| 5 | is unobtrusive | The UI is a tool, not decoration. It recedes so the user's content leads | Does any element compete with the content for attention? |
| 6 | is honest | No dark patterns, no fake urgency, no button that promises more than it does | Does every control do exactly what it looks like it does? |
| 7 | is long-lasting | Avoid the fashionable. Choose what will still read well in five years | Will this look dated when the current trend passes? |
| 8 | is thorough down to the last detail | Empty, loading, error and overflow states are designed, not left to chance | Has every state been drawn, or only the happy path? |
| 9 | is environmentally friendly | Spend fewer resources: lighter pages, fewer requests, less battery and less attention | Is anything here heavier than the job needs? |
| 10 | is as little design as possible | "Less, but better." Remove until removing more would hurt | What can go without the user missing it? |

Principle 8 is the one first drafts skip most. `ux-designer` step 5 and `cody` step 1 already
require the empty, loading, error and overflow states: Rams is the reason.

## 2. Craft principles

These are the long-standing basics of visual design. They turn Rams's "aesthetic" and
"understandable" into checks you can make on a mock.

- **Hierarchy.** One thing is most important on each screen. Size, weight, colour and position
  say which. If everything is bold, nothing is.
- **Contrast.** Differences should be clear, not slight. Two sizes that nearly match read as a
  mistake. Contrast also carries meaning: WCAG ratios are the floor, not the goal.
- **Alignment and grid.** Every element sits on a shared edge or a spacing step. Stray pixels
  read as carelessness even when nobody can say why.
- **Proximity.** Related things sit close; unrelated things sit apart. Space groups better than
  borders and boxes do.
- **White space.** Empty space is a design element, not waste. It gives the eye a rest and the
  content its weight.
- **Consistency and repetition.** The same thing looks and behaves the same everywhere. Reuse
  the existing token, component and pattern before you invent one.
- **Restraint in type and colour.** Few typefaces (one or two), a short type scale, and one
  accent colour used with purpose. Each extra one must earn its place.
- **Function first.** Form follows the job. A choice made only because it looks interesting
  must justify itself against principles 2 and 10.

## 3. Using them in a score or a trade-off

- **Name the principle, don't just cite it.** "Option B is calmer (Rams 5) but hides the main
  action a click deeper (Rams 2)" is a trade-off. "B follows good design principles" is not.
- **Set the 0–10 bar with them.** A 10 is useful, understandable, unobtrusive, thorough in
  every state, and has nothing left to remove. Say which principle cost the most points.
- **Watch for the AI-slop signature.** Generic gradients, decorative shadows, mismatched icon
  styles, mixed corner radii and default-feeling layouts break principles 5, 7 and 10 at once.
- **Prefer the boring, proven pattern.** Rams 1 and 7 agree with the high-adoption design
  systems `ux-designer` grounds in: new where it helps, familiar everywhere else.
- **Don't decorate a principle into the work.** These guide choices; they are not features to
  add. A design that names all ten principles in its rationale has probably over-thought a v1.

**Source.** Rams's principles are stated as he published them (Vitsoe, "Ten principles for good
design"); the right-hand columns are this library's reading of them for screens. Section 2
draws on standard visual-design teaching. Pages the user pointed to on 2026-10-30 (Welch Design
Studio, "10 timeless design ideas"; Interaction Design Foundation, "Dieter Rams: 10 timeless
commandments") were not reachable from the session that wrote this file. Re-check against them
when network access allows.
