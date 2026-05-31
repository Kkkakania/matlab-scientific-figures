function [files, report] = renderWaffleChart(outputDir, formats)
data = sftExampleData('waffle');
theme = sftTheme('FigureSize', [12 9]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotWaffleChart(ax, data.counts, data.labels, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'waffle_chart'), formats);
end
