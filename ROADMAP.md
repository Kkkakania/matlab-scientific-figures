# Roadmap

This roadmap tracks the current public shape of `matlab-scientific-figures`.
It should agree with README, CHANGELOG, and GitHub releases.

## Current State

- Current public release: `v3.3.0`.
- Maturity: early public project; the gallery is usable, but adoption claims
  should stay conservative until real external use appears.
- Gallery size: 23 clean-room templates.
- Public workflows: MATLAB API, MATLAB CLI, committed gallery, JSON manifest,
  privacy/provenance scans, and figure-quality CI.
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

## Next Candidates

Candidates that need careful design before inclusion:

- Generated Markdown table from `docs/template-manifest.json`.
- Tag-based gallery subsets for docs pages.
- Automated color accessibility checks.
- A small number of domain examples that still use synthetic data.
- PyPI or package-manager guidance if users ask for easier installation.

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
