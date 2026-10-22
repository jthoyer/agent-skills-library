# Project blueprints

Visual plans for projects: HTML pages, images and diagrams that show how a project fits together.

**Why this exists.** A blueprint is a page you read, not a rule an agent follows. It started as a claude.ai artifact. An artifact lives in one account and one link. This folder keeps the file in git, with history, next to the agents and skills that build it.

**What goes here**

- HTML pages. Single files, with CSS and JS inline, so they open straight from disk.
- Images (`.png`, `.jpg`, `.svg`) that the pages use or that stand alone.
- Exported artifacts. Download the artifact as HTML and commit the file.

**Layout.** One folder per project.

```
project-blueprints/
  <project>/
    index.html     the blueprint
    assets/        images the page uses
    NOTES.md       optional: source link, date, what changed
```

**Naming.** Lowercase, hyphens. Name the folder for the project: `balancetri-app`, `agent-library`.

**Not here.** Agent output goes in `work-samples/`. Maps of how agents and skills fit together go in `workflows/`.
