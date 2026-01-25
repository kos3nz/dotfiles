---
allowed-tools: Bash(git log:*), Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*)
description: Generate commit message with staged changes
model: haiku
---

## Your task

Create a git commit with an auto-generated message that matches the style and tone of recent commit history.

**Process:**

1. **Analyze commit history:**

   - Run `git log -30 --pretty=format:"%s%n%b" --no-merges` to get last 30 commit messages
   - Study the tone, structure, length, and patterns (e.g., imperative mood, conventional commits, emoji usage, capitalization)
   - Identify common patterns in message format

2. **Understand staged changes:**

   - Run `git status` (never use -uall flag) to check for staged changes
   - If no staged changes:
     - Run `git diff` and analyze modified/untracked files
     - Intelligently group files by logical change/feature:
       - Read actual changes, not just file paths
       - Identify which files belong to same logical change
       - Examples: "add dark mode" (multiple components), "update deps" (package files), "refactor auth" (auth-related files)
     - Present logical changes via AskUserQuestion (not individual files)
     - Show which files belong to each logical change
     - User selects which logical change to commit
     - Stage all files for selected logical change with `git add`
     - If user cancels, exit without creating commit
   - Run `git diff --staged` to analyze the staged changes
   - Understand what files changed and what the changes accomplish

3. **Generate commit message:**

   - Create a commit message that mimics the analyzed style
   - Message should be concise, clear, and easy to understand
   - Determine if changes are large (>50 lines changed OR >3 files modified)
   - Format depends on change size:

     **Small changes (≤50 lines, ≤3 files):**

     ```
     Subject line only (matches historical style)
     ```

     **Large changes (>50 lines OR >3 files):**

     ```
     Subject line (matches historical style)

     - Bullet point 1
     - Bullet point 2
     - Bullet point 3 (if needed)
     ```

4. **Confirm with user:**

   - Show the generated commit message
   - Show which files will be committed
   - Use AskUserQuestion to get confirmation before proceeding
   - Options: "Proceed with commit", "Edit message", "Cancel"

5. **Create commit:**
   - If confirmed, run `git commit -m "$(cat <<'EOF'
[generated message here]
EOF
)"`
   - **IMPORTANT:** Do NOT add "Co-Authored-By: Claude..." line
   - Verify with `git status` after commit

**Important notes:**

- If changes already staged, use them; if not, intelligently group unstaged changes by logical feature/change and let user select which to commit
- Focus on matching the user's historical commit style, not generic best practices
- Keep subject line concise
- Only add bullet point description for large changes (>50 lines OR >3 files)
- For small changes, use single-line commit message only
- Bullet points should highlight key changes, not implementation details
- When presenting logical changes, clearly show which files belong to each change with their status (modified/untracked)
- Never use `--no-verify` or skip hooks unless explicitly requested
