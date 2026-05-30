# Template Reference

This page mirrors `sftTemplateRegistry`. If you add, rename, or remove a
template, update this table in the same pull request.

From MATLAB:

```matlab
sftListTemplates()
sftFindTemplates("matrix")
sftTemplateManifest()
sftRenderExamples(["heatmap", "double_triangle_heatmap"], "gallery")
sftRenderMatches("matrix", "gallery")
```

From a shell:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh list
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh search matrix
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh match matrix
```

For tools that need metadata without running MATLAB, use
`docs/template-manifest.json`. Regenerate it with:

```matlab
sftWriteTemplateManifest()
```

| Template | Renderer | Task | Tags |
|---|---|---|---|
| `line_plot` | `renderLinePlot` | Show time trend | `trend`, `line` |
| `confidence_interval` | `renderConfidenceInterval` | Show uncertainty | `uncertainty`, `line` |
| `scatter_plot` | `renderScatterPlot` | Show grouped x-y relationship | `scatter`, `groups` |
| `density_scatter` | `renderDensityScatter` | Show dense x-y relationship | `scatter`, `density` |
| `contour_scatter` | `renderContourScatter` | Show local density structure | `scatter`, `density`, `contour` |
| `grouped_bar` | `renderGroupedBar` | Compare grouped values | `bar`, `comparison` |
| `grouped_error_bar` | `renderGroupedErrorBar` | Compare grouped values with uncertainty | `bar`, `uncertainty` |
| `butterfly_comparison` | `renderButterflyComparison` | Compare two sides around a baseline | `bar`, `comparison` |
| `waffle_chart` | `renderWaffleChart` | Show countable composition | `composition`, `percentage` |
| `sankey_flow` | `renderSankeyFlow` | Show flow magnitude across stages | `flow`, `composition` |
| `positive_negative_area` | `renderPositiveNegativeArea` | Show signed change around a baseline | `area`, `change` |
| `ridgeline_plot` | `renderRidgelinePlot` | Compare many distributions | `distribution`, `density` |
| `radar_chart` | `renderRadarChart` | Compare normalized metric profiles | `profile`, `metrics` |
| `parallel_coordinates` | `renderParallelCoordinates` | Compare multivariate sample profiles | `multivariate`, `profile` |
| `heatmap` | `renderHeatmap` | Show matrix values | `matrix`, `heatmap` |
| `correlation_bubble` | `renderCorrelationBubble` | Show correlation strength and sign | `matrix`, `correlation` |
| `double_triangle_heatmap` | `renderDoubleTriangleHeatmap` | Compare two pairwise matrices | `matrix`, `comparison` |
| `zoomed_inset_line` | `renderZoomedInsetLine` | Show a long trend and local event | `trend`, `inset` |
| `bubble_matrix` | `renderBubbleMatrix` | Show matrix magnitude with bubble area | `matrix`, `bubble` |
| `box_jitter` | `renderBoxJitter` | Compare distributions and observations | `distribution`, `points` |
| `lollipop_ranking` | `renderLollipopRanking` | Rank factors or features | `ranking`, `lollipop` |
| `multi_panel_overview` | `renderMultiPanelOverview` | Combine small plots in one figure | `layout`, `multipanel` |
| `surface_3d` | `renderSurface3D` | Show a smooth 3D response | `surface`, `3d` |
