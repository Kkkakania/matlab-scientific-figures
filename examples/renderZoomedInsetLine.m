function [files, report] = renderZoomedInsetLine(outputDir, formats)
data = sftExampleData('zoomed_inset_line');
theme = sftTheme('FigureSize', [14 9.3]);
colors = sftPalette('contrast', 3);

x = data.x(:).';
y = data.y(:).';
zoomRange = data.zoomRange;
inZoom = x >= zoomRange(1) & x <= zoomRange(2);
yPad = 0.12 * range(y);
if yPad == 0
    yPad = 0.1;
end

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
mainAx = axes(fig, 'Position', [0.09 0.12 0.82 0.66]);
hold(mainAx, 'on');

highlightY = [min(y) - yPad, max(y) + yPad];
patch(mainAx, ...
    [zoomRange(1) zoomRange(2) zoomRange(2) zoomRange(1)], ...
    [highlightY(1) highlightY(1) highlightY(2) highlightY(2)], ...
    colors(2, :), ...
    'FaceAlpha', 0.13, ...
    'EdgeColor', 'none', ...
    'HandleVisibility', 'off');
hFull = plot(mainAx, x, y, 'Color', colors(1, :), 'LineWidth', theme.LineWidth + 0.2);
hZoom = plot(mainAx, x(inZoom), y(inZoom), 'Color', colors(2, :), ...
    'LineWidth', theme.LineWidth + 0.9);

xlim(mainAx, [min(x) max(x)]);
ylim(mainAx, highlightY);
grid(mainAx, 'on');
xlabel(mainAx, 'Time');
ylabel(mainAx, 'Response');
title(mainAx, 'Zoomed Inset Line');
sftStyleLegend(legend(mainAx, [hFull, hZoom], ["Full signal", "Zoom window"], ...
    'Location', 'northwest'), theme);
sftApplyTheme(mainAx, theme);
set(mainAx.Title, 'FontSize', theme.FontSize + 1);

insetAx = axes(fig, 'Position', [0.59 0.47 0.28 0.27]);
hold(insetAx, 'on');
plot(insetAx, x(inZoom), y(inZoom), 'Color', colors(2, :), ...
    'LineWidth', theme.LineWidth + 0.5);
scatter(insetAx, x(inZoom), y(inZoom), 16, colors(2, :), ...
    'filled', 'MarkerFaceAlpha', 0.55, 'MarkerEdgeColor', 'none');
xlim(insetAx, zoomRange);
ylim(insetAx, [min(y(inZoom)) - yPad / 2, max(y(inZoom)) + yPad / 2]);
grid(insetAx, 'on');
xlabel(insetAx, 'Time');
ylabel(insetAx, 'Y');
title(insetAx, 'Detail');
sftApplyTheme(insetAx, theme);
set(insetAx, 'FontSize', theme.FontSize - 2, 'Box', 'on');
set([insetAx.Title, insetAx.XLabel, insetAx.YLabel], 'FontSize', theme.FontSize - 1);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'zoomed_inset_line'), formats);
end
