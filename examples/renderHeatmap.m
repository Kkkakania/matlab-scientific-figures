function [files, report] = renderHeatmap(outputDir, formats)
data = sftExampleData('heatmap');
theme = sftTheme('FigureSize', [12 10]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotHeatmap(ax, data.matrix, data.labels, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'heatmap'), formats);
end
