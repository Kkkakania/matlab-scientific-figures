# Roadmap

This roadmap keeps the project focused on a small set of high-value scientific
plotting workflows. New templates should improve communication quality, not
just add visual variety.

## v0.2.0: Stronger Template Coverage

Planned additions:

- Multi-panel layout helper for compact paper figures. Done in `Unreleased`.
- Grouped bar chart with error bars.
- Positive-negative area plot for signed time-series changes.
- Cleaner examples for using the gallery with user data. Done in `Unreleased`.

Quality goals:

- Each new template has deterministic synthetic data.
- Each new template has PNG and SVG gallery output.
- Each new template is referenced in the chart selection guide.
- `runAllExamples` remains headless and script-friendly.

## v0.3.0: Review And Maintenance Workflow

Planned additions:

- Batch figure validation report across the gallery. Done in `Unreleased`.
- Release checklist for maintainers. Done in `Unreleased`.
- More complete examples documentation.
- Optional command-line wrapper for rendering selected examples only.

## Later Candidates

Candidates that need careful design before inclusion:

- Ridge plot for distribution comparison.
- Radar chart for small metric sets.
- Parallel coordinates for multivariate samples.
- Sankey-style flow diagram.
- Color accessibility checks.

## Non-Goals

- No raw data collections.
- No private notes or unclear source files.
- No large algorithm library inside this repository.
- No template that cannot run without local dependencies.

## Release Principle

A release is ready only when examples, documentation, gallery outputs, privacy
checks, provenance checks, and MATLAB tests all pass together.
