function [files, report] = renderButterflyComparison(outputDir, formats)
data = sftExampleData('butterfly');
theme = sftTheme('FigureSize', [13 9.5]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotButterflyComparison(ax, data.left, data.right, data.labels, ...
    [data.leftLabel, data.rightLabel], theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'butterfly_comparison'), formats);
end
