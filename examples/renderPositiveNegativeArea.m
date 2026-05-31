function [files, report] = renderPositiveNegativeArea(outputDir, formats)
data = sftExampleData('positive_negative_area');
theme = sftTheme('FigureSize', [14 8]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotPositiveNegativeArea(ax, data.x, data.y, data.baseline, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'positive_negative_area'), formats);
end
