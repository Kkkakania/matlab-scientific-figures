function [files, report] = renderParallelCoordinates(outputDir, formats)
data = sftExampleData('parallel_coordinates');
theme = sftTheme('FigureSize', [14 8]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotParallelCoordinates(ax, data.values, data.features, data.groups, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'parallel_coordinates'), formats);
end
