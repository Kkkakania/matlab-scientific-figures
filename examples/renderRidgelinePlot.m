function [files, report] = renderRidgelinePlot(outputDir, formats)
data = sftExampleData('ridgeline');
theme = sftTheme('FigureSize', [13 8.5]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotRidgeline(ax, data.values, data.labels, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'ridgeline_plot'), formats);
end
