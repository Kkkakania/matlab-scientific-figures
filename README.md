# MATLAB Scientific Figures

Clean-room MATLAB templates for publication-ready scientific figures.

This project helps students, researchers, and engineers create consistent
figures without copying private notes, third-party template packs, or
watermarked source material. The first release focuses on a compact gallery of
high-frequency chart types with deterministic synthetic data and headless
MATLAB CLI rendering.

## Gallery

Run `runAllExamples` to generate the gallery locally. The examples cover:

| Task | Example |
|---|---|
| Time trend | `line_plot` |
| Uncertainty | `confidence_interval` |
| Group relationship | `scatter_plot` |
| Dense relationship | `density_scatter` |
| Method comparison | `grouped_bar` |
| Matrix pattern | `heatmap` |
| Matrix magnitude | `bubble_matrix` |
| Group distribution | `box_jitter` |
| Ranking | `lollipop_ranking` |
| 3D field | `surface_3d` |

## Quick Start

From MATLAB:

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
runAllExamples('gallery', ["png", "svg"]);
```

From macOS shell with MATLAB R2025a:

```bash
/Applications/MATLAB_R2025a.app/bin/matlab -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('gallery')"
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
- `runAllExamples` renders the full gallery in headless mode.

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

Current release target: `v0.1.0`.

The project is intentionally small in the first release. New templates should
arrive with examples, deterministic data, documentation, and provenance checks.
