---
name: pr
description: Open a GitHub pull request — synthesizes the title and body from the branch's full commit range and diff vs. base (not just the latest commit), then runs `/pr-check` and `/pr-release-risk` as pre-publish gates and asks for confirmation before publishing. Accepts `mode=fast|balanced|production`, `lang=en|ja`, `draft=true`. Trigger phrases — "open a PR", "create a pull request", "make a PR", "/pr", "raise a PR", "submit a PR", "PR with description", "open a draft PR". Skip for — pushing without a PR, editing an existing PR's body (use `gh pr edit`), repos without a GitHub remote.
---

> **User-question protocol:** Whenever this skill needs the user to pick between options, confirm an action, or answer a multiple-choice prompt, you MUST call the `AskUserQuestion` tool to render a proper interactive picker. Do NOT print numbered options as plain text and wait for the user to type a number — that produces a degraded UX. Free-form questions (open-ended typing) may be asked in prose, but any time you would write "1) … 2) … 3) …", use `AskUserQuestion` instead.

# pr

Phased workflow. Do not skip the confirmation gate — a published PR notifies reviewers and is hard to un-publish.

---

## Arguments

- `mode=fast|balanced|production` — pre-publish gate depth. Default `production`.
- `lang=en|ja` — force language for the PR **body prose**. Headings are always English (see Phase 2). Default: auto-detect from the branch's commit messages (majority wins; tie → en). Passed through to `/pr-release-risk`.
- `draft=true` — force draft PR regardless of commit subjects.

---

## Modes

**A PR is a public artifact.** Reviewers will assume the diff is shippable; the mode controls how thoroughly we verify that before publishing.

| Mode                   | Pre-publish gate (Phase 2.5)                                                                                                                               |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `fast`                 | Residue sweep only (console.log / `.only` / debugger / merge markers / TODO additions). Blocks on merge markers; warns on the rest.                        |
| `balanced`             | `fast` + typecheck + lint on the cumulative diff. Blocks on type/lint errors.                                                                              |
| `production` (default) | Full `/pr-check` against the branch vs. base. Blocks on any red gate (typecheck, lint, formatter, tests, residue, large/binary additions, lockfile drift). |

**Override:** explicit `mode=…` in the user's prompt wins.

---

## Phase 1 — Gather

Run the reflexive checks (`git status`, current branch) plus these non-obvious ones in parallel:

- `gh repo view --json defaultBranchRef -q .defaultBranchRef.name` — base branch (do NOT assume `main`)
- `git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null` — does upstream exist?
- `git log <base>..HEAD --pretty=format:'%h %s'` — every commit on the branch
- `git diff <base>...HEAD --stat` and `git diff <base>...HEAD` — cumulative diff (note the **three dots** — diff from merge-base, not two)

Stop conditions:

- Uncommitted changes → ask whether to commit, stash, or include them. Do not silently ignore. If user picks "commit", suggest `/git-commit` and stop — do NOT run commit logic inside this skill. After they commit, the user re-invokes `/pr`.
- Branch == base branch → see **On base branch** below. Do NOT silently stop.
- No commits ahead of base → stop. Nothing to PR.
- No GitHub remote (`gh repo view` fails) → stop. Tell the user.

### On base branch

If the current branch is the base branch (e.g., user is on `main` with local commits they want to PR), do not stop — offer to branch out first:

1. Check `git log origin/<base>..HEAD` for unpushed commits. If empty, stop with "nothing to PR."
2. If there are unpushed commits, synthesize a default branch name from the cumulative commits/diff (e.g., `feat/<short-subject>`, `fix/<short-subject>` — kebab-case, ≤40 chars). Ask via `AskUserQuestion`:
   - **Create branch `<suggested-name>` and continue** (recommended)
   - **Cancel**
3. On confirm: `git checkout -b <name>` from HEAD. The commits travel with the new branch; local `<base>` is unchanged.
4. Remember the original base branch — Phase 4 returns to it after the PR is created.

Note: local `<base>` will still contain the same commits as the new branch until the PR merges and the user pulls. This is expected and safe; do NOT reset `<base>` to `origin/<base>`.

---

## Phase 2 — Draft

Before drafting, ask: **what does a reviewer need in order to engage with this PR?** That answer drives the title and the Summary bullets — not the commit log.

### Title

- 1 commit on branch → use the commit subject verbatim (already curated).
- 2+ commits → synthesize from the **cumulative diff**, not the last commit. ≤70 chars. Imperative mood. No trailing period. No issue numbers unless the user added them.

Titles are always in English regardless of `lang`. GitHub search, notifications, and cross-repo navigation rely on consistent English titles.

### Body — language policy

- **Headings are always English** (`## Summary`, `## Test plan`, `## Screenshots`, …). Search compatibility across the GitHub UI and consistency with multi-author repos depend on it.
- **Prose inside each section** is written in the body language. Resolve once at the start of Phase 2:
  1. If `lang=en|ja` was passed → use that.
  2. Else inspect the branch's commit messages (`git log <base>..HEAD --pretty=format:'%s%n%b'`). If ≥60% of non-empty lines look Japanese (contain CJK chars), use `ja`. Otherwise `en`.
  3. Tie / no commits → `en`.
- Pass the resolved language through to `/pr-release-risk` so its briefing matches.

### Body — composition

There is no fixed template. Build the body from the sections below, **including only the ones that carry signal for this diff**. Order them top-to-bottom as listed.

| Section                 | Include when                                                                                                                                                                                                                                                                                                                                                                       |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `## Summary`            | Always. 1–3 bullets naming concrete files/modules/behaviors. Lead with WHY when the diff alone doesn't reveal it. No "various improvements" / "refactoring" / "cleanup".                                                                                                                                                                                                           |
| `## Screenshots`        | Diff touches UI files (`.tsx`, `.jsx`, `.vue`, `.svelte`, `.css`, `.scss`, `.html`, `.liquid`). Insert a placeholder note for the user to attach images at confirmation time; do not invent links.                                                                                                                                                                                 |
| `## Test plan`          | A reviewer needs to run something manually that CI doesn't cover (UI flow, external API, multi-step interaction). Each bullet is a `- [ ] <reproducible step>` — checkbox form is required so GitHub renders a progress bar reviewers can tick through. Skip the section entirely for type-only / pure-refactor / docs-only PRs — empty checklists train reviewers to ignore them. |
| `## Migration notes`    | Diff includes `.env.example` / `.env.sample` changes, DB migrations, breaking API changes, or new required env vars detected by `/pr-release-risk`.                                                                                                                                                                                                                                |
| `## Notes for reviewer` | Large diff (>500 lines) or non-obvious review path. Point the reviewer at the entry file or the riskiest hunk.                                                                                                                                                                                                                                                                     |

### Issue trailers (bottom of body)

If the branch resolves a tracker issue, append the closing keyword as a **plain trailer at the bottom of the body** — no heading, separated from the last section by a blank line (or a `---` rule when other trailers also exist). GitHub's auto-link works regardless of position, so the trailer style keeps the visual focus on Summary/Test plan.

Detection: scan commit messages and branch name for `#NNN`, `fixes #NNN`, `closes #NNN`, or a leading `<n>-` in the branch name.

Trailer form:

- Full close: `Closes #123` (one per line for multiple issues).
- Partial / reference only: `Refs #123`.
- Multiple: list each on its own line — do not combine.

Example end of body:

```
---

Closes #123
Refs #98
```

#### When in doubt — ask

If section inclusion is genuinely ambiguous (e.g., minor UI tweak — Screenshots needed?; refactor with subtle behavior change — Test plan?), use `AskUserQuestion` with a single multi-select question listing the candidate sections. Default selections = your best guess; the user toggles. Do **not** print numbered options as plain text.

Skip this prompt entirely when the answer is obvious from the diff (e.g., docs-only branch needs only `## Summary`). Asking on every PR creates friction; ask only when uncertain.

### Draft flag

Open as draft if **any** of these is true:

- A commit subject contains `WIP`, `wip`, `draft`, or `[WIP]`.
- The user passed `draft=true`.
- The user asked for a draft in prose.

---

## Phase 2.5 — Pre-publish quality gate (mandatory)

Run the mode-appropriate gate against the cumulative diff (`git diff <base>...HEAD`).

- `mode=production` → invoke the `/pr-check` skill and pipe its report through verbatim.
- `mode=balanced` → run residue sweep (Phase 5 of `/pr-check` inline) + typecheck + lint on changed files only. Block on typecheck/lint errors.
- `mode=fast` → run residue sweep only (inline). Block on merge markers; warn on the rest.

If any gate fails, **stop**. Ask via `AskUserQuestion`:

- **Fix and retry** → exit; user fixes and re-invokes `/pr`.
- **Open as draft anyway** → switch the PR to draft and append a "## Known failing gates" section to the body listing each red gate. Require an explicit acknowledgement string. Do not open as a non-draft PR with failing gates.

Skip the gate when the branch has zero diff vs. base or the diff is doc/comment-only.

---

## Phase 3 — Confirm (mandatory gate)

Before showing the PR confirmation, invoke `/pr-release-risk` (passing `lang=<arg>`) unless the branch has zero diff vs. base, or the diff is doc/comment-only. Include its findings in the confirmation block under "Things to look out for" when any exist. Do not let this gate block PR creation by itself; it informs the user before publish.

Show the user:

```
Base: <base-branch>
Branch: <current-branch>     [will push with -u]   ← only if no upstream
Draft: yes/no
Title: <title>

Body:
<body>

## Things to look out for      ← only if /pr-release-risk found anything
<briefing excerpts>

Open PR? (y / edit / cancel)
```

- `y` → Phase 4
- `edit` → ask what to change, redraft, show again
- `cancel` → stop

Do not skip this gate even if the user said "open a PR" — the title and body are your synthesis, not theirs.

---

## Phase 4 — Push & Create

If no upstream: `git push -u origin <branch>`. If push fails (non-fast-forward, protected branch), surface the error — do **not** force-push.

Then:

```bash
gh pr create \
  --base <base> \
  --title "<title>" \
  [--draft] \
  --body "$(cat <<'EOF'
<body>
EOF
)"
```

Always use a HEREDOC for `--body` to preserve newlines and checkbox syntax. After success, print the PR URL from stdout.

If Phase 1 auto-created a branch from the base branch, run `git checkout <base>` to return the user to where they started, then tell them: "Local `<base>` still has the PR'd commits; they'll be reconciled when the PR merges and you run `git pull`." Do NOT reset local `<base>`.

---

## NEVER

- **NEVER derive the title from only the latest commit when the branch has multiple commits**
  **Instead:** Synthesize from `git diff <base>...HEAD`.
  **Why:** Mid-branch commits like "fix typo" or "address review" become misleading PR titles that hide the real change.

- **NEVER skip the confirmation gate**
  **Instead:** Show title + body and wait for `y / edit / cancel`.
  **Why:** PRs are visible to teammates and trigger notifications/CI. The synthesis is yours, not the user's — they need to see it before it ships.

- **NEVER skip the Phase 2.5 pre-publish quality gate**
  **Instead:** Run the mode-appropriate gate against the cumulative diff. On red gates, only proceed as a draft PR with the failing gates documented in the body.
  **Why:** A non-draft PR signals "ready for review." Reviewers waste cycles on a PR that fails CI on first push, and trust in the system erodes when "ready" doesn't mean ready.

- **NEVER assume the base branch is `main`**
  **Instead:** Read it from `gh repo view --json defaultBranchRef`.
  **Why:** Repos using `master`, `develop`, or `trunk` get PRs targeted at a non-existent or wrong branch and fail or merge into the wrong place.

- **NEVER force-push to make `gh pr create` succeed**
  **Instead:** Surface the push error to the user and let them decide.
  **Why:** A non-fast-forward error usually means upstream has commits the user hasn't seen — force-pushing destroys them.

- **NEVER write generic boilerplate in Summary ("various improvements", "refactoring", "cleanup")**
  **Instead:** Name the concrete files/modules/behaviors from the diff.
  **Why:** Reviewers skim the Summary to decide whether to engage. Boilerplate trains them to skip your PRs.

- **NEVER open a PR against a protected branch you can't target**
  **Instead:** If `gh pr create` fails with a permission/protection error, surface it; ask whether to retarget or open from a fork.
  **Why:** Protected branches reject PRs from contributors without write access, and `gh`'s error wording ("GraphQL: ...") is opaque — translating it saves the user a confused debug loop.

- **NEVER use two-dot `git diff <base>..HEAD`**
  **Instead:** Use three dots: `git diff <base>...HEAD`.
  **Why:** Two-dot includes upstream changes the branch hasn't merged yet, polluting the diff. Three-dot shows only what the branch added since merge-base.
