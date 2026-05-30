# Maintainer Dashboard

This page is a compact status view for maintainers, reviewers, and first-time
contributors. It records what is real today, what is intentionally out of
scope, and where feedback should go.

## Current Public State

- Current released line: `v3.2.0`.
- Main branch gallery: 22 clean-room examples with committed PNG and SVG
  outputs.
- Companion CI tool: `matlab-figure-ci` is dogfooded at `v2.4.4`.
- MATLAB rendering in GitHub Actions: disabled by default because public
  runners normally do not include MATLAB.
- Public feedback channel: issue
  [#9](https://github.com/Kkkakania/matlab-scientific-figures/issues/9).

## Quality Signals

- Repository checks run through `.github/workflows/quality.yml`.
- Figure repository checks run through `.github/workflows/figure-quality.yml`.
- Local release checks are documented in
  [Quality gates](quality-gates.md) and [Release checklist](release-checklist.md).
- MATLAB commands use timeout guards in helper scripts so failed local runs do
  not linger in the background.
- Privacy, provenance, forbidden-file, documentation-link, gallery, and
  template-manifest checks are part of the maintenance workflow.

## Feedback Intake

Use the issue templates for focused feedback:

- `Bug report`: reproducible rendering, export, or documentation failures.
- `Figure template request`: new chart families or missing example workflows.
- `First-use feedback`: fresh-clone testing from the first-use checklist.
- `Feature request`: workflow, API, documentation, or quality-gate
  improvements.

Keep reports synthetic and reproducible. Do not attach private data, copied
journal figures, third-party plotting files, or source packs.

## Release Posture

The project should look maintained because checks, docs, examples, and release
notes agree. It should not look maintained because tags are produced quickly.

- Small documentation and issue-intake improvements can land on `main`.
- Template/API changes should wait for a release when docs, gallery, manifest,
  and checks move together.
- MATLAB-enforced local checks should be run before tags when MATLAB is
  available.

## Current Boundaries

- No copied third-party plotting libraries or source packs.
- No raw datasets, `.mat`, `.fig`, `.p`, Office files, archives, or OCR/raw
  material in the public repository.
- No claims about broad adoption, downloads, stars, or guaranteed external
  benefit-program approval.
- No mandatory MATLAB dependency for CI checks that can run without MATLAB.

## Next Maintenance Moves

1. Collect first-use feedback from a fresh clone.
2. Prioritize one or two template requests that reuse the existing theme,
   palette, export, and manifest system.
3. Keep `matlab-figure-ci` dogfooding aligned with the latest released tag.
4. Prepare the next release only when examples, docs, gallery outputs, and
   checks all move together.
