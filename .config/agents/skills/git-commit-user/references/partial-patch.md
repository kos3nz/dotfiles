# Hunk-Level Staging with `git apply --cached`

Use this when Phase 3 decides to split into multiple commits and you need to stage specific hunks per commit.

## Workflow per commit

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
git diff --staged   # verify
git commit -m "..."
```

## Patch construction rules

1. **File header verbatim**: `diff --git a/X b/X`, `index ...`, `--- a/X`, `+++ b/X`.
2. **Hunk header**: `@@ -old_start,old_count +new_start,new_count @@`.
3. **3 lines of context** (` ` prefix) around each hunk.
4. **Copy from `git diff` output** — don't reconstruct line numbers from memory.

## Same file, hunks across different commits

If `foo.ts` has hunk A (commit 1) and hunk B (commit 2):

- Commit 1: hunk A with original `@@` numbers.
- Commit 2: adjust hunk B's `new_start`:
  `new_start_adjusted = original_new_start + (lines_added_in_A − lines_removed_in_A)`.
  `old_start` is unchanged.

If line numbers are uncertain, let git recompute:

```bash
git apply --cached --recount /tmp/commit-N.patch
```

## New (untracked) files

```bash
git add path/to/new-file   # add whole file; no patch needed
```

## Recovery

If `git diff --staged` shows the wrong content, reset the file and re-apply:

```bash
git restore --staged path/to/file
git apply --cached /tmp/commit-N.patch
```

If `git apply --cached` fails, read the error — don't retry blindly. Most common cause is a stale `new_start` after a prior commit changed file length.

## Cleanup

```bash
rm -f /tmp/commit-*.patch
```
