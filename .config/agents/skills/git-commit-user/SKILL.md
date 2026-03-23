---
name: git-commit-user
description: Intelligently commit changes — as a single commit or multiple logical commits — using hunk-level staging. Use this skill when asked to "commit changes", "organize commits", "split changes into commits", "decompose the last commit", "break up changes", "separate these changes", "decompose commit abc1234", "split the last 3 commits", "the commit that added X", or when /git-commit is invoked. If there are staged changes and no explicit commit reference, commit staged as a single commit. Otherwise analyze the full diff and decide whether to commit as one or split into multiple — only split when changes clearly span distinct, unrelated concerns. When asked to decompose a specific commit or range, soft-reset to bring those changes into the working tree first.
allowed-tools: Bash
---

# Git Commit

Commit changes with the right granularity — one commit when changes are cohesive, multiple when they're clearly distinct.

## Phase 1: Determine Scope

```bash
git status --porcelain
git diff --staged --stat
git diff --stat
git log --oneline -10
```

Check these three cases in order and follow exactly one path:

---

### CASE A — Staged changes exist (no explicit commit reference)

The user has already decided what to commit. Commit staged as a single commit and **finish**.

```bash
git diff --staged       # read what's staged
git commit -m "type(scope): description"
git log --oneline -3    # show result
```

Untracked and unstaged files are completely ignored.

**This is the end of the workflow. Do not proceed to Phase 2 or Phase 3.**

### CASE B — Explicit commit reference in instruction

The user wants to decompose a specific past commit. Resolve the reference (see below), soft-reset to bring its changes into the working tree, then continue to Phase 2.

#### Resolving commit references

When the instruction contains a commit reference, resolve it before doing anything else:

**By hash** — "decompose commit `a1b2c3d`":

```bash
git show a1b2c3d --stat        # confirm it's the right commit
git reset a1b2c3d~1            # soft-reset to just before it
```

**Relative position** — "last 2 commits", "the commit before last":

```bash
git log --oneline -5
git reset HEAD~2
```

**Natural language** — "the commit that added authentication", "the refactor from yesterday":

```bash
git log --oneline -20
git log --oneline --grep="auth"
git show <found-hash> --stat   # confirm it matches intent
git reset <found-hash>~1
```

**Commit range** — "split the last 3 commits", "from HEAD~4 to HEAD":

```bash
git log --oneline HEAD~4..HEAD
git reset HEAD~4
```

> After a soft-reset, the commits are removed from history but their changes remain in the working tree. You then analyze and re-commit with appropriate granularity.

**Important**: Before soft-resetting anything other than HEAD~1, show the user the matching `git log --oneline` output and confirm it's the right commit before proceeding.

### CASE C — No staged changes, unstaged changes exist

Analyze the full working tree diff. Continue to Phase 2.

---

## Phase 2: Analyze the Diff

Get the full diff for your scope:

```bash
git diff --staged   # if staged
git diff            # if unstaged
```

Read it carefully. For each hunk, consider:

- What logical concern does it address? (new feature, bug fix, refactor, docs, test?)
- Is it related to other hunks, or independent?
- What commit type would it warrant? (`feat`, `fix`, `refactor`, etc.)

## Phase 3: Decide — Single Commit or Split?

This is the most important judgment call. Default to a **single commit**. Only split when the evidence is clear.

**Commit as one** when:

- All changes serve a single, articulable purpose
- Even if multiple files are touched, they're all part of the same unit of work
- The diff is small or medium-sized with an obvious focus
- Changes are tightly coupled (e.g., implementation + its test + its docs update)

**Split into multiple commits** when all of the following are true:

- Changes clearly span **2+ distinct logical concerns** with no dependency between them
- Each group would naturally warrant a **different commit type** (`feat` vs `fix` vs `refactor`)
- Each group is **independently meaningful** — you could explain it without mentioning the other groups
- Splitting makes the history genuinely more useful for future readers

When in doubt, don't split. A single well-described commit is better than an over-fragmented history.

## Phase 4a: Single Commit Path

Stage everything in scope and commit:

```bash
git add -A                    # or specific files if scope is unstaged
git diff --staged             # verify
git commit -m "$(cat <<'EOF'
type(scope): description

Optional body if non-trivial.
EOF
)"
```

## Phase 4b: Multi-Commit Path

When splitting is clearly the right call, use `git apply --cached` to stage exactly the right hunks per commit.

### Constructing a partial patch

For each commit, write a patch with only the target hunks:

```bash
cat > /tmp/commit-1.patch << 'PATCH'
diff --git a/src/foo.ts b/src/foo.ts
index a1b2c3d..e4f5g6h 100644
--- a/src/foo.ts
+++ b/src/foo.ts
@@ -12,7 +12,9 @@ function setup() {
   const x = 1;
   const y = 2;
+  const z = 3;
   return { x, y };
 }
PATCH

git apply --cached /tmp/commit-1.patch
git diff --staged             # verify before committing
git commit -m "type(scope): description"
```

**Patch construction rules:**

1. **File header**: exact — `diff --git a/X b/X`, `index` hash, `--- a/X`, `+++ b/X`
2. **Hunk header**: `@@ -old_start,old_count +new_start,new_count @@`
   - `old_start`: line in the ORIGINAL file (before any patches this session)
   - `new_start`: line in the patched file
3. **Context lines**: include 3 surrounding context lines (` ` prefix) per hunk
4. **Copy verbatim** from `git diff` output — don't reconstruct from memory

### When the same file's hunks go into different commits

If `foo.ts` has hunk A (commit 1) and hunk B (commit 2):

- Commit 1: use hunk A with original `@@` numbers
- Commit 2: adjust hunk B's `new_start`:
  ```
  new_start_adjusted = original_new_start + (lines_added_in_A - lines_removed_in_A)
  ```
  `old_start` stays unchanged.

If uncertain about line numbers, use `--recount`:

```bash
git apply --cached --recount /tmp/commit-N.patch
```

### New (untracked) files

```bash
git add path/to/new-file      # whole file
```

### Verify before every commit

```bash
git diff --staged
```

If staged content is wrong, reset and re-apply:

```bash
git restore --staged path/to/file
git apply --cached /tmp/commit-N.patch
```

## Commit Message Format

### Style Detection (always run first)

Before writing any commit message, read the recent history to match the repo's existing style:

```bash
git log --format="%s" -20
```

Identify the pattern in use:

| Signal                                                      | Detected style                    |
| ----------------------------------------------------------- | --------------------------------- |
| Messages start with `feat:`, `fix:`, `docs(x):` etc.        | Conventional Commits              |
| Messages use `feat(scope):` with scopes consistently        | Conventional Commits + scope      |
| Messages are free-form capitalized sentences                | Free-form prose                   |
| Messages start with a verb in past tense ("Added", "Fixed") | Past-tense imperative             |
| Messages contain emoji prefixes (✨, 🐛, 📝)                | Gitmoji                           |
| Messages are in Japanese                                    | Japanese free-form                |
| History is empty or too mixed to call                       | Fall back to Conventional Commits |

**Match the detected style exactly** — tone, casing, tense, whether scopes are used, whether bodies are common.

### Conventional Commits reference (default fallback)

If the history uses or defaults to Conventional Commits:

| Type       | Use for                             |
| ---------- | ----------------------------------- |
| `feat`     | New feature                         |
| `fix`      | Bug fix                             |
| `refactor` | Code change with no behavior change |
| `test`     | Adding/updating tests               |
| `docs`     | Documentation only                  |
| `style`    | Formatting, whitespace              |
| `build`    | Build system, dependencies          |
| `ci`       | CI config                           |
| `chore`    | Maintenance, misc                   |

### Universal rules (apply to all styles)

- Subject line under 72 characters
- Body when the change is non-trivial (explain _why_, not what)
- No `Co-Authored-By` lines

## Cleanup and Summary

```bash
rm -f /tmp/commit-*.patch
git log --oneline -6
```

## Safety

- Never `git push` unless explicitly asked
- Never `--no-verify` unless the user requests it
- Never `git reset --hard` — soft reset only
- Never commit secrets (.env, private keys, credentials)
- If `git apply --cached` fails, read the error carefully — don't retry blindly
