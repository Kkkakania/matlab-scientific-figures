function [files, report] = renderPvPowerConfidence(outputDir, formats)
%RENDERPVPOWERCONFIDENCE Render a synthetic PV power forecast example.

data = sftExampleData('pv_power');
theme = sftTheme('FigureSize', [15 9]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotConfidenceBand(ax, data.hours, data.center, data.lower, data.upper, data.labels, theme);
xlabel(ax, 'Hour of day');
ylabel(ax, 'Normalized power');
title(ax, 'Synthetic PV Power Forecast With Uncertainty');
ylim(ax, [0 1.08]);
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'pv_power_confidence'), formats);
end
