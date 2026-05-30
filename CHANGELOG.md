# Changelog

## Unreleased

- Add `sftListTags`, `sftFindTemplatesByTag`, `sftRenderTags`, and CLI
  `tags`/`tag` commands for tag-based gallery discovery and rendering.
- Add a tag reference page for common template families and exact-tag
  rendering.
- Add an API reference page for discovery, rendering, styling, export, and
  maintainer helper functions.
- Add `CITATION.cff` and a CI check so citation metadata stays aligned with the
  current public release.
- Add a first-use smoke test for list, info, and selected-template rendering.
- Add a documented template-manifest schema and a non-MATLAB schema check.
- Make selected-template CLI rendering print the rendered template names.
- Add compatibility documentation and a guard against accidental toolbox-only
  MATLAB calls.
- Add a non-MATLAB static quality bundle for contributor preflight checks.
- Add focused GitHub labels and align issue templates with template,
  first-use, provenance, CI, and compatibility triage.
- Refresh maintainer dashboard and roadmap status for the new static,
  citation, schema, help-text, and compatibility checks.
- Add a manifest-backed check for the template reference table.
- Add a manifest-backed check for tag-reference counts and examples.
- Include the gallery reference in gallery metadata consistency checks while
  preserving its task-based grouping.
- Add a manifest-backed check for `examples/README.md` output/function columns.
- Clarify security reporting scope and add static preflight to the pull request
  checklist.

## v3.5.0 - 2026-05-31

- Add a clean-room `uncertainty_fan_chart` template for widening forecast
  intervals.
- Add a clean-room `ternary_scatter` template for three-part compositions.
- Add a clean-room `forest_plot` template for estimates with intervals.
- Add a clean-room `waterfall_chart` template for cumulative contribution
  steps.
- Add a clean-room `bland_altman_plot` template for method-agreement review.
- Add a README gallery preview check so the first-screen images, registry
  count, and committed gallery outputs stay aligned.

## v3.4.0 - 2026-05-31

- Add a clean-room `calendar_heatmap` template for daily values over weeks.
- Add a clean-room `paired_slopegraph` template for before-after comparisons.

## v3.3.0 - 2026-05-31

- Add a clean-room `sankey_flow` template for weighted flow structures.
- Add a documentation link checker for local Markdown links and gallery image
  references.
- Wire documentation link checks into the release gate and GitHub Actions.
- Add release cadence guidance so future tags move more slowly after the first
  stabilization day.
- Add a version consistency check for README, ROADMAP, version plan, and
  changelog release metadata.
- Reword release status from "stable" to "current public release" and document
  the project as early-stage to avoid overstating maturity.
- Update the dogfooded `matlab-figure-ci` install tag to `v2.4.5`.
- Add issue intake links and first-use feedback labels for cleaner public
  collaboration.
- Add a maintainer dashboard for current release, CI, feedback, and maintenance
  status.
- Include the maintainer dashboard in version metadata consistency checks.
- Add a README badge for the dogfooded figure-quality workflow.
- Clarify the maintainer workflow evidence boundary for public applications and
  API credit planning.
- Add the roadmap to the documentation index and require that entry in the
  documentation link check.
- Require every top-level documentation Markdown file to be listed in the
  documentation index.
- Rename the README provenance section to reduce expected scan noise.
- Exclude the reviewed project `LICENSE` file from `mfigci` scans so reports
  focus on unexpected provenance findings.
- Link the Sankey-style backlog item to its public design issue.
- Clarify README documentation labels so older maintenance reports read as
  historical snapshots rather than the current project state.
- Add chart-selection guidance comparing box jitter with ridgelines and radar
  charts with parallel coordinates.
- Add a timeout-helper regression check and wire it into local and GitHub
  quality gates.
- Refresh the template backlog so it reflects the current 22-template gallery
  and completed workflow foundations.
- Set explicit read-only GitHub Actions permissions for repository quality
  workflows.
- Document Linux and Windows MATLAB CLI executable paths and clarify that the
  helper scripts expect a Bash-compatible shell.

## v3.2.0 - 2026-05-30

- Add `sftTemplateManifest` for machine-readable template metadata.
- Add `sftWriteTemplateManifest` for writing the manifest as JSON.
- Add `docs/template-manifest.json` for downstream tooling and docs automation.
- Add `scripts/check_template_manifest.sh` and wire it into the MATLAB-enabled
  release gate.
- Document the manifest in README, docs index, template reference, and quality
  gates.

## v3.1.0 - 2026-05-30

- Add `sftRenderMatches` for rendering every template that matches a search
  query.
- Add `render_all.sh match <keyword>` for CLI query-based rendering.
- Add `SFT_OUTPUT_DIR` support to `render_all.sh` so matched or selected
  renders can go to a scratch directory.
- Extend CLI checks to cover query-based rendering.
- Document matched rendering in README, template reference, quality gates, and
  MATLAB CLI guide.

## v3.0.0 - 2026-05-30

- Add `sftListTemplates` for a user-facing table of public templates.
- Add `sftFindTemplates` for searching templates by name, task, output name, or
  tag.
- Add `render_all.sh list` and `render_all.sh search` for CLI template
  discovery.
- Add template reference, gallery reference, quality gates, documentation index,
  and template review checklist.
- Add `check_release_ready.sh` as the combined local release gate.
- Add `check_forbidden_files.sh` and wire it into GitHub Actions.
- Improve contribution, issue, PR, release, and maintainer workflow docs.
- Add the v3.0.0 maintenance report.

## v2.0.0 - 2026-05-30

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
