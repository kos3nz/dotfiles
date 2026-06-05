---
name: verify-frontend
description: Verify frontend changes in a real browser using Chrome DevTools MCP. Boot the dev server, drive the UI, watch console/network/performance, capture screenshots, and feed observations back into the implementation loop. Also reproduces user-reported bugs from a description and drives them to a fix. Use whenever the user is iterating on UI code and wants to see it working, says "check it in the browser", "open the page and see if it works", "the dropdown isn't opening", "there's a layout shift", "console is throwing", "this looks broken", reports a frontend bug to reproduce, or asks to verify a frontend change before committing. Works on any web app (React, Vue, Remix, Next.js, etc.) and handles embedded / iframe contexts (Shopify admin, Stripe, etc.) with cross-origin-safe fallbacks.
---

# Verify Frontend

A discipline for keeping a tight loop between code edits and what's actually happening in the browser. Two modes:

- **Iterate** — you just wrote or are about to write UI code. Watch it work, catch console errors and layout regressions before they pile up.
- **Reproduce** — the user describes a bug they saw in their browser. Reconstruct it on your side, diagnose, fix, verify.

The skill is the **discipline of looking** — opening the page, taking the snapshot, reading the console, before you guess. Code-only reasoning about UI bugs is how you waste an hour on the wrong cause.

## When to use which mode

| Signal | Mode |
| --- | --- |
| "I'm building X, let's see how it looks" | Iterate |
| "Does the form actually submit?" | Iterate |
| "Check for layout shift / CLS / perf regression" | Iterate (+ trace) |
| "It doesn't work on my screen" / report with reproduction steps | Reproduce |
| "Console is throwing TypeError when I click X" | Reproduce |
| "Looks broken but I don't know what's wrong" | Reproduce (with probing) |

Both modes share the same setup (Phase 0) and the same toolbelt. They diverge in **what you do with what you see**.

---

## Phase 0 — Get a live page in front of you

This phase is mechanical but critical. Do not skip steps because they feel obvious — a wrong port or stale page will waste 10× the time it takes to verify them.

### 0.1 — Is the dev server already up?

Before starting anything, check. Users often have it running and don't say so.

```bash
# Pick the most likely candidates by reading package.json first.
# Then check what's actually listening.
lsof -i -P -n | grep LISTEN | grep -E '(node|bun|deno|vite|next|remix)' || true
```

Cross-reference with `package.json` scripts (`dev`, `start`, `serve`). If you see a process bound to a port that matches a `dev` script's default (Vite 5173, Next 3000, Remix 3000, Astro 4321, Storybook 6006, Shopify CLI tunnels at *.trycloudflare.com), assume that's it and confirm by hitting it:

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:<port>/
```

200/3xx → it's live. 404 from the framework is also fine (means the server responds).

### 0.2 — If nothing is running, start it

Read `package.json` and pick the dev command. **Run it in the background** so you can keep working:

```bash
# Adapt the command per project.
npm run dev   # or pnpm dev / yarn dev / bun dev / shopify app dev
```

Use `run_in_background: true`. When the process emits its "ready" line (e.g. "Local: http://localhost:5173"), grab the URL. Polling tip: re-read the background process output until you see a URL pattern, with a hard timeout of 60s. If nothing in 60s, surface the log to the user — something is wrong (env var missing, port collision, build error).

### 0.3 — Open the page in Chrome DevTools MCP

```
mcp__chrome-devtools__list_pages         # is there already a tab? reuse it
mcp__chrome-devtools__new_page (url)     # otherwise open one
mcp__chrome-devtools__select_page        # if multiple tabs are open
```

Reuse existing tabs aggressively. Re-opening discards in-page state (auth, form values) the user may have set up.

### 0.4 — Sanity check before doing anything

```
mcp__chrome-devtools__list_console_messages
mcp__chrome-devtools__list_network_requests
mcp__chrome-devtools__take_snapshot
```

Three things in this exact order:

1. **Console** — any red errors on load? If yes, that is your first lead, regardless of what the user asked about.
2. **Network** — any 4xx/5xx? Any pending requests stuck loading?
3. **Snapshot** — does the a11y tree look like the page you expected? Or did you land on a login screen / error page?

A surprising amount of "the button doesn't work" turns out to be "the page didn't even load correctly". Always look first.

---

## Iterate mode

Loop:

1. Edit code (or ask user to).
2. Reload: `mcp__chrome-devtools__navigate_page(type: "reload", ignoreCache: true)` — or wait for HMR if the framework supports it.
3. Drive the relevant interaction (click / fill / hover via UID from snapshot).
4. Observe: console, network, snapshot, screenshot.
5. Decide: ship / refine / dig deeper.

### Driving the UI

Always `take_snapshot` first to get UIDs, then act on them. UIDs become stale after navigation or React re-render — re-snapshot if a click does nothing.

```
take_snapshot                    # find the element's uid
click(uid)                        # or fill(uid, text), hover(uid)
wait_for(text: "...")             # before asserting state changed
take_screenshot                  # for visual confirmation when it matters
```

Prefer `take_snapshot` over `take_screenshot` for assertions — snapshots are text, cheap to scan, and machine-checkable. Screenshots are for showing the user or for visual regressions you can't describe in words.

### Watching for layout shift / performance

Only run a perf trace when there's a reason. Default loop is fine without it.

Reasons to trace:
- User asks about Core Web Vitals, CLS, LCP, INP.
- You just added animations / lazy-loaded chunks / large images.
- Initial load feels slow when you reload manually.

```
performance_start_trace(reload: true, autoStop: true)
# (it stops itself when the page is idle)
performance_analyze_insight(insightName: "...")
```

Read the insight names from the trace summary it returns. Common ones: `LCPBreakdown`, `CLSCulprits`, `INPBreakdown`, `RenderBlocking`. Don't speculate about insights that aren't in the list.

### When to stop iterating

Stop and surface the result to the user when:
- The feature does what they asked for and the console is clean.
- You hit a wall and have spent 3+ loop iterations on the same symptom — kick into **Reproduce mode** explicitly.
- You changed something the user didn't ask for (e.g. a fix in an unrelated component) — flag it before continuing.

---

## Reproduce mode

The user reports a bug. They saw it. You haven't. Your first job is to **make it happen on your side**.

### Step 1 — Clarify the report (if needed)

Before touching the browser, ensure you have:
- URL or route where it happens
- Exact steps to trigger (clicks, inputs, navigation)
- Expected vs actual
- Browser context if relevant (cold load vs after some action, logged-in user, viewport size)

If any are missing, ask. One question now beats ten minutes of guessing.

### Step 2 — Reproduce mechanically

Walk the steps in the live browser via the toolbelt. Don't paraphrase the user's steps in your head — do exactly what they said. Many "bugs" are step ordering the user did instinctively but didn't write down.

Capture evidence as you go:
- `list_console_messages` after each step that should not throw.
- `list_network_requests` to spot failed/slow requests around the failure.
- `take_screenshot` of the broken state for the user to confirm "yes, that's it".

### Step 3 — Confirm "same bug, not a different one"

Before diagnosing, **show the user the captured state and ask if it matches**. Especially important when:
- The error message you saw differs slightly from what they reported.
- The bug only appears in some viewport sizes / data states / login states.

Wrong repro → wrong fix.

### Step 4 — Diagnose

Once reliably reproduced, switch into **diagnose discipline** (if the `diagnose` skill is available, use it). The browser-side loop is now your feedback loop: form a falsifiable hypothesis, add instrumentation (`console.log` in the source, breakpoints, network observation), test it, narrow.

Common instrumentation patterns:
- `evaluate_script` to read React/Vue/Svelte internals (devtools globals, store snapshots) — **but see iframe caveats below**.
- Inject a temporary `console.log` in source code, reload, observe.
- Add `data-testid` on a suspect element to make it locatable via snapshot reliably.

### Step 5 — Verify the fix

After patching, run the original repro steps again. The fix verifies only when **the exact failure mode the user described** stops happening. Not "a different error didn't crash this time". Be explicit in your report: "Reproduced before fix at step 3, console showed X. After fix, completed all steps, console clean, screenshot attached."

---

## iframe / cross-origin environments

Many real apps render inside iframes you don't own — Shopify admin embeds your app, Stripe Elements wraps card inputs, OAuth flows redirect through third-party domains. The DevTools MCP behaves differently inside cross-origin iframes.

**Quick rule:** if `evaluate_script` returns errors like "Cannot access frame", "Cross-origin", or just empty/null, you are likely in a cross-origin iframe.

Switch tactics:
- `take_snapshot` still works across frames — UIDs include nested frame elements.
- `click`, `fill`, `hover`, `press_key` work via UID even in cross-origin iframes.
- `evaluate_script` is restricted to the top frame's origin. Use UID-based tools instead of `document.querySelector` patterns.
- `list_console_messages` and `list_network_requests` aggregate across frames — still useful.

For the full table of what works where and how to detect iframe context, read `references/iframe-cross-origin.md`.

---

## DevTools MCP toolbelt — quick reference

The full cheatsheet (every tool, when to use it, common pitfalls) lives at `references/devtools-mcp-cheatsheet.md`. Read it the first time you use this skill in a session, or when you're not sure which tool to reach for.

Core tools you'll use constantly:

| Task | Tool |
| --- | --- |
| See the DOM as text | `take_snapshot` |
| See it visually | `take_screenshot` |
| Click / type / hover | `click`, `fill`, `hover` (need UID from snapshot) |
| Check errors | `list_console_messages` |
| Check requests | `list_network_requests` → `get_network_request(url)` for detail |
| Navigate / reload | `navigate_page` |
| Read JS state | `evaluate_script` (top frame only) |
| Wait for UI | `wait_for(text)` |
| Perf | `performance_start_trace` → `performance_analyze_insight` |

---

## Pitfalls

- **Re-snapshot after every interaction that mutates the DOM.** Stale UIDs silently do nothing.
- **Reload with `ignoreCache: true` when verifying a JS/CSS edit.** HMR sometimes lies.
- **Don't kill the user's existing dev server.** Check first, reuse, don't restart unnecessarily.
- **Don't take a 4K screenshot when a snapshot would do.** Screenshots eat context budget.
- **Don't assert on console emptiness if the app intentionally logs.** Filter by severity (`error`, `warning`).
- **For background dev server processes, surface the log on failure.** A silent timeout is the worst debugging position.

---

## What to report back

When done, give the user:

1. **What you verified** in one sentence ("The new TagCombobox opens on focus, accepts input, and persists selections through reload.")
2. **What you observed** — screenshots, console state, anything notable.
3. **What you didn't cover** — edge cases skipped, browsers untested, etc. — so they know the scope.

Brief is better than thorough here. The artifacts (screenshots, traces) carry the detail.
