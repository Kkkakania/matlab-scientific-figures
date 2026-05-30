# Version Plan

Releases should mark real maintenance progress, not only code volume. A version
is ready when examples, documentation, gallery outputs, and quality checks move
together.

## Current State

- `v3.5.0` is the current release.
- The gallery has 30 examples on `main`.
- Open work is tracked in GitHub issues and milestones.
- Future tags should follow `docs/release-cadence.md`; small maintenance
  changes can land on `main` without a release.

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

## v3.0.0 Released

Goal: make the project easier to use and maintain without adding chart volume.

Delivered changes:

- User-facing discovery helpers: `sftListTemplates` and `sftFindTemplates`.
- CLI discovery commands: `render_all.sh list` and `render_all.sh search`.
- Template and gallery references that help users pick by task or by sight.
- A release-ready gate for local checks, with optional MATLAB enforcement.
- A forbidden-file scan for source packs, binaries, archives, and raw material.
- Stronger contribution, issue, PR, template-review, and release workflows.

Release conditions:

- All repository checks pass.
- MATLAB tests pass locally with `REQUIRE_MATLAB=1`.
- `CHANGELOG.md`, README release status, and GitHub release notes agree.

## v3.1.0 Released

Goal: make discovery directly actionable.

Delivered changes:

- `sftRenderMatches` renders every template returned by a search query.
- `render_all.sh match <keyword>` brings the same workflow to MATLAB CLI.
- `SFT_OUTPUT_DIR` lets shell users render into a scratch folder.
- CLI tests now cover list, search, and match.

Release conditions:

- MATLAB tests and `checkcode` pass locally.
- `REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh` passes.
- GitHub Actions pass on tag and main.

## v3.2.0 Released

Goal: make template metadata reusable outside MATLAB.

Delivered changes:

- `sftTemplateManifest` exposes stable machine-readable metadata.
- `sftWriteTemplateManifest` writes the manifest as JSON.
- `docs/template-manifest.json` gives external tools a no-MATLAB metadata file.
- `scripts/check_template_manifest.sh` keeps the committed JSON in sync with
  the registry.

Release conditions:

- Manifest tests pass.
- The MATLAB-enabled release gate checks manifest consistency.
- GitHub Actions pass on tag and main.

## v3.3.0 Released

Goal: add one carefully scoped flow template now that the registry, manifest,
gallery checks, and documentation workflow can keep template changes coherent.

Delivered changes:

- `sankey_flow` synthetic edge/node data and a clean-room MATLAB renderer.
- Committed PNG/SVG gallery outputs for the new template.
- Gallery, template, chart-selection, color-accessibility, backlog, manifest,
  README, and status documentation updates.
- MATLAB tests covering the 23-template registry, manifest, gallery report, and
  Sankey edge-table shape.

Release conditions:

- MATLAB-enabled release gate passes locally.
- Figure-quality dogfooding checks pass in GitHub Actions.
- GitHub issue #16 is closed with implementation and verification notes.

## v3.4.0 Released

Goal: add compact daily-pattern and before-after comparison templates without
changing the public API.

Delivered changes:

- `calendar_heatmap` synthetic daily data and a clean-room MATLAB renderer.
- `paired_slopegraph` synthetic before-after data and a clean-room MATLAB
  renderer.
- Committed PNG/SVG gallery outputs for the new templates.
- Gallery, template, chart-selection, color-accessibility, backlog, manifest,
  README, dashboard, and dogfooding configuration updates.
- MATLAB tests covering the 25-template registry, manifest, gallery report,
  calendar data shape, and paired before-after data shape.

Release conditions:

- MATLAB-enabled release gate passes locally.
- `mfigci` dogfooding checks pass locally and in GitHub Actions.

## v3.5.0 Released

Goal: publish the 30-template gallery as a coherent release rather than leaving
the main branch ahead of the public release page.

Delivered changes:

- `uncertainty_fan_chart` for widening forecast intervals.
- `ternary_scatter` for three-part compositions.
- `forest_plot` for estimates with intervals.
- `waterfall_chart` for cumulative contribution steps.
- `bland_altman_plot` for method-agreement review.
- README gallery preview checks in the local release gate and GitHub Actions.
- Documentation, manifest, gallery outputs, mfigci config, and MATLAB tests
  updated for the 30-template gallery.

Release conditions:

- MATLAB-enabled release gate passes locally.
- `Quality checks` and `Figure quality` pass on `main` and the release tag.
