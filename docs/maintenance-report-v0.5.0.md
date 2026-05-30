# v0.5.0 Maintenance Report

Date: 2026-05-30

Release: <https://github.com/Kkkakania/matlab-scientific-figures/releases/tag/v0.5.0>

## Current State

- 22 clean-room MATLAB figure examples.
- PNG and SVG gallery outputs are committed.
- Synthetic data is generated in code with fixed seeds.
- No raw source packs, article screenshots, private archives, `.p`, `.fig`,
  `.mat`, `.xlsx`, `.docx`, or PDF data bundles are shipped.
- GitHub Actions run repository checks and `matlab-figure-ci`.

## What Changed Since v0.4.0

- Added ridgeline plot, radar chart, parallel coordinates, and contour scatter.
- Added a tutorials index for first-time users.
- Refined the README first screen to show 8 representative figures.
- Added gallery metadata consistency checks across renderer names, example docs,
  committed PNG files, `check_gallery_outputs.sh`, and `mfigci.yml`.
- Expanded privacy and provenance scans to SVG and workflow/config files.
- Moved SVG metadata cleanup into `sftExport`, so regenerated SVG files stay
  neutral.

## Verification Snapshot

- Local MATLAB tests passed.
- MATLAB `checkcode` passed for `src/*.m` and `examples/*.m`.
- `scripts/render_all.sh` regenerated the 22-example gallery.
- `scripts/validate_gallery.sh` passed for all examples.
- Privacy, provenance, gallery output, and gallery metadata checks passed.
- Local `mfigci` check passed.
- GitHub Actions passed on the `v0.5.0` tag.

## Maintenance Rhythm

Use a light but steady rhythm:

- Weekly: triage issues, answer template requests, and run repository checks.
- Every 2 weeks: merge a small documentation or usability improvement.
- Monthly: add at most 1-3 templates, only if they fill a real chart-selection
  gap.
- Before every release: run the release checklist and inspect changed gallery
  images by eye.

Avoid adding many chart types just to raise the count. The next useful step is
not a bigger gallery; it is a clearer API.

## v2.0.0 Direction

The project can jump from v0.5.0 to v2.0.0 only if it introduces a real public
API boundary:

- A template registry with names, tags, renderer functions, output names, and
  communication tasks.
- A selected-rendering API based on that registry.
- Documentation that tells users how to discover templates without reading
  `runAllExamples.m`.
- Migration notes for existing direct renderer calls.
- Backward-compatible direct renderer functions where practical.

## Open Questions

- Should the registry live in MATLAB structs, a table, or a small JSON file
  mirrored into MATLAB?
- Should selected rendering be a MATLAB function only, or should the shell
  script accept template names too?
- Should gallery metadata consistency checks become part of a MATLAB test, or
  stay as a shell script?
- How much API stability is realistic before users appear?

## Recommended Next Work

1. Design the template registry.
2. Add tests that compare the registry, gallery docs, `mfigci.yml`, and
   renderer availability.
3. Build `renderExamples(names, outputDir, formats)` on top of the registry.
4. Update `runAllExamples` to use the same registry.
5. Write migration notes and tag v2.0.0 only after the API is documented and CI
   is green.
