function [files, report] = renderCorrelationBubble(outputDir, formats)
data = sftExampleData('correlation_bubble');
theme = sftTheme('FigureSize', [13 11]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotCorrelationBubble(ax, data.matrix, data.labels, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'correlation_bubble'), formats);
end
