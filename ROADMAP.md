# Roadmap

This roadmap keeps the project focused on a small set of high-value scientific
plotting workflows. New templates should improve communication quality, not
just add visual variety.

## v0.3.0: Paper-Ready Templates And Tutorials

Planned additions:

- Double-triangle heatmap for comparing two pairwise matrices.
- Zoomed inset line plot for trend figures with one important interval.
- CSV and Excel tutorial for using real tabular data.
- Paper export tutorial for PNG, SVG, and PDF workflows.
- Batch rendering tutorial for repeated experiment figures.
- Cleaner README gallery preview for first-time users.

Quality goals:

- Each new template has deterministic synthetic data.
- Each new template has PNG and SVG gallery output.
- Each new template is referenced in the chart selection guide.
- `runAllExamples` remains headless and script-friendly.
- Documentation favors copyable workflows over broad claims.

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
