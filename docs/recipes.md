# Recipes

Small edits people usually make after they copy an example.

## Change The Output Size

```matlab
theme = sftTheme('FigureSize', [12 7]);
fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
```

Use centimeters when the figure is going into a paper. It keeps the result
easier to reason about than screen pixels.

## Save PNG And SVG Together

```matlab
files = sftExport(gcf, fullfile('outputs', 'my_figure'), ["png", "svg"]);
```

PNG is convenient for quick review. SVG is better when the figure needs to stay
sharp in slides, docs, or web pages.

## Render One Example Only

When you are adapting one chart type, call its renderer directly instead of
running the whole gallery.

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));

renderButterflyComparison('gallery', ["png", "svg"]);
renderZoomedInsetLine('gallery', ["png", "svg"]);
```

Every renderer uses the same two arguments:

- output folder
- export formats

Use `runAllExamples` when you want to rebuild the public gallery. Use a direct
renderer call when you are iterating on one figure.

## Use The Same Colors Across Figures

```matlab
colors = sftPalette('main', 3);
plot(x, y1, 'Color', colors(1, :));
plot(x, y2, 'Color', colors(2, :));
plot(x, y3, 'Color', colors(3, :));
```

Do this when several figures appear in the same report. Readers notice when the
same method changes color from page to page.

## Make A 2 By 2 Figure

```matlab
[fig, layout] = sftTiledFigure(2, 2);

nexttile(layout);
plot(x, y);
title('Trend');
xlabel('Time');
ylabel('Value');
sftApplyTheme(gca);

sftExport(fig, fullfile('outputs', 'four_panel'), ["png", "svg"]);
close(fig);
```

Start with `examples/renderMultiPanelOverview.m` if you want a complete working
file.

## Check Before Export

```matlab
report = sftValidateFigure(gcf);
if ~report.Passed
    disp(struct2table(report.Checks));
end
```

This catches boring mistakes: missing labels, tiny figures, non-white
backgrounds, and unreadable tick text.

## Rebuild And Check The Gallery

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/validate_gallery.sh
```

Run these before changing gallery images in a pull request.
