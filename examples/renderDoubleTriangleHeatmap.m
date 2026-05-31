function [files, report] = renderDoubleTriangleHeatmap(outputDir, formats)
data = sftExampleData('double_triangle_heatmap');
theme = sftTheme('FigureSize', [13 11]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotDoubleTriangleHeatmap(ax, data.upper, data.lower, data.labels, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'double_triangle_heatmap'), formats);
end
