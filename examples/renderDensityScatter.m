function [files, report] = renderDensityScatter(outputDir, formats)
data = sftExampleData('density_scatter');
theme = sftTheme('FigureSize', [12 10]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotDensityScatter(ax, data.x, data.y, 36, theme);
xlabel(ax, 'Variable X');
ylabel(ax, 'Variable Y');
title(ax, 'Density Scatter Plot');
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'density_scatter'), formats);
end
