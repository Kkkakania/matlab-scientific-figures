function [files, report] = renderContourScatter(outputDir, formats)
data = sftExampleData('contour_scatter');
theme = sftTheme('FigureSize', [12 8]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotContourScatter(ax, data.x, data.y, 34, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'contour_scatter'), formats);
end
