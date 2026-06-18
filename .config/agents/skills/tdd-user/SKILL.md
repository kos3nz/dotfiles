---
name: tdd-user
description: Test-driven development - derive a minimal, scope-bound test list, scaffold todo-only skeletons, then implement one case per red-green-refactor cycle. Use whenever building a feature or fixing a bug with tests, when the user mentions TDD or test-first, or wants tests planned before implementation. Pass `auto` to run unattended (e.g. inside a loop), skipping the human approval gates.
---

# TDD Lite

This is a _procedure_, not a set of principles — because given only TDD's philosophy,
models write tests in bulk and drop files wherever is convenient. It makes you work the
way a careful human developer does: read the whole scope first, understand the tests it
needs as descriptions, then drive them out one at a time. The discipline you want — no
redundant tests, files in the right place, little rework — is not a separate goal layered
on top; it is what falls out of doing real TDD properly.

Two rules hold for every test, in every language and framework:

- **Assert observable behavior through the public interface.** If a refactor that
  doesn't change behavior breaks a test, that test was testing implementation.
  See `references/tests.md` for behavior-vs-implementation examples.
- **Mock only at system boundaries** — network, clock, external services — never
  the internal modules you control. See `references/mocking.md` when you mock.

This skill is convention-agnostic. Detect the project's language and test framework
and follow _its_ conventions — Rust's in-file `#[cfg(test)]`, Go's `_test.go`, a
TS project's adjacent specs. Never assume a layout.

## Modes

**Interactive (default).** A human is in the loop, so there is nothing to log — the
test descriptions are the record. Pause at the two gates (the test list in step 1,
and discoveries in step 4). When you would depart from a default below, stop and
ask rather than deciding silently.

**Auto** (passed `auto`, e.g. inside an unattended loop). No human to pause for, so
apply the defaults and criteria below directly. Don't log routine decisions — the
descriptive test names already carry the _what_. Log only **deviations from a
default** (you skipped testing something, added a case that wasn't on the list,
extracted a module), and collect them in the step-5 report — never as comments
scattered through the code. Auto is safe exactly to the degree the criteria below
stand on their own; the deviation log is what keeps it auditable after the fact.

## 1. Read the scope, derive the scope-level list

Read the issue / plan / PRD. If there are user stories, each test case should trace
back to one.

List **only the scope-level observable behaviors** — what the feature does seen from
outside: an e2e/feature flow, or a module's public-API behavior. This is the
_outside-in_ layer: comprehensive at the level of the requested scope, and nothing
beyond it. Lower-level units (a helper, a hook, the backend endpoint a `fetch`
turns out to need) are **not** listed here — they only become real once you start
building, and you handle them in the loop (step 3). Listing them now means guessing
at a structure you haven't built — the exact "outrun your headlights" mistake that
makes bulk-written tests worthless.

For each behavior, name the **seam** it hangs on: the existing entry point (a test
file plus the module it already exercises) you will extend. Find it by _searching
the codebase_, not by inferring it from the issue text — a file named in an issue
is a suggestion, not a fact; if a nearer seam already covers the behavior, extend
that and discard the suggested name. Minting a new file from the prose is how
parallel, redundant test files get born. Delegate the search to a subagent when one
is available, to keep the main session's context small.

- **Interactive:** present the list as a table — one row per behavior, paired with
  its seam — and wait for approval before touching code. A table is the right shape
  here because every row carries the same few attributes and the reader is scanning
  for coverage and seam reuse; a flat prose list hides both. Use this format:

  | # | Behavior (observable, public-interface) | Seam (file + module to extend) | Story |
  |---|------------------------------------------|--------------------------------|-------|
  | 1 | ...                                      | `path/to/x.test.ts` → `X`      | US-3  |

  Drop the **Story** column when the scope has no user stories — don't invent one to
  fill it. Keep cells terse; the behavior phrasing _is_ the test name you'll scaffold
  in step 2, so write it as one.
- **Auto:** self-check against the criteria (every case traces to scope, none
  speculative, each seam found by searching) and continue.

## 2. Scaffold scope-level skeletons

For each scope-level behavior from step 1, write a todo/skipped stub — one grouping
block per area, one pending stub per behavior, each with a one-line comment
sketching the flow. Extend the seam you found; only design a new layout when no
seam exists, following the project's conventions.

Write **skeletons only — no bodies, and only the scope-level behaviors.** Bodies
written in bulk test imagined behavior, not actual behavior, and for e2e the UI
they'd assert on doesn't exist yet. Scaffolding lower-level units here would
re-introduce the very bulk-writing this skill is built to prevent.

## 3. Implement one behavior per cycle

Take ONE stub and drive it out. The default everywhere is **test-first (red →
green)**: write the test body, watch it fail, then write the minimal code to pass.
Writing the test first is what pins the interface, and it works whenever you can
write a correct assertion without guessing at names, shapes, or selectors you
haven't decided — which is almost always, _including most frontend behavior_ whose
contract the design already fixed (assert through user-facing queries: role, label,
text).

The single exception is **build-first**: when you genuinely cannot write a correct
assertion until the thing exists — an e2e flow against a UI not yet rendered, a
shape you're still exploring. Then build it and _immediately_ write the test
against what's really there, and run it. Never pre-write page objects or e2e
helpers against UI that doesn't exist. In a backend or Rust codebase this branch
barely ever fires; it's mostly a UI/e2e situation.

Then **refactor** with the test green — clean up the duplication and shortcuts you
introduced to get there. Keep tests green; never refactor while red. See
`references/refactoring.md` for candidates.

As you build, lower-level units surface. For each, decide the way a human developer
does — at the moment you actually have the information:

- **Does it deserve its own test? Default: no.** An internal helper is already
  covered through the public behavior whose test you just wrote; a dedicated test
  for it couples your tests to implementation and is how suites bloat. It earns its
  own test only when it's a **deep module** — independently meaningful, non-trivial,
  used in its own right. See `references/deep-modules.md` when unsure. This is a
  judgment about behavior, not file cost — it holds the same in Rust where the test
  would sit in the same file.
- **Where does its test go?** Extend the existing seam and follow the project's
  convention. A new file is for a deep module only.
- **Does testing it justify restructuring the code? Default: don't move code.**
  Test through what's there. Extract a unit to its own home only when all three
  hold: it's a deep module (passed the test above), the extraction is sound design
  you'd want _even without the test_, and it's within the scope you're already
  changing. The causation runs **design → test**: a hard-to-test lump is the test
  _telling you_ a responsibility is tangled, but you act because the separation is
  better design — not to contort code around a test. See
  `references/interface-design.md`. Restructuring unrelated code is out of scope.
- **New test, or extend an existing one?** If an existing behavior changed, extend
  its test to reflect the change; write a new test only for genuinely new behavior.

If one implementation looks like it also satisfies another stub, write and run that
test to confirm — don't assume, and don't batch ahead.

## 4. Mid-implementation discoveries

When you hit something that seems to need a test not on the approved list, apply the
same scope test from step 1:

- **Interactive:** pause, say what you found, and ask whether to add it.
- **Auto:** in scope (traces to a story or the requested change) → add it; out of
  scope or speculative → drop it. Either way it's a deviation — record it for the
  step-5 report.

## 5. Finish

- Convert any remaining stubs (typically e2e) into real tests now that the design is
  fixed. Reuse existing helpers (page objects, fixtures, factories); add new ones
  only as general-purpose operations a future issue could also use — never as
  issue-specific shortcuts.
- Self-check your own seams: did any case spawn a parallel test file that duplicates
  one that already existed? Consolidate it — cleaning up your own redundancy is in
  scope. Broader test-suite restructuring (files you didn't touch) is _not_ this
  skill's job — defer that to `improve-codebase-architecture`.
- Run the full suite and report which behaviors map to which tests.
- **Auto only:** include the deviation log — every place you departed from a default
  above, and why — so the whole run is auditable in one place.
