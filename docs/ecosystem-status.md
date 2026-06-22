# Ecosystem Status

This page explains how the MATLAB plotting repositories and sibling Skills fit
together. It is intentionally factual: it describes current scope, feedback
channels, and maintenance signals without claiming broad adoption.

## Repository Roles

| Repository | Current role | What belongs there |
|---|---|---|
| [`matlab-scientific-figures`](https://github.com/Kkkakania/matlab-scientific-figures) | Main gallery and reusable MATLAB plotting APIs | Clean-room examples, `sftPlot*.m` APIs, themes, export helpers, gallery docs, release notes |
| [`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci) | Quality gate for figure repositories | Gallery output checks, provenance/privacy scans, risky-file checks, release preflight reports |
| [`matlab-plotting-skill`](https://github.com/Kkkakania/matlab-plotting-skill) | Agent-facing plotting workflow | CSV/Excel/MAT inspection, scheme selection, MATLAB CLI rendering, render reports |
| [`scientific-diagram-skill`](https://github.com/Kkkakania/scientific-diagram-skill) | Agent-facing research diagram workflow | Mermaid drafts, editable `.drawio` source, SVG previews, diagram provenance notes |
| [`python-plotting-skill`](https://github.com/Kkkakania/python-plotting-skill) | Early Python sibling Skill | Matplotlib examples, chart-selection notes, synthetic gallery outputs, small first-use feedback surface |

## Handoff Contract

The ecosystem repositories should hand off reviewed artifacts and commands, not
private source folders or vague status claims. In practice, handoff means artifacts and commands
that another maintainer can inspect from a clean clone.

| Producer | Producer artifact | Next consumer | Handoff command or check |
|---|---|---|---|
| `matlab-scientific-figures` | `gallery/*.png and gallery/*.svg`, `docs/template-manifest.json`, `mfigci.yml` | `matlab-figure-ci` | `mfigci check --config mfigci.yml --report mfigci-report.md` |
| `matlab-figure-ci` | `mfigci-report.md and .mfigci-results.json` | Maintainer review, release notes, issue triage | Review error/warning counts, redacted findings, gallery status, and optional render status |
| `matlab-plotting-skill` | `render_report.md and render_report.json`, generated PNG/SVG outputs, selected scheme explanation | User feedback issue or future gallery/template request | Share the redacted report summary and selected scheme, then decide whether the chart task belongs in this gallery |
| `scientific-diagram-skill` | `.drawio` source, SVG preview, and provenance note | Diagram feedback issue or future docs/gallery handoff | Check that the diagram is clean-room, editable, and free of paper-figure tracing or private metadata |
| `python-plotting-skill` | `docs/gallery/*.png and docs/gallery/*.svg`, chart-selection notes, repository check output | Maintainer review or future cross-language template request | Check that the Python example answers the same figure question without copying MATLAB-only implementation details |

Do not move private datasets, local template folders, journal screenshots,
watermarked images, binary MATLAB project files, or copied third-party helper
code across this boundary. If a local resource suggests a useful chart family,
rewrite the idea as a public task and back it with synthetic data before it
enters a public repository.

## Current Feedback Channels

| Workflow | Public feedback path | Good feedback includes |
|---|---|---|
| Fresh clone of the main gallery/API | [`matlab-scientific-figures#9`](https://github.com/Kkkakania/matlab-scientific-figures/issues/9) | OS, MATLAB version, commit, commands run, selected template, failure or confusing step |
| Agent-assisted data-to-figure rendering | [`matlab-plotting-skill#11`](https://github.com/Kkkakania/matlab-plotting-skill/issues/11) | Data shape summary, selected scheme, report summary, redacted command output |
| Research diagram Skill first use | [`scientific-diagram-skill#1`](https://github.com/Kkkakania/scientific-diagram-skill/issues/1) | Diagram type, Mermaid draft usefulness, whether `.drawio` source was needed, provenance or handoff confusion |
| Python plotting Skill first use | [`python-plotting-skill#1`](https://github.com/Kkkakania/python-plotting-skill/issues/1) | Python version, command run, chart tried, output readability, confusing setup step |
| CI or release preflight for figure repos | [`matlab-figure-ci#1`](https://github.com/Kkkakania/matlab-figure-ci/issues/1) | Package workflow result, preflight JSON summary, clean-install notes |

Do not post private datasets, local account names, copied journal figures,
source packs, or full local paths in feedback.

## Maintenance Signals

- The main gallery keeps 31 committed clean-room PNG/SVG examples.
- The main gallery dogfoods `matlab-figure-ci` in GitHub Actions for static
  figure-repository checks.
- `matlab-plotting-skill now runs mfigci check` in its public quality workflow
  before a render result becomes first-use feedback or a future gallery request.
- MATLAB rendering is still a local gate because public hosted runners normally
  do not include MATLAB.
- The skill repository provides a separate first-render path for users who want
  an agent to choose a chart from their own data.
- `scientific-diagram-skill` is now a separate public Skill repository for
  Mermaid and draw.io research diagrams, with a checked `.drawio` example and a
  first-use feedback issue.
- `python-plotting-skill` is public and intentionally small. It should gather
  first-use feedback before it becomes a larger template library.
- JSON payloads are documented producer by producer. See
  [JSON envelope compatibility](json-envelope-compatibility.md) before changing
  manifest, report, doctor, or preflight payload shapes across repositories.
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
