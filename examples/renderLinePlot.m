function [files, report] = renderLinePlot(outputDir, formats)
data = sftExampleData('line');
theme = sftTheme();

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotLineSeries(ax, data.x, data.y, data.labels, theme);
xlabel(ax, 'Time');
ylabel(ax, 'Response');
title(ax, 'Line Plot');
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'line_plot'), formats);
end
