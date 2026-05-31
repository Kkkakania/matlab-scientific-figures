# Use With Your Data

The fastest way to use this repo is to copy one example and replace the data
section. You do not need to keep the synthetic data helper in your own work.

## 1. Pick The Closest Example

Start from the chart, not the code:

- time series: `examples/renderLinePlot.m`
- signed change: `examples/renderPositiveNegativeArea.m`
- uncertainty band: `examples/renderConfidenceInterval.m`
- method comparison with uncertainty: `examples/renderGroupedErrorBar.m`
- dense x-y relationship: `examples/renderDensityScatter.m`
- correlation matrix: `examples/renderCorrelationBubble.m`
- ranked factors: `examples/renderLollipopRanking.m`
- small paper figure: `examples/renderMultiPanelOverview.m`

If two examples feel close, choose the simpler one first. It is easier to add a
label or color later than to unwind a complicated plot.

## 2. Use A Reusable Plot Function When Available

Some templates expose a small plotting function in `src/` so you can keep your
own data loading code separate from the gallery example. For example, a matrix
heatmap can be drawn directly into an axes:

```matlab
theme = sftTheme("FigureSize", [12 10]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotHeatmap(ax, myMatrix, myLabels, theme);
sftExport(fig, "outputs/my_heatmap", ["png", "svg"]);
close(fig);
```

Use this path when it exists. It is easier to test and easier to keep stable
than a copied renderer.

For a simple line chart, pass one x vector and one row per series:

```matlab
theme = sftTheme();
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotLineSeries(ax, timeHours, [baseline; treatment], ["Baseline", "Treatment"], theme);
xlabel(ax, "Time (hours)");
ylabel(ax, "Response");
title(ax, "Experiment Response");
sftExport(fig, "outputs/my_line_plot", ["png", "svg"]);
close(fig);
```

For uncertainty bands, keep your center, lower, and upper arrays the same shape:

```matlab
theme = sftTheme("FigureSize", [15 9]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotConfidenceBand(ax, x, center, lower, upper, ["Baseline", "Treatment"], theme);
xlabel(ax, "Input");
ylabel(ax, "Estimate");
title(ax, "Estimate With Uncertainty");
sftExport(fig, "outputs/my_confidence_band", ["png", "svg"]);
close(fig);
```

For grouped scatter plots, pass one group label for each point:

```matlab
theme = sftTheme("FigureSize", [12 10]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotGroupedScatter(ax, featureX, responseY, methodGroup, theme);
xlabel(ax, "Observed feature");
ylabel(ax, "Predicted response");
title(ax, "Grouped Scatter Plot");
sftExport(fig, "outputs/my_grouped_scatter", ["png", "svg"]);
close(fig);
```

For dense point clouds, use a density-colored scatter so overlapping points stay
readable:

```matlab
theme = sftTheme("FigureSize", [12 10]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotDensityScatter(ax, featureX, responseY, 36, theme);
xlabel(ax, "Variable X");
ylabel(ax, "Variable Y");
title(ax, "Density Scatter Plot");
sftExport(fig, "outputs/my_density_scatter", ["png", "svg"]);
close(fig);
```

For a correlation matrix, use the bubble heatmap when both sign and magnitude
matter:

```matlab
theme = sftTheme("FigureSize", [13 11]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotCorrelationBubble(ax, corrcoef(myTable{:,:}), string(myTable.Properties.VariableNames), theme);
sftExport(fig, "outputs/my_correlation_bubble", ["png", "svg"]);
close(fig);
```

For effect estimates or ablation results with intervals, use a forest plot:

```matlab
theme = sftTheme("FigureSize", [13.5 8.5]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotForest(ax, estimate, lowerBound, upperBound, scenarioLabels, 0, theme);
sftExport(fig, "outputs/my_forest_plot", ["png", "svg"]);
close(fig);
```

For method comparisons with uncertainty, keep `values` and `errors` the same
matrix size:

```matlab
theme = sftTheme("FigureSize", [13 8.5]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotGroupedErrorBar(ax, values, errors, methodLabels, datasetLabels, theme);
sftExport(fig, "outputs/my_grouped_error_bar", ["png", "svg"]);
close(fig);
```

For distributions where the raw observations matter, use a box plot with
jittered points:

```matlab
theme = sftTheme("FigureSize", [12 9]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotBoxJitter(ax, groupLabels, measurements, theme);
sftExport(fig, "outputs/my_box_jitter", ["png", "svg"]);
close(fig);
```

For ranked factors or feature importance, use a lollipop chart:

```matlab
theme = sftTheme("FigureSize", [13 9]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotLollipopRanking(ax, factorLabels, relativeScores, theme);
sftExport(fig, "outputs/my_lollipop_ranking", ["png", "svg"]);
close(fig);
```

For cumulative gains, losses, or contribution breakdowns, use a waterfall chart:

```matlab
theme = sftTheme("FigureSize", [13.5 8.5]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotWaterfallChart(ax, startValue, contributionSteps, contributionLabels, theme);
sftExport(fig, "outputs/my_waterfall_chart", ["png", "svg"]);
close(fig);
```

For 100-cell composition summaries, use a waffle chart. Counts must be
nonnegative integers that sum to 100:

```matlab
theme = sftTheme("FigureSize", [12 9]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotWaffleChart(ax, categoryCounts, categoryLabels, theme);
sftExport(fig, "outputs/my_waffle_chart", ["png", "svg"]);
close(fig);
```

For two-sided comparisons around a shared baseline, use a butterfly chart:

```matlab
theme = sftTheme("FigureSize", [13 9.5]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotButterflyComparison(ax, scenarioA, scenarioB, groupLabels, ...
    ["Scenario A", "Scenario B"], theme);
sftExport(fig, "outputs/my_butterfly_comparison", ["png", "svg"]);
close(fig);
```

For matched items measured before and after a change, use a paired slopegraph:

```matlab
theme = sftTheme("FigureSize", [16 9.2], "FontSize", 8);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotPairedSlopegraph(ax, beforeValues, afterValues, itemLabels, ...
    ["Before", "After"], theme);
sftExport(fig, "outputs/my_paired_slopegraph", ["png", "svg"]);
close(fig);
```

For a compact profile across a small set of normalized metrics, use a radar
chart. Values should already be scaled to the 0-1 range:

```matlab
theme = sftTheme("FigureSize", [12 9]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotRadarChart(ax, normalizedScores, metricLabels, methodLabels, theme);
sftExport(fig, "outputs/my_radar_chart", ["png", "svg"]);
close(fig);
```

For several normalized samples across the same feature set, use parallel
coordinates:

```matlab
theme = sftTheme("FigureSize", [14 8]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotParallelCoordinates(ax, normalizedFeatureMatrix, featureLabels, groupLabels, theme);
sftExport(fig, "outputs/my_parallel_coordinates", ["png", "svg"]);
close(fig);
```

For comparing many group distributions in one compact figure, use a ridgeline
plot. Put one group per column:

```matlab
theme = sftTheme("FigureSize", [13 8.5]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotRidgeline(ax, distributionMatrix, groupLabels, theme);
sftExport(fig, "outputs/my_ridgeline_plot", ["png", "svg"]);
close(fig);
```

For signed time-series deviations, use a positive-negative area chart. The
baseline can be a scalar or a vector the same length as `x`:

```matlab
theme = sftTheme("FigureSize", [14 8]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotPositiveNegativeArea(ax, timeValues, signalValues, baselineValues, theme);
sftExport(fig, "outputs/my_positive_negative_area", ["png", "svg"]);
close(fig);
```

For a long trend with one interval that needs close inspection, use a zoomed
inset line chart:

```matlab
theme = sftTheme("FigureSize", [14 9.3]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
sftPlotZoomedInsetLine(fig, timeValues, signalValues, zoomRange, theme);
sftExport(fig, "outputs/my_zoomed_inset_line", ["png", "svg"]);
close(fig);
```

For daily values arranged by weekday and week, use a calendar heatmap:

```matlab
theme = sftTheme("FigureSize", [13.5 7.5], "FontSize", 9);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotCalendarHeatmap(ax, dayByWeekValues, weekLabels, dayLabels, theme);
sftExport(fig, "outputs/my_calendar_heatmap", ["png", "svg"]);
close(fig);
```

For nonnegative matrix magnitudes where both position and size matter, use a
bubble matrix:

```matlab
theme = sftTheme("FigureSize", [12 10]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotBubbleMatrix(ax, magnitudeMatrix, rowLabels, columnLabels, theme);
sftExport(fig, "outputs/my_bubble_matrix", ["png", "svg"]);
close(fig);
```

## 3. Copy The Renderer

Copy the renderer into your own working folder and rename it:

```matlab
function files = renderMyExperiment(outputDir, formats)
```

Keep the function signature. It makes the file easy to run from MATLAB, from a
shell script, and later from a batch workflow.

## 4. Replace The Synthetic Data

In the gallery examples, the first line usually looks like this:

```matlab
data = sftExampleData('line');
```

Replace that part with your own arrays:

```matlab
data.x = timeHours;
data.y = [baseline; methodA; methodB];
data.labels = ["Baseline", "Method A", "Method B"];
```

Keep the rest of the renderer as boring as possible: plot, label, apply theme,
export.

## 5. Export Once, Then Inspect

Use PNG for quick review and SVG or PDF when you need vector output:

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
renderMyExperiment('outputs', ["png", "svg"]);
```

Before saving the final version, run a quick preflight:

```matlab
report = sftValidateFigure(gcf);
disp(report.Passed)
```

The validator only catches simple issues. Still check the exported image by
eye, especially legends, long labels, and small tick text.

## 6. Keep Local Details Out Of The Figure

Avoid putting personal names, local paths, private project names, or real sample
identifiers into example figures. Use neutral labels in shared code and add
project-specific labels only in your private analysis folder.
