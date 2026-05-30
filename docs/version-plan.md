# Version Plan

Releases should mark real maintenance progress, not only code volume. A version
is ready when examples, documentation, gallery outputs, and quality checks move
together.

## Current State

- `v0.4.0` is the latest public release.
- The gallery has 21 examples on `main`.
- Open work is tracked in GitHub issues and milestones.

## v0.5.0

Goal: make the project useful beyond a starter gallery.

Scope:

- Add another batch of high-value templates, prioritizing distribution,
  multivariate, and dense-relationship charts.
- Add a selected-rendering workflow so users can render one template without
  running the whole gallery.
- Add paper-size presets or clear sizing guidance.
- Tighten consistency checks between the renderer list, gallery outputs, and
  documentation.

Release condition:

- At least 22 clean-room examples.
- First-use documentation is short and practical.
- The release has a clear changelog, closed issues, and passing CI.

## v2.0.0

Goal: introduce a stable public API for template discovery and selected
rendering.

This project may jump from `v0.5.0` to `v2.0.0` only if the release introduces a
real API boundary, not only more templates.

Expected changes:

- A template registry with names, functions, tags, output names, and
  communication tasks.
- A selected-rendering API built on that registry.
- Migration notes explaining how users should move from direct calls to the new
  API.
- Backward-compatible direct renderer functions where practical.

Non-goals:

- No raw data collections.
- No copied third-party plotting files.
- No inflated adoption claims.
- No version jump without matching documentation and tests.
