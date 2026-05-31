function [files, report] = renderGroupedBar(outputDir, formats)
data = sftExampleData('grouped_bar');
theme = sftTheme('FigureSize', [14 9]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotGroupedBar(ax, data.values, data.groups, data.series, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'grouped_bar'), formats);
end
