function [files, report] = renderGroupedErrorBar(outputDir, formats)
data = sftExampleData('grouped_error_bar');
theme = sftTheme('FigureSize', [13 8.5]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotGroupedErrorBar(ax, data.values, data.errors, data.groups, data.series, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'grouped_error_bar'), formats);
end
