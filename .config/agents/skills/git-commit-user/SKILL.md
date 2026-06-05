---
name: git-commit-user
description: Commit changes with the right granularity — one cohesive commit by default, or split into multiple commits via hunk-level staging when changes clearly span unrelated concerns. Triggers on "commit", "organize commits", "split/break up changes", "decompose commit <ref>", "split the last N commits", or `/git-commit`. If staged changes exist with no commit reference, commit them as-is. If a past commit reference is given, soft-reset first.
allowed-tools: Bash
---

# Git Commit

## Phase 1: Determine Scope

```bash
git status --porcelain
git diff --staged --stat
git diff --stat
git log --oneline -10
```

Scan the user's instruction for an issue reference (`refs|closes|fixes|resolves #N`, case-insensitive). Capture the keyword and number — they apply to every commit produced this run.

Pick exactly one case:

### CASE A — Staged changes exist (no commit reference)

The user already chose what to commit. Commit staged as one commit and **finish** — ignore untracked/unstaged files. Do not proceed to Phase 2.

```bash
git diff --staged
git commit -m "type(scope): description ..."
git log --oneline -3
```

### CASE B — Commit reference in instruction

The user wants to decompose past commits. Resolve the reference and soft-reset to bring the changes back into the working tree, then go to Phase 2. See `references/commit-references.md` for hash / relative / natural-language / range resolution.

Confirm the target with `git log --oneline` before resetting anything beyond `HEAD~1`.

### CASE C — Only unstaged changes

Analyze the working tree diff. Go to Phase 2.

## Phase 2: Analyze the Diff

```bash
git diff --staged   # or: git diff
```

For each hunk: what concern does it address (feature / fix / refactor / docs / test), is it tightly coupled to other hunks, and what commit type fits.

## Phase 3: Single Commit or Split?

**Default to one commit.** Splitting is only worth it when *all* of these hold:

- 2+ clearly distinct logical concerns with no dependency between them
- Each group would warrant a different commit type (`feat` vs `fix` vs `refactor`)
- Each group is independently explainable without referencing the others
- The split makes future `git log` reading genuinely easier

If in doubt, don't split. A focused single commit beats over-fragmented history.

## Phase 4a: Single Commit

```bash
git add -A   # or specific paths
git diff --staged
git commit -m "$(cat <<'EOF'
type(scope): description

- bullet describing the main change
- bullet describing supporting change
EOF
)"
```

## Phase 4b: Multi-Commit

Use `git apply --cached` to stage exact hunks per commit. Full mechanics (patch header rules, line-number adjustment when the same file appears in multiple commits, recovery from failures) live in `references/partial-patch.md` — read it before constructing patches.

Always `git diff --staged` before each commit to verify.

## Commit Message Format

### Hard rules (override repo style)

1. **English only.** Even if history is Japanese or another language, write subject and body in English. Detect *structural* style from history, not language.
2. **Body is required, bullets only.** Every body line starts with `- `. One concern per bullet, short imperative phrase. No prose paragraphs.
3. **Issue reference**: append ` (#N)` to the subject, then after the bullets a single blank line and a trailer `<keyword> #<number>` (lowercase keyword). Apply to every commit in the run.
4. No `Co-Authored-By` lines. Subject under 72 chars (including ` (#N)`).

### Structural style detection

```bash
git log --format="%s" -20
```

| Signal | Structure |
| --- | --- |
| `feat:`, `fix:`, `docs(x):` prefixes | Conventional Commits |
| Consistent `feat(scope):` usage | Conventional Commits + scope |
| Emoji prefixes (✨ 🐛 📝) | Gitmoji |
| Empty / mixed history | Fall back to Conventional Commits |

Match the structure, but always rewrite into English bullet-body form.

### Conventional Commits types (fallback)

`feat` new feature · `fix` bug fix · `refactor` no behavior change · `test` tests · `docs` docs · `style` formatting · `build` build/deps · `ci` CI config · `chore` misc

### Example with issue reference

Input: `closes #32`, body bullets: add login form, wire up validation.

```
feat(auth): add login form with validation (#32)

- add login form component
- wire up client-side validation

closes #32
```

## Cleanup

```bash
rm -f /tmp/commit-*.patch
git log --oneline -6
```

## Safety

- Never `git push`, `--no-verify`, or `git reset --hard` unless the user explicitly asks
- Never commit secrets (`.env`, keys, credentials)
- If `git apply --cached` fails, read the error — don't retry blindly
