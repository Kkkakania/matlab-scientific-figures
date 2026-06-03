# Roadmap

This roadmap tracks the current public shape of `matlab-scientific-figures`.
It should agree with README, CHANGELOG, and GitHub releases.

## Current State

- Current public release: `v3.6.0`.
- Maturity: early public project; the gallery is usable, but adoption claims
  should stay conservative until real external use appears.
- Gallery size on `main`: 30 clean-room templates. The current public release
  `v3.6.0` keeps that gallery stable and adds standalone domain examples plus
  CLI usability hardening.
- Public workflows: MATLAB API, MATLAB CLI, committed gallery, JSON manifest,
  citation metadata, privacy/provenance scans, static contributor preflight,
  first-use smoke test, and figure-quality CI.
- Current `main` also guards API reference coverage, MATLAB help summaries,
  manifest schema, toolbox independence, and README gallery-preview drift.
- Companion checker: `matlab-figure-ci` is dogfooded through
  `.github/workflows/figure-quality.yml`.

## Completed Release Tracks

### v0.3.0: Paper-Ready Templates And Tutorials

Delivered:

- Double-triangle heatmap.
- Zoomed inset line plot.
- CSV/Excel tutorial.
- Paper export tutorial.
- Batch rendering tutorial.
- Cleaner README gallery preview.

### v2.0.0: Registry And Selected Rendering

Delivered:

- `sftTemplateRegistry`.
- `sftRenderExamples`.
- Registry-backed shell rendering through `scripts/render_all.sh`.
- Migration notes for the public API boundary.

### v3.0.0: Maintenance And Usability

Delivered:

- `sftListTemplates`.
- `sftFindTemplates`.
- Template reference and gallery reference docs.
- Release readiness gate.
- Forbidden-file scanning.
- Stronger issue, PR, contribution, and release workflows.

### v3.1.0: Query-Based Rendering

Delivered:

- `sftRenderMatches`.
- `render_all.sh match <keyword>`.
- `SFT_OUTPUT_DIR` for scratch-directory renders.

### v3.2.0: Machine-Readable Template Metadata

Delivered:

- `sftTemplateManifest`.
- `sftWriteTemplateManifest`.
- `docs/template-manifest.json`.
- Manifest consistency checks in the MATLAB-enabled release gate.

### v3.3.0: Sankey Flow Template

Delivered:

- `sankey_flow` clean-room synthetic data and renderer.
- Committed PNG/SVG gallery outputs for the flow template.
- Chart-selection, color-accessibility, gallery, template, manifest, and
  backlog documentation updates.
- MATLAB tests and gallery checks covering the 23-template gallery.

### v3.4.0: Calendar And Paired Comparison Templates

Delivered:

- `calendar_heatmap` clean-room synthetic daily data and renderer.
- `paired_slopegraph` clean-room synthetic before-after data and renderer.
- Committed PNG/SVG gallery outputs for both templates.
- Chart-selection, color-accessibility, gallery, template, manifest, dashboard,
  backlog, and dogfooding configuration updates.
- MATLAB tests and gallery checks covering the 25-template gallery.

### v3.5.0: Thirty-Template Gallery

Delivered:

- `uncertainty_fan_chart` for widening forecast intervals.
- `ternary_scatter` for three-part compositions.
- `forest_plot` for interval estimates.
- `waterfall_chart` for cumulative contribution steps.
- `bland_altman_plot` for method-agreement review.
- README gallery preview checks covering the first-screen images and registry
  count.
- MATLAB release-gate coverage for the 30-template gallery.

### v3.6.0: Standalone Domain Examples And CLI Hardening

Delivered:

- Clean-room standalone `pv_power_confidence` domain example.
- Clean-room standalone `directional_rose` example for directional-frequency
  data, added after a local plotting-resource audit at the chart-family level.
- `render_all.sh csv-example`, `pv-power`, and `directional-rose` commands for
  end-to-end CLI smoke paths.
- `SFT_FORMATS`, CLI help examples, argument validation, timeout checks, and
  first-use documentation improvements.
- Generated tag-based gallery subsets from the manifest
  ([#18](https://github.com/Kkkakania/matlab-scientific-figures/issues/18)).
- Color-accessibility audit coverage checks
  ([#19](https://github.com/Kkkakania/matlab-scientific-figures/issues/19)).
- MATLAB compatibility documentation and release-gate coverage
  ([#20](https://github.com/Kkkakania/matlab-scientific-figures/issues/20)).

## Post-v3.6.0 Hardening On Main

No post-`v3.6.0` hardening is listed yet. Accumulate small fixes on `main`
until there is a user-visible reason for another tag.

## Next Candidates

Candidates that need real feedback or careful design before inclusion:

- First-use reports from a fresh clone
  ([#9](https://github.com/Kkkakania/matlab-scientific-figures/issues/9)).
- A small number of domain examples that still use synthetic data.
- Clearer guidance for adapting examples to lab CSV/Excel tables.
- Optional package-manager or release-asset guidance if users ask for easier
  installation.
- One focused template only when a request has a reproducible use case,
  synthetic data, docs, gallery outputs, and checks.

## Versioning Pace

The fast `v3.x` stabilization happened during the first public hardening pass.
It should not become the normal release rhythm. Future releases should follow
[Release cadence](docs/release-cadence.md): patch tags for small fixes, minor
tags for user-visible workflows, and no major tag unless the public
compatibility boundary changes.

## Non-Goals

- No raw data collections.
- No private notes or unclear source files.
- No large algorithm library inside this repository.
- No template that cannot run without local dependencies.
- No artificial usage, stars, comments, or adoption claims.

## Release Principle

A release is ready only when examples, documentation, gallery outputs, privacy
checks, provenance checks, MATLAB tests, and GitHub Actions pass together.
