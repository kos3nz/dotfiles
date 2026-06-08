---
name: pr-release-risk
description: Pre-publish risk briefing — classifies the branch's diff vs. base across 7 production-risk categories (API surface, persistence, auth/payment, env vars, manual-QA paths, doc drift, rollback) and produces a concise HIGH/MEDIUM/LOW briefing. Does NOT block — informs the user before push/PR. Trigger phrases — "release risk", "what could break", "pre-publish check", "ship summary", "what's risky in this branch", "check before push", "/pr-release-risk". Skip for branches with zero diff vs. base, doc-only branches, comment-only branches.
---

> **User-question protocol:** Whenever this skill needs the user to pick between options, confirm an action, or answer a multiple-choice prompt, you MUST call the `AskUserQuestion` tool to render a proper interactive picker. Do NOT print numbered options as plain text and wait for the user to type a number — that produces a degraded UX. Free-form questions (open-ended typing) may be asked in prose, but any time you would write "1) … 2) … 3) …", use `AskUserQuestion` instead.


# pr-release-risk

A pre-publish risk briefing. Reads the branch's full diff vs. the base, classifies the changes, and produces a concise summary the user sees BEFORE the irreversible step (push, PR, release tag). Sibling to `pr-check` (which runs typecheck/tests/lint); this skill is **content** review, not gate review.

This skill informs; it does not block.

---

## Arguments

- `lang=en|ja` — output language for the briefing. Default `en`. When invoked from `pr`, the parent passes its own `lang` through.

---

## When to run

Run when **any** is true:
- The user invoked `/pr`, `/commit-and-push`, or `/release`.
- The user says: "what could break", "release risk", "pre-publish check", "anything risky", "summarize this branch".

**Do NOT run** for: branches with zero diff vs. base, doc-only branches, comment/format-only branches.

---

## Workflow

### Step 1 — Determine base branch and gather the diff

```bash
# Resolve base branch
git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'
# Fallback: main → master → develop
```

```bash
git rev-parse --abbrev-ref HEAD
git log --oneline <base>..HEAD
git diff --stat <base>...HEAD
git diff --name-status <base>...HEAD
```

Capture: branch name, commit count, files changed, lines added/removed.

**Note on dot syntax:** `git log` uses two-dot (commit range). `git diff` uses **three-dot** (merge-base diff). Three-dot is required to match what GitHub's PR view will show and to exclude unrelated base-branch progress.

### Step 2 — Run seven categorizers

Each categorizer scans the diff and labels matching findings into one of these buckets. A finding can land in multiple buckets.

#### Categorizer 1 — Public API surface change

**Before scanning, Read `assets/signals.md` for the full regex list.** Iterate through Categories 1→6 in that file, in order:

1. HTTP route handlers (Next.js / Remix / TanStack Start / Hono / Express / Nuxt / Cloudflare Workers / Bun / Deno / Astro / SvelteKit)
2. RPC procedures (tRPC, Hono RPC)
3. Shopify Functions / Extensions entries
4. Public exports (functions, consts, classes) — including rename detection
5. Schema / contract validators (Zod, Valibot, Yup, Joi, ArkType, Effect Schema)
6. GraphQL / OpenAPI / ts-rest contracts

Scan **added lines only** in `git diff <base>...HEAD`. Exclude test files (`*.test.*`, `*.spec.*`, `__tests__/`) and build output (`node_modules`, `dist`, `build`, `.next`, `.output`).

For each hit, manually classify: real API surface change vs. false positive (example code in a comment, internal helper accidentally matching the regex). LLM judgment is the final filter — regex provides candidates only.

**Mandatory output**: report a **hit count per Category** in the final briefing (proves all 6 were checked). Example:

```
Categorizer 1 — Public API surface
  Cat 1 (HTTP):      2 hits
  Cat 2 (RPC):       0 hits
  Cat 3 (Shopify):   0 hits
  Cat 4 (Exports):   1 hit
  Cat 5 (Schema):    0 hits
  Cat 6 (GraphQL):   n/a
```

#### Categorizer 2 — Persistence shape change

```bash
git diff <base>...HEAD -- \
  'src/db/**' 'prisma/**' 'migrations/**' '*.sql' \
  'drizzle/**' 'drizzle.config.*' '**/schema.ts' '**/schema/*.ts' \
  'kysely/**' 'supabase/migrations/**'
```

Look for: new migrations, schema field add/remove/rename, type changes, constraint changes. Tag any **destructive** migration (DROP COLUMN, DROP TABLE, NOT NULL on populated table) as **HIGH risk**.

For ORM schema files (`prisma/schema.prisma`, Drizzle `schema.ts`, etc.), treat field rename/removal as **HIGH** — type-level callers break compile, but inflight rows in production may carry old data.

`assets/signals.md` has the Drizzle / Prisma / TypeORM / Mongoose regex tables for fine-grained detection.

#### Categorizer 3 — Auth / payment / permission change

```bash
git diff <base>...HEAD | rg -E '(auth|session|jwt|cookie|password|stripe|payment|billing|permission|role|policy|csrf|oauth)'
```

Manually classify hits. Auth changes are **HIGH risk** by default — they're the easiest place to introduce a regression that the typechecker won't catch.

#### Categorizer 4 — New env vars or operational setup

```bash
# .env.example diff
git diff <base>...HEAD -- '.env.example' '.env.sample' 'env.example.ts'
# process.env reads in new code
git diff <base>...HEAD | rg '^\+.*process\.env\.'
# import.meta.env reads (Vite-style)
git diff <base>...HEAD | rg '^\+.*import\.meta\.env\.'
```

For each new env var: check if `.env.example` was updated. If not: **MEDIUM** — the deploy will break with a missing-env error in prod.

#### Categorizer 5 — Manual-QA-needed paths

Manually classify changes touching:
- File upload/download.
- Email/SMS sending.
- External webhook receiving.
- Multi-step user flows (signup, checkout, onboarding).
- Background jobs / cron.

These can't be fully covered by unit tests. Tag with the recommended QA step.

#### Categorizer 6 — Doc / changelog / migration-notes drift

```bash
# Did docs change?
git diff <base>...HEAD --name-only | rg -E '\.(md|mdx)$'
# Did CHANGELOG change?
git diff <base>...HEAD -- 'CHANGELOG.md'
```

If the branch has user-facing changes (categorizer 1, 3, or 5 hits) but no doc/changelog edits: **MEDIUM** — recommend updating documentation and adding a CHANGELOG entry before publishing.

#### Categorizer 7 — Rollback concerns

For each finding from categorizers 1–4, ask: "If this ships and breaks production, can we revert?"
- Code-only change → revert is clean.
- Migration change → revert may not roll back data; tag **HIGH**.
- Auth/session change → may invalidate active sessions on rollback; tag **MEDIUM**.
- Env var added → revert needs coordination with deployment to remove the var; tag **LOW**.

### Step 3 — Report

Render in the requested language (`lang=en|ja`). Structure is identical; labels and prose translate. Code paths, commit SHAs, command output, and identifiers stay verbatim.

#### English template (`lang=en`)

```
## Release risk briefing — <branch> → <base>

**Commits:** <N>   **Files:** <M>   **+<adds>/-<dels>**
**Overall risk:** <LOW | MEDIUM | HIGH>

### Categorizer 1 — Public API surface
  Cat 1 (HTTP):      <N> hits
  Cat 2 (RPC):       <N> hits
  Cat 3 (Shopify):   <N> hits
  Cat 4 (Exports):   <N> hits
  Cat 5 (Schema):    <N> hits
  Cat 6 (GraphQL):   <N> hits | n/a

### HIGH risk
- **Auth flow changed** — <commit-sha> (<file>:<line>)
  - <one-line description>
  - Risk: silent session invalidation on rollback.
  - Recommended: manual QA on login/logout/refresh; canary if available.

- **Destructive migration** — <commit-sha> (`migrations/<file>`)
  - DROP COLUMN `<table>.<col>`.
  - Risk: irreversible without DB backup.
  - Recommended: verify backup exists; confirm no production code reads the column.

### MEDIUM risk
- **New env var: `<NAME>`** — `.env.example` not updated.
  - Recommended: add to `.env.example` and any deployment templates before merge.

- **Public API rename: `<oldFn>` → `<newFn>`** — <file>:<line>
  - 4 callers updated in this branch; verify external consumers (other repos/services) are aware.

- **Webhook handler added** — `<file>:<line>`
  - Recommended: manual QA — fire a test event after deploy.

### LOW risk
- **Doc drift:** README mentions removed feature `<X>`.
- **No CHANGELOG entry** for user-visible changes — consider adding a CHANGELOG entry.

### Operational notes
- New env vars: <NAME1>, <NAME2>
- New external dependencies: <dep1>, <dep2>
- Migrations to run on deploy: <count>
- Recommended deploy order: <code → migrate → code, OR migrate → code, OR code-only>

### Rollback notes
- Code-only commits revert cleanly.
- Migration `<file>` is destructive — requires DB backup before rollback.

---

No release risks detected — branch is low-risk.    ← only if 0 findings
```

#### Japanese template (`lang=ja`)

```
## リリースリスクbriefing — <branch> → <base>

**コミット:** <N>   **ファイル:** <M>   **+<追加>/-<削除>**
**総合リスク:** <LOW | MEDIUM | HIGH>

### Categorizer 1 — Public APIサーフェス
  Cat 1 (HTTP):      <N> hits
  Cat 2 (RPC):       <N> hits
  Cat 3 (Shopify):   <N> hits
  Cat 4 (Exports):   <N> hits
  Cat 5 (Schema):    <N> hits
  Cat 6 (GraphQL):   <N> hits | n/a

### 高リスク (HIGH)
- **認証フロー変更** — <commit-sha> (<file>:<line>)
  - <一行説明>
  - リスク: ロールバック時にセッションが暗黙無効化される。
  - 推奨: ログイン/ログアウト/refresh の手動QA、可能なら canary 配信。

- **破壊的マイグレーション** — <commit-sha> (`migrations/<file>`)
  - `<table>.<col>` の DROP COLUMN。
  - リスク: DB バックアップ無しでは不可逆。
  - 推奨: バックアップ存在を確認、production コードが該当カラムを読んでいないことを確認。

### 中リスク (MEDIUM)
- **新規環境変数: `<NAME>`** — `.env.example` 未更新。
  - 推奨: `.env.example` と deployment テンプレートに追加してから merge。

- **Public API リネーム: `<oldFn>` → `<newFn>`** — <file>:<line>
  - 本branch内で 4 caller を更新済み、外部 consumer (他リポ/サービス) に周知済みか確認。

- **Webhook ハンドラ追加** — `<file>:<line>`
  - 推奨: 手動QA — deploy 後にテストイベントを発火。

### 低リスク (LOW)
- **ドキュメントずれ:** README が削除済み機能 `<X>` に言及。
- **CHANGELOG エントリ無し** ユーザー向け変更あり — CHANGELOG エントリ追加を検討。

### 運用上の注意
- 新規環境変数: <NAME1>, <NAME2>
- 新規外部依存: <dep1>, <dep2>
- Deploy 時に走る migration: <count>
- 推奨 deploy 順序: <code → migrate → code, OR migrate → code, OR code-only>

### ロールバック上の注意
- コードのみの commit は綺麗に revert 可能。
- Migration `<file>` は破壊的 — rollback 前に DB バックアップ必須。

---

リリースリスクは検出されませんでした — このbranch は低リスクです。    ← only if 0 findings
```

After producing the report, end with (matching `lang`):

```
This is informational. Proceed when ready:
  • /pr
  • /git-commit (then /pr)
```

(ja)
```
これは情報提供です。準備できたら次へ:
  • /pr
  • /git-commit (その後 /pr)
```

---

## NEVER

- **NEVER block the user from publishing**
  **Instead:** Report risks and let the user decide. The skill is informational; the publish path remains the user's call.
  **Why:** Mandatory gates that the user can't bypass break the trust contract — the user invoked /pr, not /risk-veto. They want a heads-up, not a blocker.

- **NEVER auto-fix issues identified in the briefing**
  **Instead:** Recommend the action in plain language (e.g., "add to `.env.example`", "add a CHANGELOG entry") and let the user act.
  **Why:** The user is at the publish boundary; auto-edits at this point delay the publish they explicitly asked for and produce a moving diff under their feet.

- **NEVER scan beyond the branch's diff vs. base**
  **Instead:** Use `git diff <base>...HEAD` (three-dot) exclusively. Do not include uncommitted work or unrelated history.
  **Why:** The publish action targets the branch's commits; including uncommitted work double-counts changes that aren't being shipped, and including older history confuses the picture. Three-dot also matches what GitHub's PR view will show.

- **NEVER classify a renamed-only public function as low-risk**
  **Instead:** Renames are HIGH for external consumers and MEDIUM for in-repo callers (the type checker catches in-repo). Always note "external consumers must be checked separately."
  **Why:** Renames pass typecheck and tests in the repo but break downstream consumers (other apps, external integrations, generated clients) silently.

- **NEVER assume the base branch is `main`**
  **Instead:** Resolve `origin/HEAD` first; fall back to `main` → `master` → `develop`. If still unresolved, ask once.
  **Why:** A wrong base produces a wrong diff, which produces a wrong briefing — the entire output becomes misleading.

- **NEVER duplicate `pr-check`'s gates**
  **Instead:** Stay focused on **content** risk (what changed and what could break). Typecheck, lint, format, test results belong to `pr-check`.
  **Why:** Two skills running the same expensive gates wastes the user's pre-publish budget; each skill earns its slot by doing one thing well.

- **NEVER skip Categorizer 1's per-Category hit count**
  **Instead:** Always emit the 6-row count block, even when all are zero. The block proves all categories were checked.
  **Why:** With a regex catalog of 30+ patterns split into 6 categories, it's easy to skim and miss one. The mandatory count makes the omission self-evident in the report.
