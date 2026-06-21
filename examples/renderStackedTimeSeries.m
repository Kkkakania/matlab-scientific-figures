function [files, report] = renderStackedTimeSeries(outputDir, formats)
data = sftExampleData('stacked_time_series');
theme = sftTheme('FigureSize', [14 10], 'FontSize', 8.8);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
sftPlotStackedTimeSeries(fig, data.time, data.values, data.labels, data.units, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'stacked_time_series'), formats);
end
