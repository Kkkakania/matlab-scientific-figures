# Ecosystem Status

This page explains how the three MATLAB plotting repositories fit together.
It is intentionally factual: it describes current scope, feedback channels, and
maintenance signals without claiming broad adoption.

## Repository Roles

| Repository | Current role | What belongs there |
|---|---|---|
| [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures) | Main gallery and reusable MATLAB plotting APIs | Clean-room examples, `sftPlot*.m` APIs, themes, export helpers, gallery docs, release notes |
| [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) | Quality gate for figure repositories | Gallery output checks, provenance/privacy scans, risky-file checks, release preflight reports |
| [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) | Agent-facing plotting workflow | CSV/Excel/MAT inspection, scheme selection, MATLAB CLI rendering, render reports |

## Current Feedback Channels

| Workflow | Public feedback path | Good feedback includes |
|---|---|---|
| Fresh clone of the main gallery/API | [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) | OS, MATLAB version, commit, commands run, selected template, failure or confusing step |
| Agent-assisted data-to-figure rendering | [`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11) | Data shape summary, selected scheme, report summary, redacted command output |
| CI or release preflight for figure repos | [`matlab-figure-ci#1`](https://github.com/Kkkakania/matlab-figure-ci/issues/1) | Package workflow result, preflight JSON summary, clean-install notes |

Do not post private datasets, local account names, copied journal figures,
source packs, or full local paths in feedback.

## Maintenance Signals

- The main gallery keeps 30 committed clean-room PNG/SVG examples.
- The main gallery dogfoods `matlab-figure-ci` in GitHub Actions for static
  figure-repository checks.
- MATLAB rendering is still a local gate because public hosted runners normally
  do not include MATLAB.
- The skill repository provides a separate first-render path for users who want
  an agent to choose a chart from their own data.
- Release tags should slow down after the initial public hardening pass; small
  documentation and issue-intake improvements can land on `main` without
  creating a new tag.
- A factual maintainer activity snapshot is kept in
  [Maintainer activity](maintainer-activity.md) for internal and external
  review without turning activity into adoption claims.

## What This Does Not Claim

- It does not claim broad external adoption yet.
- It does not claim GitHub Actions regenerate MATLAB figures.
- It does not claim compatibility with every MATLAB release or toolbox.
- It does not bundle third-party plotting libraries, copied templates, raw
  paper figures, or private datasets.

## Next Useful Work

1. Collect fresh-clone feedback through the two public feedback issues.
2. Keep `matlab-figure-ci` pinned to an intentional released tag in the main
   gallery workflow.
3. Add new gallery templates only when they include reusable APIs, synthetic
   data, PNG/SVG outputs, documentation, and quality checks.
4. Move recurring user pain points from feedback issues into focused template
   requests or CI checks.
