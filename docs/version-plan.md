# Version Plan

Releases should mark real maintenance progress, not only code volume. A version
is ready when examples, documentation, gallery outputs, and quality checks move
together.

## Current State

- `v2.0.0` is the latest public release.
- The gallery has 22 examples on `main`.
- Open work is tracked in GitHub issues and milestones.

## v0.5.0 Released

Goal met: make the project useful beyond a starter gallery.

Scope:

- Add another batch of high-value templates, prioritizing distribution,
  multivariate, and dense-relationship charts.
- Add a selected-rendering workflow so users can render one template without
  running the whole gallery.
- Add paper-size presets or clear sizing guidance.
- Tighten consistency checks between the renderer list, gallery outputs, and
  documentation.

Release condition:

- 22 clean-room examples.
- First-use documentation is shorter and more practical.
- Changelog, local verification, and GitHub Actions are in place.

## v2.0.0 Released

Goal met: introduce a public API for template discovery and selected rendering.

The project jumped from `v0.5.0` to `v2.0.0` because the release introduced a
registry-backed API boundary, not just more templates.

Delivered changes:

- A template registry with names, functions, tags, output names, and
  communication tasks.
- A selected-rendering API built on that registry.
- Shell selected rendering through `scripts/render_all.sh`.
- Migration notes explaining how users should move from direct calls to the new
  API.
- Backward-compatible direct renderer functions where practical.

Non-goals:

- No raw data collections.
- No copied third-party plotting files.
- No inflated adoption claims.
- No version jump without matching documentation and tests.
