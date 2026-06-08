---
name: git-commit
description: Create git commits — one cohesive commit, or split across multiple commits via hunk-level staging when concerns are unrelated. Triggers on "commit", "split/decompose commit(s)", or `/git-commit`.
allowed-tools: Bash
---

# Git Commit

## 1. Determine scope

```bash
git status --porcelain
git diff --staged --stat
git diff --stat
git log --oneline -10
```

Scan the user's instruction for an issue reference (`refs|closes|fixes|resolves #N`, case-insensitive). Capture the keyword and number — they may become a trailer on commits in this run, attached only to commits whose changes actually address the referenced issue (not incidental refactors or docs touched alongside).

The scope is the set of hunks under consideration for this run. Anything outside scope is left untouched.

| Situation                                  | Scope                                                                                                                   |
| ------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| Staged changes exist (no commit reference) | **Staged hunks only.** The user already chose what to commit by staging — respect that. Ignore untracked/unstaged.       |
| Commit reference in instruction            | Resolve the reference and soft-reset to bring those changes into the working tree, then scope = resulting working tree. See `references/commit-references.md`. Confirm with `git log --oneline` before resetting anything beyond `HEAD~1`. |
| Only unstaged changes                      | **Working tree.**                                                                                                       |

## 2. Analyze the diff

```bash
git diff --staged   # if scope is staged
git diff            # otherwise
```

For each hunk: what concern it addresses (feature / fix / refactor / docs / test), whether it is tightly coupled to other hunks, and what commit type fits.

## 3. Single commit or split?

**Default to one commit.** Splitting is only worth it when _all_ of these hold:

- 2+ clearly distinct logical concerns with no dependency between them
- Each group would warrant a different commit type (`feat` vs `fix` vs `refactor`)
- Each group is independently explainable without referencing the others
- The split makes future `git log` reading genuinely easier

If in doubt, don't split. A focused single commit beats over-fragmented history.

When splitting from a **staged scope**, first `git reset` to unstage (working tree is preserved), then re-stage per-commit hunks in step 4b. Never pull untracked/unstaged hunks into the run.

## 4. Execute

### 4a. Single commit

```bash
git add -A   # or specific paths; for staged scope, staging is already done
git diff --staged
```

Subject-only (preferred when the subject is self-explanatory):

```bash
git commit -m "type(scope): description"
```

With body (only when bullets add information the subject doesn't):

```bash
git commit -m "$(cat <<'EOF'
type(scope): description

- bullet describing a distinct sub-change or the why
- bullet describing another distinct sub-change
EOF
)"
```

### 4b. Multi-commit

Use `git apply --cached` to stage exact hunks per commit. Full mechanics (patch header rules, `--recount` usage, recovery from failures) live in `references/partial-patch.md` — read it before constructing patches.

**Non-destructive ordering.** Plan all commits from a single `git diff` snapshot taken once at the start. Apply patches in source-file order (earliest hunk first) so the working tree shrinks predictably. After each `git apply --cached`, verify with `git diff --staged -- <path>` that the staged content matches intent, **and** with `git diff -- <path>` that the remaining intended hunks are still present in the working tree — never discard or overwrite state between commits.

## Commit message format

### Hard rules (override repo style)

1. **English only.** Even if history is Japanese or another language, write subject and body in English. Detect _structural_ style from history, not language.
2. **Body only when it adds information.** Omit the body when the subject already says everything (typo fixes, single-file renames, dependency bumps, one-line config tweaks). Write a body only to convey what the subject can't: multiple distinct sub-changes worth listing, the *why* behind a non-obvious choice, side effects a reader should know about, or context (issue links, related PRs). When you write a body, every line starts with `- `, one concern per bullet, short imperative phrase — no prose paragraphs. Restating the subject as a bullet is worse than no body.
3. **Issue reference (when provided)**: if the user's instruction includes an issue reference (`closes #N`, `fixes #N`, `refs #N`, etc.), add a trailer `<keyword> #<number>` (lowercase keyword) after the bullets, separated by one blank line — but only on commits whose changes actually address that issue. Omit the trailer on unrelated commits and when no reference is provided.
4. No `Co-Authored-By` lines. Subject under 72 chars.

### Structural style detection

```bash
git log --format="%s" -20
```

| Signal                               | Structure                         |
| ------------------------------------ | --------------------------------- |
| `feat:`, `fix:`, `docs(x):` prefixes | Conventional Commits              |
| Consistent `feat(scope):` usage      | Conventional Commits + scope      |
| Emoji prefixes (✨ 🐛 📝)            | Gitmoji                           |
| Empty / mixed history                | Fall back to Conventional Commits |

Match the structure, but always rewrite into English bullet-body form.

### Conventional Commits types (fallback)

`feat` new feature · `fix` bug fix · `refactor` no behavior change · `test` tests · `docs` docs · `style` formatting · `build` build/deps · `ci` CI config · `chore` misc

### Example with issue reference

Input: `closes #32`, body bullets: add login form, wire up validation.

```
feat(auth): add login form with validation

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
