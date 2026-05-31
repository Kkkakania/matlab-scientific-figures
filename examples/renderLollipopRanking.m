function [files, report] = renderLollipopRanking(outputDir, formats)
data = sftExampleData('lollipop');
theme = sftTheme('FigureSize', [13 9]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotLollipopRanking(ax, data.labels, data.values, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'lollipop_ranking'), formats);
end
