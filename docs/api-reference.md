# API Reference

This page lists the public MATLAB entry points that are useful from scripts,
live scripts, and batch rendering jobs.

## Discovery

| Function | Use When |
|---|---|
| `sftListTemplates()` | Show every public template with name, output name, task, and tags. |
| `sftListTags()` | Show every tag and how many templates use it. |
| `sftFindTemplates(query)` | Search names, tasks, output names, and tags with loose text matching. |
| `sftFindTemplatesByTag(tags)` | Find templates that use exact tags such as `matrix` or `agreement`. |
| `sftTemplateInfo(name)` | Inspect one template's renderer, files, task, and tags. |
| `sftTemplateManifest()` | Return machine-readable template metadata as a struct array. |
| `sftWriteTemplateManifest(file)` | Write the metadata JSON used by docs and checks. |

Example:

```matlab
templates = sftFindTemplatesByTag("matrix");
disp(templates(:, ["Name", "Task"]))
info = sftTemplateInfo("heatmap")
```

## Rendering

| Function | Use When |
|---|---|
| `runAllExamples(outputDir, formats)` | Rebuild the full gallery. |
| `sftRenderExamples(names, outputDir, formats)` | Render a selected set by template name. |
| `sftRenderTags(tags, outputDir, formats)` | Render every template with one or more exact tags. |
| `sftRenderMatches(query, outputDir, formats)` | Render every template returned by a loose search query. |
| `sftGalleryReport(outputDir, formats)` | Render the gallery and return validation status. |

Example:

```matlab
sftRenderTags("matrix", "gallery", ["png", "svg"]);
sftRenderExamples(["heatmap", "radar_chart"], "gallery", ["png", "svg"]);
```

## Styling And Export

| Function | Use When |
|---|---|
| `sftTheme(varargin)` | Create shared figure defaults such as size, font, and line width. |
| `sftPalette(name, n)` | Get categorical, sequential, diverging, or contrast colors. |
| `sftApplyTheme(ax, theme)` | Apply shared styling to an axes object. |
| `sftStyleLegend(legendHandle, theme)` | Keep legends visually consistent. |
| `sftTiledFigure(rows, cols)` | Create a compact tiled layout. |
| `sftExport(fig, outputBase, formats)` | Export PNG, PDF, or SVG from one call. |
| `sftValidateFigure(fig)` | Check common figure-quality requirements before export. |

Example:

```matlab
theme = sftTheme("FigureSize", [12 8]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
plot(1:4, [1 3 2 5], "LineWidth", theme.LineWidth);
xlabel("Sample");
ylabel("Response");
title("Example");
sftApplyTheme(gca, theme);
sftValidateFigure(fig);
sftExport(fig, "gallery/my_example", ["png", "svg"]);
close(fig);
```

## Reusable Plotting Functions

| Function | Use When |
|---|---|
| `sftPlotHeatmap(ax, matrix, labels, theme)` | Draw a themed square matrix heatmap into an existing axes. |
| `sftPlotLineSeries(ax, x, y, labels, theme)` | Draw one or more themed line series into an existing axes. |
| `sftPlotConfidenceBand(ax, x, center, lower, upper, labels, theme)` | Draw line series with shaded uncertainty bands. |
| `sftPlotUncertaintyFan(ax, x, medianValue, p10, p25, p75, p90, theme)` | Draw nested percentile bands around a median trend. |
| `sftPlotGroupedScatter(ax, x, y, groups, theme)` | Draw a grouped x-y scatter plot into an existing axes. |
| `sftPlotTernaryScatter(ax, compositions, groups, componentLabels, theme)` | Draw grouped three-part compositions on a ternary frame. |
| `sftPlotDensityScatter(ax, x, y, bins, theme)` | Draw a density-colored x-y scatter plot for large point clouds. |
| `sftPlotContourScatter(ax, x, y, bins, theme)` | Draw density contours with overlaid scatter points. |
| `sftPlotBlandAltman(ax, methodA, methodB, theme)` | Draw method agreement with bias and 95% limits of agreement. |
| `sftPlotCorrelationBubble(ax, matrix, labels, theme)` | Draw a bubble heatmap for a correlation matrix. |
| `sftPlotForest(ax, estimate, lower, upper, labels, reference, theme)` | Draw effect estimates with interval bounds and a reference line. |
| `sftPlotWaterfallChart(ax, startValue, steps, stepLabels, theme)` | Draw cumulative contribution steps. |
| `sftPlotGroupedBar(ax, values, groupLabels, seriesLabels, theme)` | Draw grouped bars for scenario or method comparison. |
| `sftPlotGroupedErrorBar(ax, values, errors, groupLabels, seriesLabels, theme)` | Draw grouped bars with matched error bars. |
| `sftPlotBoxJitter(ax, group, value, theme)` | Draw grouped distributions with jittered observations. |
| `sftPlotLollipopRanking(ax, labels, values, theme)` | Draw a sorted lollipop ranking chart. |
| `sftPlotWaffleChart(ax, counts, labels, theme)` | Draw a 100-cell composition chart. |
| `sftPlotButterflyComparison(ax, leftValues, rightValues, labels, sideLabels, theme)` | Draw mirrored horizontal bars around a shared baseline. |
| `sftPlotPairedSlopegraph(ax, before, after, labels, conditionLabels, theme)` | Draw paired before-after changes for matched items. |
| `sftPlotRadarChart(ax, values, metrics, series, theme)` | Draw normalized metric profiles as radar polygons. |
| `sftPlotParallelCoordinates(ax, values, features, groups, theme)` | Draw normalized multivariate profiles by group. |
| `sftPlotRidgeline(ax, values, labels, theme)` | Draw compact stacked density profiles for groups. |
| `sftPlotPositiveNegativeArea(ax, x, y, baseline, theme)` | Draw signed deviations around a baseline. |
| `sftPlotZoomedInsetLine(fig, x, y, zoomRange, theme)` | Draw a full trend with a detailed inset window. |
| `sftPlotCalendarHeatmap(ax, values, weekLabels, dayLabels, theme)` | Draw daily values in a day-by-week heatmap. |
| `sftPlotBubbleMatrix(ax, matrix, rowLabels, colLabels, theme)` | Draw matrix magnitudes with bubble area and color. |
| `sftPlotDoubleTriangleHeatmap(ax, upperValues, lowerValues, labels, theme)` | Compare two square matrices in one layout. |
| `sftPlotSankeyFlow(ax, nodes, edges, theme)` | Draw weighted flow bands across staged nodes. |
| `sftPlotSurface3D(ax, x, y, z, theme)` | Draw a smooth themed 3D response surface. |
| `sftPlotMultiPanelOverview(lineData, scatterData, barData, rankingData, theme)` | Draw a four-panel overview figure from reusable data structures. |

Example:

```matlab
theme = sftTheme("FigureSize", [12 10]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotHeatmap(ax, corr(randn(80, 5)), ["A", "B", "C", "D", "E"], theme);
sftExport(fig, "gallery/my_heatmap", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme();
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotLineSeries(ax, 1:6, [1 3 2 5 4 6; 2 2.5 3 3.5 3.2 4], ["A", "B"], theme);
xlabel(ax, "Sample");
ylabel(ax, "Response");
title(ax, "Two Series");
sftExport(fig, "gallery/my_line_plot", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [15 9]);
x = 1:6;
center = [1 2 2.5 3.2 3.5 4];
spread = 0.25 + 0.05 * x;
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotConfidenceBand(ax, x, center, center - spread, center + spread, "Method A", theme);
xlabel(ax, "Sample");
ylabel(ax, "Estimate");
title(ax, "Estimate With Uncertainty");
sftExport(fig, "gallery/my_confidence_band", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [14 8.5]);
x = 1:12;
medianValue = 0.2 * x + sin(x / 3);
spread = 0.3 + 0.03 * x;
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotUncertaintyFan(ax, x, medianValue, medianValue - 2 * spread, ...
    medianValue - spread, medianValue + spread, medianValue + 2 * spread, theme);
sftExport(fig, "gallery/my_uncertainty_fan", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [12 10]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotGroupedScatter(ax, randn(90, 1), randn(90, 1), repelem(["A"; "B"; "C"], 30), theme);
xlabel(ax, "Feature X");
ylabel(ax, "Feature Y");
title(ax, "Grouped Relationship");
sftExport(fig, "gallery/my_grouped_scatter", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [12 10]);
compositions = [0.35 0.40 0.25; 0.58 0.22 0.20; 0.20 0.26 0.54];
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotTernaryScatter(ax, compositions, ["Balanced", "A-rich", "C-rich"], ...
    ["Component A", "Component B", "Component C"], theme);
sftExport(fig, "gallery/my_ternary_scatter", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [12 10]);
x = [randn(300, 1) * 0.7; randn(220, 1) * 0.45 + 1.1];
y = [0.6 * x(1:300) + randn(300, 1) * 0.35; -0.4 * x(301:end) + randn(220, 1) * 0.28 + 1.2];
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotDensityScatter(ax, x, y, 36, theme);
xlabel(ax, "Variable X");
ylabel(ax, "Variable Y");
title(ax, "Density Scatter");
sftExport(fig, "gallery/my_density_scatter", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [12 8]);
x = [randn(260, 1) * 0.7; randn(180, 1) * 0.45 + 1.1];
y = [0.5 * x(1:260) + randn(260, 1) * 0.35; -0.35 * x(261:end) + randn(180, 1) * 0.28 + 1.1];
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotContourScatter(ax, x, y, 34, theme);
sftExport(fig, "gallery/my_contour_scatter", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13.5 9]);
methodA = 40 + 10 * randn(80, 1);
methodB = methodA + 1.2 + 2.5 * randn(80, 1);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotBlandAltman(ax, methodA, methodB, theme);
sftExport(fig, "gallery/my_bland_altman", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13 11]);
matrix = corr(randn(120, 5));
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotCorrelationBubble(ax, matrix, ["A", "B", "C", "D", "E"], theme);
sftExport(fig, "gallery/my_correlation_bubble", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [14 9]);
values = [4.2 3.1; 5.0 4.1; 3.6 4.7];
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotGroupedBar(ax, values, ["Baseline", "Method A", "Method B"], ["Precision", "Recall"], theme);
sftExport(fig, "gallery/my_grouped_bar", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13.5 8.5]);
estimate = [-0.18 0.12 0.28 -0.06];
lower = estimate - [0.16 0.20 0.13 0.18];
upper = estimate + [0.16 0.20 0.13 0.18];
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotForest(ax, estimate, lower, upper, ["Baseline", "Fusion", "Control", "Margin"], 0, theme);
sftExport(fig, "gallery/my_forest_plot", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13 8.5]);
values = [4.4 3.8; 5.2 4.7; 3.9 4.3];
errors = [0.28 0.22; 0.31 0.26; 0.24 0.27];
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotGroupedErrorBar(ax, values, errors, ["Baseline", "Method A", "Method B"], ["Dataset 1", "Dataset 2"], theme);
sftExport(fig, "gallery/my_grouped_error_bar", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [12 9]);
group = categorical(repelem(["A", "B", "C"], 30).');
value = randn(90, 1) + repelem([0 0.4 0.8], 30).';
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotBoxJitter(ax, group, value, theme);
sftExport(fig, "gallery/my_box_jitter", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13 9]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotLollipopRanking(ax, ["Grid", "Storage", "Sensing", "Forecast"], [0.91 0.83 0.78 0.72], theme);
sftExport(fig, "gallery/my_lollipop_ranking", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13.5 8.5]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotWaterfallChart(ax, 100, [18 12 -9 15 -6], ...
    ["Efficiency", "Storage", "Curtailment", "Forecast", "Control"], theme);
sftExport(fig, "gallery/my_waterfall_chart", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [12 9]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotWaffleChart(ax, [42 27 19 12], ...
    ["Completed", "In progress", "Queued", "Blocked"], theme);
sftExport(fig, "gallery/my_waffle_chart", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13 9.5]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotButterflyComparison(ax, [38 31 28], [34 36 30], ...
    ["North", "East", "South"], ["Scenario A", "Scenario B"], theme);
sftExport(fig, "gallery/my_butterfly_comparison", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [16 9.2], "FontSize", 8);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotPairedSlopegraph(ax, [0.62 0.71 0.78], [0.78 0.83 0.64], ...
    ["Efficiency", "Reliability", "Response time"], ["Baseline", "Updated"], theme);
sftExport(fig, "gallery/my_paired_slopegraph", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [12 9]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotRadarChart(ax, ...
    [0.72 0.66 0.58; 0.84 0.73 0.64], ...
    ["Accuracy", "Speed", "Memory"], ["Baseline", "Method A"], theme);
sftExport(fig, "gallery/my_radar_chart", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [14 8]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotParallelCoordinates(ax, ...
    [0.62 0.58 0.70; 0.72 0.69 0.78; 0.80 0.76 0.82], ...
    ["Accuracy", "Throughput", "Stability"], ["Base", "Base", "Tuned"], theme);
sftExport(fig, "gallery/my_parallel_coordinates", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13 8.5]);
values = [randn(120, 1), randn(120, 1) + 0.7, randn(120, 1) + 1.2];
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotRidgeline(ax, values, ["Control", "Treatment A", "Treatment B"], theme);
sftExport(fig, "gallery/my_ridgeline_plot", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [14 8]);
x = linspace(0, 10, 160);
y = sin(x) + 0.15 * cos(3 * x);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotPositiveNegativeArea(ax, x, y, 0, theme);
sftExport(fig, "gallery/my_positive_negative_area", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [14 9.3]);
x = linspace(0, 24, 260);
y = 0.05 * x + sin(0.4 * x) + exp(-0.5 * ((x - 12) / 0.6) .^ 2);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
sftPlotZoomedInsetLine(fig, x, y, [10.8 13.6], theme);
sftExport(fig, "gallery/my_zoomed_inset_line", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13.5 7.5], "FontSize", 9);
values = reshape(1:28, 7, 4);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotCalendarHeatmap(ax, values, "W" + string(1:4), ...
    ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"], theme);
sftExport(fig, "gallery/my_calendar_heatmap", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [12 10]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotBubbleMatrix(ax, abs(randn(4, 5)), ...
    ["R1", "R2", "R3", "R4"], "C" + string(1:5), theme);
sftExport(fig, "gallery/my_bubble_matrix", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13 11]);
upper = corr(randn(80, 4));
lower = corr(randn(80, 4));
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotDoubleTriangleHeatmap(ax, upper, lower, ["A", "B", "C", "D"], theme);
sftExport(fig, "gallery/my_double_triangle_heatmap", ["png", "svg"]);
close(fig);
```

```matlab
nodes = table(["Input"; "Process"; "Output"], [1; 2; 3], ...
    'VariableNames', {'Name', 'Stage'});
edges = table(["Input"; "Process"], ["Process"; "Output"], [12; 9], ...
    'VariableNames', {'Source', 'Target', 'Weight'});
theme = sftTheme("FigureSize", [14 8.5]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotSankeyFlow(ax, nodes, edges, theme);
sftExport(fig, "gallery/my_sankey_flow", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [13 10]);
[x, y] = meshgrid(linspace(-3, 3, 60), linspace(-3, 3, 60));
z = peaks(x, y) / 8;
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotSurface3D(ax, x, y, z, theme);
sftExport(fig, "gallery/my_surface_3d", ["png", "svg"]);
close(fig);
```

```matlab
theme = sftTheme("FigureSize", [16 11], "FontSize", 8.5, "MarkerSize", 32);
lineData = struct("x", 1:8, "y", [1 2 3 2.8 4 4.5 4.7 5]);
scatterData = struct("x", randn(80, 1), "y", randn(80, 1));
barData = struct("values", [4.2 5.0 3.6 4.8], ...
    "labels", ["Baseline", "Method A", "Method B", "Method C"]);
rankingData = struct("values", [0.91 0.83 0.78 0.72], ...
    "labels", ["Grid", "Storage", "Sensing", "Forecast"]);
fig = sftPlotMultiPanelOverview(lineData, scatterData, barData, rankingData, theme);
sftExport(fig, "gallery/my_multi_panel_overview", ["png", "svg"]);
close(fig);
```

## Maintainer-Oriented Helpers

| Function | Use When |
|---|---|
| `sftTemplateRegistry()` | Maintain the source of truth for public template metadata. |
| `sftExampleData(kind)` | Generate deterministic synthetic data for examples. |
| `sftFinalizeFigure(fig, outputBase, formats)` | Validate, export, and close an example figure. |

Most users can ignore these helpers unless they are adding a new template.
