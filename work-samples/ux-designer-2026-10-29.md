# ux-designer work sample — 2026-10-29

Run: `/rewrite` → `cpo`, rung 3 (design direction). Dispatched in the background from the main thread.
Product: BBallSkills (jthoyer/BBallSkills), a junior basketball skills-video site. Plan in Notion BS-001, strategy BS-000.

## Brief (verbatim)

Design three distinct visual styles for BBallSkills, a phone-first static website of basketball skill videos for a community junior basketball team (players aged 10–15, their parents, and volunteer coaches). Mock them; do not build the real site.

## Product facts
- Video first. Each drill page holds: title; one embedded YouTube video (already online, curated — no own footage ever); "Why it matters" (one or two lines); "What it teaches" (one line); three coaching cues (e.g. "Eyes up · Fingertips · Low and hard"); "Do it" (one line, e.g. "3 × 30 seconds each hand"); level badge Beginner / Intermediate / Advanced; skill group; positions; "Needs" (e.g. ball, wall); source channel credit.
- Four tabs (bottom tab bar on phone): This week (coach's 2–4 picks, home), Skills (six groups: Ball handling, Shooting, Passing, Footwork, Defence, Rebounding), Positions (Point guard, Shooting guard, Small forward, Power forward, Centre, grouped Guards/Wings/Bigs, plus a Zone defence page covering 2-3 and 3-2 zone roles), About. A "Suggest a drill" button (links out to a form) appears on Skills and About.
- Users are mostly on phones, often at a stadium with poor signal. Readers are kids 10–15: big tap targets, little reading, should feel sporty not babyish.
- Accessibility: WCAG 2.1 AA. Every text/background pairing must clear 4.5:1 (3:1 for large text and control boundaries). State the measured ratio for each main pairing, computed, not guessed. Never use colour alone for the level badge (add text).
- No children's names or photos anywhere. Use video thumbnail placeholders (a grey 16:9 box with a play icon), not stock photos of kids.

## Reference
The sister app CLACFridays is at /tmp/claude-0/-home-user-agent-skills-library/262abf1e-6bf1-517e-97d9-84e7a5e744b3/scratchpad/clac/repo (read README.md, STYLEGUIDE.md, css/tokens.css, css/components.css). It's vanilla HTML/CSS/ES modules with tokens in tokens.css, a Stripe-derived palette, bottom tab bar, and a measured-contrast style guide. One of your three options may be a close reskin of it; the other two must be genuinely different directions (e.g. bold court/arena energy, clean editorial, playful-but-not-childish). Do not edit anything in that folder.

## Deliverable
Write ONE self-contained HTML file to /tmp/claude-0/-home-user/262abf1e-6bf1-517e-97d9-84e7a5e744b3/scratchpad/design/bballskills-styles.html
- Shows the three options side by side on desktop (stacked on phone), each inside a ~390px-wide phone frame.
- For each option, render two screens: (1) Skills tab home showing the six groups, and (2) one drill page (use "Two-ball pound dribble", Beginner, Ball handling, Guards) with every field listed above.
- Under each option: its name, a one-sentence idea, its token table (colours with hex and measured contrast, type scale, radius), and who it suits best.
- Inline CSS only. System font stacks or Google Fonts only. No external JS. Must work with no network except optional Google Fonts. Page itself must have an explicit body background and work in light mode; dark mode support optional.
- Keep the file under ~60 KB.

## Return (under 300 words)
The file path, a one-line summary of each option, your recommended option and why, any contrast pairing you had to adjust, and any open question.

## Report (verbatim)

File: /tmp/claude-0/-home-user/262abf1e-6bf1-517e-97d9-84e7a5e744b3/scratchpad/design/bballskills-styles.html (about 26 KB, inline CSS, no JS, light page background set, optional Google Fonts). I could not render it or run anything because no shell was available, so layout is untested in a browser.

Options (each has a Skills screen and a Two-ball pound dribble drill page, plus token table, measured ratios, type scale, radius and "suits best"):
- A. Sideline: close reskin of CLACFridays. Navy bar, white cards with navy name strips, 2-column group grid, orange accent. System fonts.
- B. Arena: dark, scoreboard style. Huge condensed capitals, full-width numbered rows with an orange stripe, large numbered cues, big orange "Do it" block.
- C. Playbook: editorial. Cream paper, Georgia headlines, numbered ruled list, green accent, yellow level tag.

Recommendation (my pick, not confirmed by you): B, because it is the only one that reads "sporty" on first glance for ages 10-15, with 72px rows and one-word cues. Choose A if sun glare or build effort matters most, or C if parents and coaches drive adoption.

Contrast adjustments:
- A: CLAC's blurple became #C2410C (5.18 on white, 4.90 on canvas). Bright orange #F97316 is only 2.80 on white, so it appears only as a decorative rule.
- B: white on #FF6A13 is about 2.87, so every orange fill carries #0C0E14 text (6.73).
- C: yellow #F2B01E carries only dark ink (9.10).
- The level badge pairs text with a glyph in A and B and with text on a tinted tag in C, never colour alone.

Caveat: all ratios were calculated by hand from the WCAG formula (A's are derived from CLAC's measured values). `cody` should re-verify them with a tool.

Open questions:
- Is dark mode acceptable in bright sun at the stadium? That decides B versus A.
- Is the optional Barlow Condensed download acceptable on poor signal? B falls back to Arial Narrow if not.
- Group names, drill counts and the "Example Coaching Channel" credit are placeholders.

No BBallSkills styleguide exists yet. I did not find any non-design defects.

## Verified by the main thread (disk and browser)

- File written: 30,257 bytes, inline CSS, no JS (brief cap was ~60 KB).
- Rendered with Playwright at 1400px and 390px with Google Fonts blocked: all three options, both screens each, token tables and recommendation present. Mobile scrollWidth 390 (no horizontal scroll).
- Contrast recomputed with a script (WCAG 2.1 formula) for 16 pairs: every figure matched the agent's hand-calculated values to 2 dp. All text pairs at or above 4.9:1; control borders 3.56–3.91:1.
- Gap: the agent had no shell, so it could not render or compute contrast with a tool. It said so and asked for re-verification. The main thread did both.
- Outcome: shown to the user unchanged. No rework needed.
