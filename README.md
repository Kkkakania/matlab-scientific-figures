# MATLAB Scientific Figures

[![Quality checks](https://github.com/Kkkakania/matlab-scientific-figures/actions/workflows/quality.yml/badge.svg)](https://github.com/Kkkakania/matlab-scientific-figures/actions/workflows/quality.yml)
[![Release](https://img.shields.io/github/v/release/Kkkakania/matlab-scientific-figures)](https://github.com/Kkkakania/matlab-scientific-figures/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

MATLAB templates for clean, repeatable scientific figures.

Clone the repo, run the gallery, then copy the closest example and replace the
demo data with your own arrays. The examples are plain MATLAB files, so you can
read them quickly and change them without learning a framework.

## Why This Project Exists

Most research figures start as a one-off script. Then the font changes, the
legend covers the data, the export is blurry, or the same plot has to be made
again for a paper, slide deck, and report. This repo keeps those boring parts in
one place: theme, colors, export, example data, and a gallery you can rerun.

## Gallery

Run `runAllExamples` to generate the gallery locally. The examples cover:

| Task | Preview |
|---|---|
| Time trend | <img src="gallery/line_plot.png" width="260" alt="Line plot"> |
| Uncertainty | <img src="gallery/confidence_interval.png" width="260" alt="Confidence interval"> |
| Dense relationship | <img src="gallery/density_scatter.png" width="260" alt="Density scatter"> |
| Method comparison | <img src="gallery/grouped_bar.png" width="260" alt="Grouped bar"> |
| Method uncertainty | <img src="gallery/grouped_error_bar.png" width="260" alt="Grouped bar with error bars"> |
| Signed change | <img src="gallery/positive_negative_area.png" width="260" alt="Positive-negative area"> |
| Matrix pattern | <img src="gallery/heatmap.png" width="260" alt="Heatmap"> |
| Correlation matrix | <img src="gallery/correlation_bubble.png" width="260" alt="Correlation bubble heatmap"> |
| Paper layout | <img src="gallery/multi_panel_overview.png" width="260" alt="Multi-panel overview"> |
| Ranking | <img src="gallery/lollipop_ranking.png" width="260" alt="Lollipop ranking"> |

The full gallery includes line plots, confidence intervals, scatter plots,
density scatter plots, grouped bars, error bars, signed area charts, heatmaps,
correlation bubbles, bubble matrices, box plots with jittered observations,
lollipop rankings, and 3D surfaces. There is also a compact multi-panel example
for paper and slide figures.

## Quick Start

From MATLAB:

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
runAllExamples('gallery', ["png", "svg"]);
```

Validate one figure before exporting:

```matlab
fig = figure('Color', 'w');
plot(1:4, [1 3 2 5], 'LineWidth', 1.5);
title('Validation Example');
xlabel('Sample');
ylabel('Response');
report = sftValidateFigure(gcf);
disp(report.Passed)
```

From a shell with MATLAB installed:

```bash
matlab -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('gallery')"
```

Or use the helper script:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh
```

Check the examples without touching the committed gallery:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/validate_gallery.sh
```

## Design

- `sftTheme` keeps figure size, font, grid, and line defaults in one place.
- `sftPalette` provides categorical, sequential, and diverging palettes.
- `sftExampleData` generates deterministic synthetic data for the gallery.
- `sftExport` writes PNG, PDF, and SVG outputs from one call.
- `sftTiledFigure` creates a clean tiled layout without hand-tuning positions.
- `sftValidateFigure` catches a few common figure problems before export.
- `sftGalleryReport` batch-checks every gallery example.
- `runAllExamples` renders the full gallery in headless mode.

## Documentation

| Guide | Purpose |
|---|---|
| [Chart selection guide](docs/chart-selection-guide.md) | Pick a chart by communication task |
| [Use with your data](docs/use-with-your-data.md) | Turn a gallery example into your own figure |
| [Recipes](docs/recipes.md) | Common copy-paste edits |
| [Figure quality checklist](docs/figure-quality-checklist.md) | Review a figure before release |
| [Template author guide](docs/template-author-guide.md) | Add a new clean-room example |
| [Template backlog](docs/template-backlog.md) | See which high-value charts are planned |
| [MATLAB CLI guide](docs/matlab-cli-guide.md) | Render figures in scripts and CI-like workflows |
| [Release checklist](docs/release-checklist.md) | Check a release before tagging |
| [Provenance policy](docs/provenance-policy.md) | Keep public releases clean and auditable |
| [Maintainer workflow](docs/openai-codex-workflow.md) | Review PRs, issues, and releases consistently |
| [Roadmap](ROADMAP.md) | Track planned template and workflow milestones |

## Copyright And Provenance

This repository uses synthetic data and original example code. It does not ship
private archives, encrypted MATLAB files, article packs, journal image
collections, or copied third-party templates. See
`docs/provenance-policy.md` for the project rules.

Pass `["png", "pdf", "svg"]` to `runAllExamples` when local PDF exports are
needed for papers or slides.

## Figure Quality Checks

This repository dogfoods
[`matlab-figure-ci`](https://github.com/Kkkakania/matlab-figure-ci), a small
CLI/CI tool for MATLAB scientific figure repositories.

The workflow checks that gallery outputs exist and are non-empty, risky binary
or source files are not committed, privacy and provenance traces are flagged
before release, and optional MATLAB batch rendering can be enabled when MATLAB
is available.

## Requirements

- MATLAB R2020b or newer is recommended.
- MATLAB R2025a is used for local verification.
- No example requires external data files.

## Project Status

Current stable release: `v0.1.0`.

The project is intentionally small. New templates should arrive with examples,
deterministic data, documentation, and provenance checks.
