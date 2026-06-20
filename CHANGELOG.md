# Changelog

## Unreleased

- Added Dependabot coverage for GitHub Actions and guarded it in the workflow
  maintenance check so action dependency updates become ordinary reviewed PRs.
- Relaxed workflow-version guards to reject outdated action majors without
  blocking reviewed Dependabot upgrades to newer supported majors.
- Added a release-readiness issue template so future releases can track the
  user-visible reason, local checks, workflow URLs, gallery/docs/manifest
  review, risk boundaries, and release-note draft before tagging.
- Added an application evidence packet and static check so public application
  materials cite current release, workflow, PR/issue, companion-tool, and
  boundary evidence without overstating adoption.
- Strengthened the pull request template with review evidence, local checks,
  risk/provenance, and release-note prompts so PR review has a clearer public
  audit trail.
- Added an issue-triage checklist workflow so new issues get a bounded
  maintainer checklist for track, evidence level, next state, and synthetic
  reproducer needs while the live GitHub Project board remains pending.
- Updated the Codex for OSS evidence note so the current application story can
  use the agent-facing `matlab-plotting-skill` as the primary repo while this
  gallery remains the clean-room MATLAB evidence surface.

## v3.8.0 - 2026-06-10

- Added the clean-room `harmonic_spectrum` domain example and CLI coverage.
- Added first-use feedback draft tooling and stronger first-use documentation.
- Added local resource intake policy, checks, and backlog links so local
  plotting resources stay requirements-only unless they pass provenance review.
- Expose synthetic-data seed metadata through `sftExampleDataSeed`,
  `sftExampleData(...).Metadata`, and `docs/template-manifest.json`.
- Add template-manifest schema checks for synthetic data kind, seed, and RNG
  fields.
- Add JSON envelope compatibility documentation for the MATLAB figure
  ecosystem without changing existing payload shapes.

## v3.7.1 - 2026-06-04

- Added portable font fallback support to `sftTheme`, including a
  `TextScript="cjk"` option for Chinese, Japanese, and Korean labels.
- Documented mixed-script font handling in the English API reference, MATLAB
  CLI troubleshooting guide, and Chinese README.
- Added regression tests for requested-font fallback and deterministic CJK font
  selection.

## v3.7.0 - 2026-06-03

- Added `README.zh-CN.md` with a Chinese first-use path, project boundary
  summary, and language switch from the English README.
- Added a first-pass CSV/Excel data-to-figure workflow:
  `sftInspectDataFile`, `sftRecommendFigure`, `sftRenderDataFile`, and
  `render_all.sh data-file <csv|xls|xlsx>`.
- Added Markdown and JSON reports for data-to-figure renders.
- Added five clean-room standalone extended examples: marginal scatter,
  raincloud distribution, 3D ribbon comparison, vector field, and polar bubble.
- Added CLI commands for the five extended examples and covered them in the
  MATLAB CLI command check.
- Added a bilingual README consistency check to the static quality gate.

## v3.6.0 - 2026-06-03

- Added a clean-room directional-frequency rose standalone example and
  `scripts/render_all.sh directional-rose`, informed by the expanded local
  plotting-resource audit without copying source files or image assets.
- Added `scripts/render_all.sh pv-power` for the standalone synthetic PV power
  domain example.
- Added a standalone synthetic PV power confidence-band example as the first
  domain example without expanding the core gallery registry.
- Warn when categorical palettes need interpolation beyond their curated anchor
  colors, while leaving sequential and diverging palettes warning-free.
- Broadened SVG metadata sanitization so regenerated gallery SVGs remove
  common vendor-generated description variants while preserving ordinary figure
  descriptions.
- Added a dogfooded `matlab-figure-ci` version-alignment check for README,
  maintainer dashboard, quality-gate docs, and the Figure quality workflow.
- Added a static check for GitHub issue templates and tightened template
  request provenance checkboxes around synthetic examples and copied material.
- Use `mktemp` and trap cleanup in privacy/provenance scan scripts, guarded by
  a static check, instead of predictable `/tmp` match files.
- Make `scripts/render_all.sh` reject an empty `SFT_OUTPUT_DIR` before MATLAB
  starts, avoiding confusing renders with an empty output path.
- Add a shareable First 5 Minutes guide and link it from README, the docs
  index, and the tutorials overview.
- Add a guarded README first-steps path so fresh clones can inspect templates,
  render one scratch figure, and try the bundled CSV example before reading the
  longer guides.
- Add common examples to `render_all.sh help` so first-time shell users can
  discover list, search, selected-render, scratch-output, and format workflows
  without opening the full CLI guide.
- Add `SFT_FORMATS` support to `scripts/render_all.sh` so shell users can
  choose PNG, SVG, and PDF export formats without editing MATLAB code.
- Add non-MATLAB argument checks for `scripts/render_all.sh` export formats and
  output-path quoting.
- Extend the `render_all.sh` argument checks with a fake MATLAB executable so
  valid `SFT_FORMATS` values are verified in the generated batch command.
- Add `render_all.sh help` so new users can inspect CLI commands and
  environment variables without starting MATLAB.
- Add a bounded maintainer activity snapshot covering own-repo maintenance and
  external MATLAB pull requests without claiming broad adoption.
- Add the PRMLT documentation cleanup pull request to the bounded maintainer
  activity snapshot.
- Add a roadmap status-language check so released milestones do not drift back
  into stale "planned additions" wording.
- Clarify that the main repository is now a reusable MATLAB plotting library,
  not only copyable gallery scripts, and link first-use feedback channels for
  both gallery/API and agent-assisted rendering workflows.
- Update the user-data guide to present the 30 reusable `sftPlot*.m` APIs as
  the default path, with gallery examples serving as reference wrappers.
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
- Create and document the `v3.6.0 usability hardening` milestone with concrete
  follow-up issues.
- Add generated tag-gallery documentation backed by the template manifest.
- Expand MATLAB compatibility notes and guard them with a static check.
- Add a low-noise color-accessibility audit coverage check.
- Replace a version-gated `clim` call with `caxis` so the documented R2020b
  floor stays accurate.
- Tune the default categorical palette for clearer eight-category separation
  and document palette-choice guidance.
- Add a runnable bundled CSV example and `render_all.sh csv-example` command
  for the end-to-end data-to-figure path.
- Clarify what the README CI badges verify and what still requires a local
  MATLAB-enabled release gate.

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
