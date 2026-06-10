# Template Backlog

This is the queue for figure types worth adding next. The list is based on
common research plotting needs: correlation, comparison, composition, time
change, density, and paper layouts.

The rule is simple: the public repo gets original MATLAB code, synthetic data,
gallery output, tests, and documentation. Reference material can guide the
choice of chart type, but source files are not copied into the repo.
Use [Local resource intake](local-resource-intake.md) before turning a private
resource collection into public backlog items.

## Current Coverage

The current gallery on `main` has 30 examples covering trends, uncertainty, dense
x-y structure, grouped comparison, distributions, matrices, rankings,
multivariate profiles, daily patterns, three-part composition, estimate intervals,
method agreement, paired change, cumulative contribution steps, flow structure,
multi-panel figures, and one 3D surface.
New work should improve real user workflows before adding more chart types.

## Already Covered

| Need | Example |
|---|---|
| Time trend | `line_plot` |
| Daily pattern | `calendar_heatmap` |
| Uncertainty band | `confidence_interval`, `uncertainty_fan_chart` |
| Three-part composition | `ternary_scatter` |
| Dense x-y relationship | `density_scatter`, `contour_scatter` |
| Method agreement | `bland_altman_plot` |
| Method comparison | `grouped_bar`, `grouped_error_bar`, `butterfly_comparison` |
| Estimate intervals | `forest_plot` |
| Cumulative contribution | `waterfall_chart` |
| Paired change | `paired_slopegraph` |
| Composition and flow | `waffle_chart`, `sankey_flow` |
| Matrix values | `heatmap`, `bubble_matrix` |
| Correlation matrix | `correlation_bubble`, `double_triangle_heatmap` |
| Distribution comparison | `box_jitter`, `ridgeline_plot` |
| Metric profile comparison | `radar_chart` |
| Multivariate sample comparison | `parallel_coordinates` |
| Ranking | `lollipop_ranking` |
| Signed change and local events | `positive_negative_area`, `zoomed_inset_line` |
| Multi-panel layout | `multi_panel_overview` |
| Smooth 3D response | `surface_3d` |

## High-Value Next Templates

| Priority | Template | Why it is useful |
|---|---|---|
| High | Signal-processing pack | FFT, Welch PSD, spectrogram, group delay, and envelope plots are common in MATLAB-heavy work and map cleanly to synthetic examples |
| High | Electrical diagnostics pack | Impedance locus, harmonic spectrum, voltage sag, THD bars, and three-phase waveform examples fit the project's current domain examples |
| Medium | Model-evaluation pack | ROC, precision-recall, calibration, residual, learning-curve, and confusion-matrix plots help users move beyond generic line charts |
| Medium | Distribution comparison pack | Raincloud, split violin, swarm, ECDF, and notched box plots cover a lot of experiment-summary work |
| Medium | Polar and direction pack | Wind rose, antenna pattern, polar heatmap, and compass plots are useful but need careful labeling and export checks |
| Later | 3D density scatter | Attractive, but only worth adding if users need depth |
| Later | Texture-filled bars | Useful for grayscale printing, but easy to overdo |

These items came from task-level review of local plotting resources and common
MATLAB workflows. They are not ports of the local files.

## Candidate De-Duplication Notes

Do not add `fft_spectrum` just to increase the template count. The repository
already has `renderHarmonicSpectrum` as a small electrical-domain frequency
example. A new FFT/PSD candidate is only useful if it answers a distinct task:

- raw time-domain signal to single-sided amplitude spectrum;
- windowing or leakage comparison;
- Welch PSD for noisy measurements;
- spectrogram or time-frequency view;
- report text that explains sampling rate, bin spacing, and units.

If the task is only "show harmonic magnitudes by order", use the existing
`harmonic-spectrum` domain example instead of adding another frequency plot.

## Prototype-Derived Triage Notes

A private prototype library now sketches more than 200 figure ideas across
electrical, signal, control, RF, ML, CFD, optimization, distribution,
multivariate, polar, and 3D families. The useful next step is not to import that
library. The useful next step is to pick a few public, testable gaps:

- electrical diagnostics that already match existing domain examples;
- power and energy plots only when the task can be shown with small synthetic
  waveforms or tabular summaries;
- signal-processing plots with simple deterministic waveforms;
- model-evaluation plots that use small synthetic classifiers;
- palette documentation that can be checked without copying palette packs;
- diagram-style figures only when they communicate data flow or system
  structure better than plain prose;
- Origin interoperability notes that keep `.opju` and workbook files out of the
  repository.

Anything outside those lanes should wait for real user feedback.

## Workflow Work Before More Templates

Completed workflow foundations:

- Template registry for discovery and selected rendering.
- One-template and query-based render commands that do not require calling
  renderer names by hand.
- Documentation for adapting figure size, font, data inputs, and export format.
- Consistency checks between `runAllExamples`, `examples/README.md`,
  `docs/template-reference.md`, `mfigci.yml`, the manifest, and the committed
  gallery.

Next workflow improvements should focus on:

- First-use testing from a fresh clone. See
  [First-use test](first-use-test.md) for the current reproducible feedback
  checklist.
- Windows/Linux MATLAB CLI notes.
- Generated documentation tables from `docs/template-manifest.json`.
- Lightweight color-accessibility checks for changed gallery images.
- Better examples for real CSV/Excel data while keeping public data synthetic.

## What Not To Add Yet

- Large algorithm collections.
- Image reference packs.
- Raw `.mat`, `.fig`, `.p`, `.xlsx`, `.docx`, or paper screenshots.
- Templates that need unclear local helper functions.
- Decorative charts that do not make the data easier to read.

## Adding A Backlog Item

Open a figure-template request issue with:

- the communication task
- the input data shape
- where the figure will be used
- any constraints such as long labels or grayscale printing
- the intake decision if the idea came from a local resource collection

Then implement it as a normal example: data, renderer, gallery PNG/SVG, docs,
and tests.
