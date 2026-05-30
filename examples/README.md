# Examples

Each example is a small rendering function that uses synthetic data, applies a
shared theme, exports stable files, and closes its figure. The examples are
designed for headless batch rendering through `runAllExamples`.

## Gallery Map

| Output name | Function | Communication task |
|---|---|---|
| `line_plot` | `renderLinePlot` | Show changes over an ordered axis |
| `confidence_interval` | `renderConfidenceInterval` | Show uncertainty around an estimate |
| `scatter_plot` | `renderScatterPlot` | Show relationships across groups |
| `density_scatter` | `renderDensityScatter` | Show dense point clouds without overplotting |
| `grouped_bar` | `renderGroupedBar` | Compare methods across a few metrics |
| `grouped_error_bar` | `renderGroupedErrorBar` | Compare methods with uncertainty bars |
| `butterfly_comparison` | `renderButterflyComparison` | Compare two sides around a shared baseline |
| `waffle_chart` | `renderWaffleChart` | Show composition or progress as countable cells |
| `positive_negative_area` | `renderPositiveNegativeArea` | Show signed change around a baseline |
| `ridgeline_plot` | `renderRidgelinePlot` | Compare distributions across many groups |
| `heatmap` | `renderHeatmap` | Show a matrix pattern |
| `correlation_bubble` | `renderCorrelationBubble` | Show positive and negative pairwise correlations |
| `double_triangle_heatmap` | `renderDoubleTriangleHeatmap` | Compare two metrics in one pairwise matrix |
| `zoomed_inset_line` | `renderZoomedInsetLine` | Show a long trend and a local event window |
| `bubble_matrix` | `renderBubbleMatrix` | Show matrix magnitude with position and area |
| `box_jitter` | `renderBoxJitter` | Compare group distributions and observations |
| `lollipop_ranking` | `renderLollipopRanking` | Rank factors or features |
| `multi_panel_overview` | `renderMultiPanelOverview` | Combine small plots in one paper-style figure |
| `surface_3d` | `renderSurface3D` | Show a smooth response over two variables |

## Run One Example

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
renderHeatmap('gallery', ["png", "svg"]);
```

## Run The Full Gallery

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
runAllExamples('gallery', ["png", "svg"]);
```

## Add A New Example

Use `docs/template-author-guide.md` before adding a new file. A new example
should include the rendering function, deterministic example data, gallery
output, documentation updates, and tests when it changes shared behavior.
