# v3.0.0 Maintenance Report

Date: 2026-05-30

`v3.0.0` is a maintenance and usability release. It does not add more chart
types. The point is to make the existing gallery easier to discover, review,
and release.

## What Changed

- Added `sftListTemplates` for a table of public templates.
- Added `sftFindTemplates` for searching by name, task, output name, or tag.
- Added `render_all.sh list` and `render_all.sh search`.
- Added template, gallery, quality-gate, and docs index pages.
- Added a release-ready gate that can run with or without local MATLAB.
- Added forbidden-file scanning for raw materials, MATLAB binaries, archives,
  Office files, PDFs, and temporary source folders.
- Tightened contributor, issue, PR, template-review, and release workflows.

## Current Release Shape

- 22 clean-room gallery templates.
- PNG and SVG outputs committed for every template.
- Synthetic data only.
- Registry-backed selected rendering.
- Local MATLAB validation available through `REQUIRE_MATLAB=1`.
- GitHub Actions check gallery presence, metadata consistency, forbidden files,
  privacy, provenance, and figure quality.

## Boundaries

This release still avoids:

- raw data packs
- copied third-party plotting code
- encrypted MATLAB files
- journal figure collections
- fake usage signals
- broad claims about adoption

## Next Useful Work

- Add tag-based rendering if users ask for it.
- Add a generated docs table if the manual reference becomes hard to maintain.
- Add two or three domain examples that still use synthetic data.
- Improve `matlab-figure-ci` integration as that tool matures.
