function [files, report] = renderRadarChart(outputDir, formats)
data = sftExampleData('radar');
theme = sftTheme('FigureSize', [12 9]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotRadarChart(ax, data.values, data.metrics, data.series, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'radar_chart'), formats);
end
