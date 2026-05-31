function [files, report] = renderCalendarHeatmap(outputDir, formats)
data = sftExampleData('calendar_heatmap');
theme = sftTheme('FigureSize', [13.5 7.5], 'FontSize', 9);

values = data.table.Value;
dayCount = numel(data.dayLabels);
weekCount = numel(data.weekLabels);
gridValues = reshape(values, dayCount, weekCount);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotCalendarHeatmap(ax, gridValues, data.weekLabels, data.dayLabels, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'calendar_heatmap'), formats);
end
