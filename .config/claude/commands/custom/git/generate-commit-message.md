---
allowed-tools: Bash(git log:*), Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*), Bash(cat:*), Read
description: Generate commit message with staged changes
model: haiku
---

## Your task

Create a git commit with an auto-generated message that matches the style and tone of recent commit history.

**Process:**

1. **Analyze commit history:**

   - Run `git log -n 30 --pretty=format:\"%s\" --no-merges` to get last 30 commit messages
   - Study the style and identify patterns:
     - Format pattern (prefix style, casing, punctuation)
     - Level of detail and tone
     - Project-specific conventions (emoji usage, scope usage, etc.)
     - Breaking change indicators (! or BREAKING CHANGE:)

2. **Understand staged changes:**

   - Run `git status` (never use -uall flag) to check for staged changes

   <if-staged-changes-exist>
     - Run `git diff --staged` to analyze the staged changes
     - Run `git diff --staged --stat` to count lines/files changed
     - Understand what files changed and what the changes accomplish
     - Proceed directly to step 3 (skip file selection)
   </if-staged-changes-exist>
   <if-no-staged-changes>
     - Run `git diff` for modified tracked files
     - Use Read tool or `cat` for untracked files to see contents
     - Intelligently group files by logical change/feature:
       - Read actual changes, not just file paths
       - Identify which files belong to same logical change
       - Examples: "add dark mode" (multiple components), "update deps" (package files), "refactor auth" (auth-related files)
     - Present logical changes via AskUserQuestion (not individual files)
     - Show which files belong to each logical change
     - User selects which logical change to commit
     - Stage all files for selected logical change with `git add`
     - If user cancels, exit without creating commit
   </if-no-staged-changes>

3. **Generate commit message:**

   **Guiding Principles (in priority order):**

   a. **STYLE CONSISTENCY (HIGHEST PRIORITY)**
      - Match the analyzed historical style exactly
      - Mimic format pattern (prefix style, casing, punctuation)
      - Match level of detail and tone
      - Follow project-specific conventions

   b. **FALLBACK FORMAT (if no clear pattern exists)**
      - Use Conventional Commits: `<type>(<scope>): <description>`
      - Common types: feat, fix, chore, docs, style, refactor, test, perf, ci, build
      - Breaking changes: add ! after scope → feat(api)!: description

   c. **GENERAL BEST PRACTICES**
      - Use imperative mood ("add" not "added" or "adds")
      - Keep subject ≤50 chars when possible
      - No period at end of subject
      - Capitalize only proper nouns/acronyms
      - Each message must accurately reflect actual changes

   **Format Structure:**

   - Determine if changes are large (>50 lines changed OR >3 files modified)
   - Determine if changes are breaking (incompatible API changes, behavior changes)

   **Small changes (≤50 lines, ≤3 files):**

   ```
   Subject line only (matches historical style)
   ```

   **Large changes (>50 lines OR >3 files):**

   ```
   Subject line (matches historical style)

   - Bullet point 1 (what and why, not how)
   - Bullet point 2
   - Bullet point 3 (if needed)
   ```

   **Breaking changes:**

   ```
   Subject line with ! indicator (e.g., feat(api)!: change response format)

   - Key changes explained
   - Migration notes if significant

   BREAKING CHANGE: Explanation of what breaks and why
   ```

4. **Confirm with user:**

   - Show the generated commit message
   - Show which files will be committed
   - Use AskUserQuestion to get confirmation before proceeding
   - Options: "Proceed with commit", "Edit message", "Cancel"
   - If "Edit message": ask user for corrected message, then confirm again
   - If "Cancel": exit without committing

5. **Create commit:**
   - If confirmed, run `git commit -m "$(cat <<'EOF'
[generated message here]
EOF
)"`
   - **IMPORTANT:** Do NOT add "Co-Authored-By: Claude..." line
   - Verify with `git status` after commit

**Important notes:**

- **PRIORITY 1**: Match user's historical commit style above all else
- If changes staged, use them; if not, group by logical feature/change and let user select
- Keep subject line concise (≤50 chars when possible)
- Add bullet point description ONLY for large changes (>50 lines OR >3 files)
- For small changes, use single-line commit message only
- Bullet points should explain what/why, not how
- When presenting logical changes, show which files belong to each with status (modified/untracked)
- For breaking changes:
  - Add "!" after type/scope in subject line
  - Add `BREAKING CHANGE:` section in body explaining what breaks
  - Include migration notes if significant
- Never use `--no-verify` or skip hooks unless explicitly requested
