# Claude's default agent vs. the library's agents — week of 2026-09-07 to 2026-09-11

**Question asked:** compare and contrast Claude's agent against the sub agents in the
other repos, and improve the sub agents as relevant.

**Answer in one line:** there were no sub agents in the other repos. Every session
outside this library ran on the plain Claude Code agent with none of the 16 available.

---

## 1. The comparison cannot be run as asked, and that is the finding

Verified on fresh clones of each repo's default branch:

| Repo | `.claude/agents/` | `.claude/` holds | Sessions this week |
|---|---|---|---|
| `BalanceTRI-app` | **absent** | — (`CLAUDE.md` only) | 8 |
| `tri-momentum` | **absent** | `launch.json` | 5 |
| `CLACFridays` | **absent** | `launch.json` | 4 |
| `BalanceBolt` | **absent** | — | 2 |

Not one carries an agent. The `.claude/` directories that exist hold app launch
configs, nothing else.

**Why.** Two mechanisms, pulling opposite ways:

- **Skills are account-synced.** They arrive in any session through the plugin
  channel, whatever the repo.
- **Agents are not.** They are discovered from `<repo>/.claude/agents/` or from
  `~/.claude/agents/`. On Justin's Mac the second path is a symlink into this
  library, so a *local* session sees all 16 anywhere. **In a cloud container
  `~/.claude/agents` does not exist** — confirmed in this session: `~/.claude/skills`
  is present, `~/.claude/agents` is absent.

**23 of this week's 26 sessions had origin `desktop_app`** — cloud sessions like this
one. Three were `claude_code_cli` and may have been local; that cannot be settled from
here. So for at least 23 of 26 sessions, no custom agent was reachable, in any repo.

This is not a new discovery so much as a confirmed one. `scripts/sync-agents.sh`,
added 2026-09-10, states the mechanism in its own header. What was missing was
evidence that the consuming repos had never been synced. They have not been — the
script has no target that shows its output.

## 2. What the default agent did well

Being fair to it, because the week's output is not weak:

- **14 commits in `BalanceTRI-app`**, including a full backend migration from Google
  Apps Script to Supabase with 14 timestamped, descriptively-named migration files.
- **Tests now exist in `BalanceBolt`** — `tests.html`, `run-tests.mjs`, `tests-core.js`.
  That is the `10X-LOG.md` 2026-09-04 recommendation actually landing, in a repo that
  had zero test files a week ago.
- Clean PR-based flow, readable commit subjects, session attribution throughout.
- `BalanceTRI-app/CLAUDE.md` documents the Supabase project and migration-naming
  discipline properly.

Nothing here suggests the roster would have produced better *features*. The gap is
narrower and sharper than that.

## 3. What a specialist agent would have caught — one concrete case

`BalanceTRI-app` moved to Supabase on 2026-09-09. Row-level security is enabled, and
every policy is open:

```sql
create policy "Public can read races"    on public.races   for select using (true);
create policy "Public can add races"     on public.races   for insert with check (true);
create policy "Public can update races"  on public.races   for update using (true) with check (true);
create policy "Public can read entries"  on public.entries for select using (true);
create policy "Public can add entries"   on public.entries for insert with check (true);
create policy "Public can update entries" on public.entries for update using (true) with check (true);
create policy "Public can remove entries" on public.entries for delete using (true);
```

These are the only policies in the repo and were never amended. The publishable anon
key that reaches them ships in client JS by design. So anyone who opens the site can
insert, update and **delete** any race or any member's entry.

For a small club app, open read and insert may well be a deliberate trade-off. The
sharp edge is `delete using (true)` on `entries`: one visitor can remove other
members' race entries, and nothing records who did it.

Two things make this the right example rather than a cheap shot:

1. It shipped in the session titled **"BalanceTRI data protection and concurrency"** —
   the one week's session explicitly about data protection.
2. `security-auditor` exists for exactly this, and could not be reached.

## 4. Improvement made

`security-auditor.md` already named this target — but only in its *false-positives*
list, as advice not to flag the anon key and to look behind it instead. The grep-able
pattern sweep had no row that would ever find a permissive policy. That is the same
root cause its 2026-09-06 review recorded: *"the file specified judgement and never
specified material"*. One instance was still open.

Applied:

- **New CRITICAL sweep row** for a policy that always passes — `using (true)`,
  `with check (true)`, Firebase `allow read, write: if true` — with the fix and a note
  that permissive `delete`/`update` is the sharp edge.
- **The false-positive pointer made actionable**: read every `create policy` in
  `supabase/migrations/*.sql` against that row, rather than stopping at the key.

Evidence it would fire: run against `BalanceTRI-app` as it stands, the row matches
seven times on one file.

## 5. Not changed, and why

- **No agent definition was edited for the UI work**, which dominated the week.
  `cody`'s accessibility step and `ux-designer`'s option-mocking are not defective;
  they were absent. Editing them would treat a distribution problem as a quality one.
- **Nothing pushed to the four repos.** This session holds anonymous read access only.
  Syncing agents into them means writing to four repositories, which is the user's call.

## 6. Recommended, needs a decision

1. **Sync the roster into the four repos** and commit. That is the only change that
   makes any other agent improvement reach the work.
2. **`security-auditor` against `BalanceTRI-app`** once reachable — with the note above,
   the RLS finding is the first thing it should surface.
3. **`CLACFridays` has 6,181 lines of JavaScript and zero test files**, after 7 commits
   this week including filter, favourite and search logic. Same shape as the
   `BalanceBolt` case that `10X-LOG.md` raised on 2026-09-04 and that has since been
   fixed — and the same consequence: `mc-verifier` has nothing to execute there.
4. **`tri-momentum/CLAUDE.md` is 232,303 bytes** across 834 lines, and its own opening
   line instructs every session to read it before touching any code. That is far past
   what a single read returns. It is worth splitting before it silently truncates —
   the same failure mode this library just swept `CHANGELOG.md` to avoid.

## 7. Independence

Main-thread work, no subagent dispatched. Every claim above rests on a fresh clone or
on this container's filesystem, and the commands are reproducible. The one thing not
established: whether the three `claude_code_cli` sessions ran locally with the symlink
live. If they did, those three had the full roster and the rest did not.
