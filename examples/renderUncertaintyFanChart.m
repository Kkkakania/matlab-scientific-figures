function [files, report] = renderUncertaintyFanChart(outputDir, formats)
data = sftExampleData('uncertainty_fan_chart');
theme = sftTheme('FigureSize', [14 8.5]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotUncertaintyFan(ax, data.x, data.median, data.p10, data.p25, ...
    data.p75, data.p90, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'uncertainty_fan_chart'), formats);
end
