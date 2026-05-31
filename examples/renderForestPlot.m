function [files, report] = renderForestPlot(outputDir, formats)
data = sftExampleData('forest_plot');
theme = sftTheme('FigureSize', [13.5 8.5]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotForest(ax, data.estimate, data.lower, data.upper, data.labels, data.reference, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'forest_plot'), formats);
end
