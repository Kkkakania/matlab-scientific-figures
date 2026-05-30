# Changelog

## Unreleased

- Add the v0.5.0 maintenance report.
- Add v2 API design notes for the registry and selected-rendering boundary.
- Add `sftTemplateRegistry` and `sftRenderExamples` for template discovery and
  selected rendering.
- Let `scripts/render_all.sh` render selected template names from the shell.
- Add v2 migration notes for direct renderer calls and selected rendering.

## v0.5.0 - 2026-05-30

- Add gallery color-accessibility documentation and release checklist guidance.
- Add ridgeline plot example, deterministic distribution data, gallery output,
  tests, and documentation updates.
- Add radar chart example for compact metric-profile comparisons, including
  deterministic normalized data, gallery output, tests, and documentation.
- Add parallel coordinates example for multivariate sample comparisons,
  including deterministic grouped data, gallery output, tests, and docs.
- Add contour scatter example for dense x-y relationships, including smoothed
  local density contours, gallery output, tests, and docs.
- Add a tutorials index and refresh the template backlog around the 22-example
  v0.5.0 gallery.
- Add a gallery consistency check for renderer names, example docs, committed
  PNGs, gallery checks, and `mfigci.yml`.
- Expand privacy and provenance scans to SVG and workflow/config files, and
  keep committed SVG metadata neutral.
- Simplify the README first screen around eight representative gallery images
  and copyable-script usage.
- Sanitize SVG metadata during export so regenerated gallery files keep the same
  provenance guarantees.

## v0.4.0 - 2026-05-30

- Add waffle chart example, deterministic composition data, gallery output,
  tests, and chart-selection guidance.
- Add butterfly comparison example for two-sided baseline comparisons.

## v0.3.0 - 2026-05-30

- Add double-triangle heatmap example and gallery output.
- Add zoomed inset line example and gallery output.
- Add tutorials for CSV/Excel data, paper export, and batch rendering.
- Improve the README first screen with a compact visual gallery.
- Update chart selection, template backlog, roadmap, examples index, and CI
  gallery expectations for the new templates.

## v0.2.0 - 2026-05-30

- Add correlation bubble heatmap example and gallery output.
- Add multi-panel layout helper and paper-style overview example.
- Add grouped bar with error bars and positive-negative area examples.
- Add `sftValidateFigure` for lightweight figure quality checks.
- Add `sftGalleryReport` and `scripts/validate_gallery.sh` for batch gallery checks.
- Add recipes for common user edits.
- Add a figure-template request issue template.
- Add a release checklist.
- Improve shell script error messages and gallery output checks.
- Add a public template backlog for future high-value chart types.
- Add roadmap, examples index, and template author guide.
- Improve README with project badges, gallery previews, and documentation map.
- Add a short guide for adapting examples to user data.

## v0.1.0 - 2026-05-30

- Add clean-room MATLAB figure toolkit core functions.
- Add ten deterministic scientific figure examples.
- Add MATLAB CLI rendering workflow.
- Add privacy, provenance, and gallery verification scripts.
- Add documentation for chart selection, CLI use, figure quality, provenance,
  and maintainer workflows.
