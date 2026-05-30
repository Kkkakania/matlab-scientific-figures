# MATLAB Scientific Figures

[![Quality checks](https://github.com/Kkkakania/matlab-scientific-figures/actions/workflows/quality.yml/badge.svg)](https://github.com/Kkkakania/matlab-scientific-figures/actions/workflows/quality.yml)
[![Release](https://img.shields.io/github/v/release/Kkkakania/matlab-scientific-figures)](https://github.com/Kkkakania/matlab-scientific-figures/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Clean-room MATLAB templates for publication-ready scientific figures.

This project helps students, researchers, and engineers create consistent
figures without copying private notes, third-party template packs, or
watermarked source material. The first release focuses on a compact gallery of
high-frequency chart types with deterministic synthetic data and headless
MATLAB CLI rendering.

## Why This Project Exists

Scientific plotting is a repeated maintenance problem: every paper, report, or
engineering review needs consistent typography, export settings, visual
encodings, and provenance-safe example data. This repository turns that work
into a small, testable toolkit instead of a folder of one-off scripts.

## Gallery

Run `runAllExamples` to generate the gallery locally. The examples cover:

| Task | Preview |
|---|---|
| Time trend | <img src="gallery/line_plot.png" width="260" alt="Line plot"> |
| Uncertainty | <img src="gallery/confidence_interval.png" width="260" alt="Confidence interval"> |
| Dense relationship | <img src="gallery/density_scatter.png" width="260" alt="Density scatter"> |
| Method comparison | <img src="gallery/grouped_bar.png" width="260" alt="Grouped bar"> |
| Matrix pattern | <img src="gallery/heatmap.png" width="260" alt="Heatmap"> |
| Ranking | <img src="gallery/lollipop_ranking.png" width="260" alt="Lollipop ranking"> |

The full gallery includes line plots, confidence intervals, scatter plots,
density scatter plots, grouped bars, heatmaps, bubble matrices, box plots with
jittered observations, lollipop rankings, and 3D surfaces.

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

## Design

- `sftTheme` centralizes figure size, font, grid, and line defaults.
- `sftPalette` provides clean-room palettes for categorical and sequential data.
- `sftExampleData` generates deterministic synthetic data with a fixed seed.
- `sftExport` writes PNG, PDF, and SVG outputs from one call.
- `sftValidateFigure` checks basic publication-readiness before export.
- `runAllExamples` renders the full gallery in headless mode.

## Documentation

| Guide | Purpose |
|---|---|
| [Chart selection guide](docs/chart-selection-guide.md) | Pick a chart by communication task |
| [Figure quality checklist](docs/figure-quality-checklist.md) | Review a figure before release |
| [Template author guide](docs/template-author-guide.md) | Add a new clean-room example |
| [MATLAB CLI guide](docs/matlab-cli-guide.md) | Render figures in scripts and CI-like workflows |
| [Provenance policy](docs/provenance-policy.md) | Keep public releases clean and auditable |
| [Maintainer workflow](docs/openai-codex-workflow.md) | Use AI assistance without weakening review |
| [Roadmap](ROADMAP.md) | Track planned template and workflow milestones |

## Copyright And Provenance

This repository is a clean-room rewrite. It does not include private archives,
encrypted MATLAB files, raw article packs, journal image collections, or copied
third-party template code. See `docs/provenance-policy.md` for the project
rules.

Pass `["png", "pdf", "svg"]` to `runAllExamples` when local PDF exports are
needed for papers or slides.

## Requirements

- MATLAB R2020b or newer is recommended.
- MATLAB R2025a is used for local verification.
- No example requires external data files.

## Project Status

Current stable release: `v0.1.0`.

The project is intentionally small in the first release. New templates should
arrive with examples, deterministic data, documentation, and provenance checks.
