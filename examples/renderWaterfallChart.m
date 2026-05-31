function [files, report] = renderWaterfallChart(outputDir, formats)
data = sftExampleData('waterfall_chart');
theme = sftTheme('FigureSize', [13.5 8.5]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotWaterfallChart(ax, data.start, data.steps, data.labels, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'waterfall_chart'), formats);
end
