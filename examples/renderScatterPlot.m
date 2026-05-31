function [files, report] = renderScatterPlot(outputDir, formats)
data = sftExampleData('scatter');
theme = sftTheme('FigureSize', [12 10]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotGroupedScatter(ax, data.x, data.y, data.group, theme);
xlabel(ax, 'Observed feature');
ylabel(ax, 'Predicted response');
title(ax, 'Grouped Scatter Plot');
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'scatter_plot'), formats);
end
