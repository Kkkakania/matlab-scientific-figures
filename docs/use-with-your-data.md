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
