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

Example:

```matlab
theme = sftTheme("FigureSize", [12 10]);
fig = figure("Visible", "off", "Units", "centimeters", "Position", [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotHeatmap(ax, corr(randn(80, 5)), ["A", "B", "C", "D", "E"], theme);
sftExport(fig, "gallery/my_heatmap", ["png", "svg"]);
close(fig);
```

## Maintainer-Oriented Helpers

| Function | Use When |
|---|---|
| `sftTemplateRegistry()` | Maintain the source of truth for public template metadata. |
| `sftExampleData(kind)` | Generate deterministic synthetic data for examples. |
| `sftFinalizeFigure(fig, outputBase, formats)` | Validate, export, and close an example figure. |

Most users can ignore these helpers unless they are adding a new template.
