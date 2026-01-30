---
allowed-tools: Bash(mkdir:*), Bash(git rev-parse:*), Write
argument-hint: [output-path (optional)]
description: Summarize session dialogue into a markdown file
model: sonnet
---

# Session Summary Skill

Summarize current session's dialogue into a markdown file.

## Steps

### 1. Determine Output Path

Check `$ARGUMENTS`:

- **Has argument**: Use that path as output directory
- **No argument**: Get repo root via `git rev-parse --show-toplevel`, create `docs/` directory

```bash
mkdir -p "$(git rev-parse --show-toplevel)/docs"
```

### 2. Organize Dialogue

Process session dialogue with these rules:

- Extract user questions/requests
- Extract Claude's responses
- Omit duplicates (retries/repeats → keep final version only)
- Summarize tool outputs
- Keep only significant code blocks

### 3. Generate Filename

Create filename from session content:

- Up to 3-4 word English slug (kebab-case)
- Append date (YYYYMMDD)
- Example: `dockerfile-optimization-20260127.md`

### 4. Markdown Output Format

```markdown
# {Session Title}

> Date: YYYY-MM-DD HH:MM
> Topics: {topic1}, {topic2}

## Summary

{Brief session overview (2-3 sentences)}

## Dialogue Log

### {Topic/Question}

**User**: {question/request}

**Claude**: {response}

...

## Files Changed

- `path/to/file1.ts` - {brief description}
- `path/to/file2.md` - {brief description}

## Key Code Snippets

{Preserve important code blocks from conversation}
```

### 5. Write File

Use Write tool to save markdown to determined output path.

Report generated file path on completion.
