# Tutorial: Export Figures For Papers

For papers, keep one source figure and export more than one format:

- `svg` for editable vector graphics.
- `pdf` for LaTeX and many journal workflows.
- `png` for README previews, slides, and quick review.

## Export One Figure

```matlab
addpath(genpath('src'));

fig = figure('Color', 'w', 'Units', 'centimeters', 'Position', [1 1 12 7]);
plot(1:10, cumsum(randn(1, 10)), 'LineWidth', 1.5);
grid on
xlabel('Sample');
ylabel('Response');
title('Paper Figure Draft');

report = sftValidateFigure(fig);
if ~report.Passed
    disp(struct2table(report.Checks));
    error('Figure did not pass the local quality checks.');
end

sftExport(fig, 'paper/figure_01', ["png", "pdf", "svg"]);
```

## Export The Whole Gallery

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
runAllExamples('gallery', ["png", "pdf", "svg"]);
```

From a shell:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh
```

## Size And Font Rules

Use centimeters for figure size when the target is a paper. It is easier to
match journal column widths:

```matlab
theme = sftTheme('FigureSize', [8.5 6.2], 'FontSize', 8.5);
```

Common starting points:

| Target | Suggested size | Font |
|---|---:|---:|
| Single column | `[8.5 6.2]` cm | 8 to 9 pt |
| Double column | `[17.5 8.5]` cm | 9 to 10 pt |
| Half-page report | `[14 8]` cm | 10 pt |
| Slide or screen | `[16 9]` cm | 10 to 12 pt |

Copyable presets:

```matlab
singleColumn = sftTheme('FigureSize', [8.5 6.2], 'FontSize', 8.5);
doubleColumn = sftTheme('FigureSize', [17.5 8.5], 'FontSize', 9.5);
reportFigure = sftTheme('FigureSize', [14 8], 'FontSize', 10);
slideFigure = sftTheme('FigureSize', [16 9], 'FontSize', 11);
```

These are starting points, not journal rules. Always check the target journal
or conference instructions before final submission.

## Before Submission

- Open the SVG or PDF once before sending it.
- Check that text is selectable in vector exports when possible.
- Avoid transparent backgrounds unless the target system requires them.
- Keep the MATLAB script that generated the final figure next to the exported file.
- If a journal asks for TIFF, export PNG first and convert from the final figure, not from a screenshot.
