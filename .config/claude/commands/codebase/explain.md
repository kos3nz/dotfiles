---
allowed-tools: Glob, Grep, Read, Bash(ls:*)
description: Analyze codebase and explain how it works with core code examples
model: sonnet
---

# Codebase Analyzer

Analyze and explain a codebase comprehensively with real code snippets.

## Workflow

### 1. Detect Project

**Glob** config files → **Read** to extract name, deps, scripts:
- Node/TS: `package.json`, `tsconfig.json`
- Python: `pyproject.toml`, `setup.py`, `requirements.txt`
- Rust: `Cargo.toml` | Go: `go.mod` | Java: `pom.xml`, `build.gradle`

### 2. Explore Structure

**Bash** `ls -la` root, then **Glob**:
- `src/**/*.{ts,tsx,js,jsx,py,rs,go}`
- `app/**/*`, `pages/**/*`, `routes/**/*`, `components/**/*`
- `lib/**/*`, `utils/**/*`, `tests/**/*`

**Grep** architectural patterns:
- Routes: `router`, `app.get`, `@app.route`
- DB: `prisma`, `mongoose`, `sqlalchemy`
- State: `useState`, `createStore`, `createSlice`
- Auth: `auth`, `session`, `jwt`

### 3. Analyze & Read Core Components

For each major component → **Read** → extract key snippets showing:
- Main exports/functions
- Core logic patterns
- Integration points

Prioritize: entry points, API handlers, business logic, data models, config.

### 4. Explain

Present findings directly. **All snippets must be real code from Read tool.**

Structure your explanation:

1. **Overview** - Purpose, tech stack, key deps
2. **Structure** - Directory layout with purposes
3. **Core Components** - Each with:
   - File path and line numbers
   - Real code snippet (10-30 lines)
   - What it does and why it matters
   - `★ Insight` block for notable patterns
4. **Architecture Flow** - How components connect
5. **Data Models** - Key types/schemas if applicable
