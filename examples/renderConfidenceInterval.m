function [files, report] = renderConfidenceInterval(outputDir, formats)
data = sftExampleData('confidence');
theme = sftTheme('FigureSize', [15 9]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotConfidenceBand(ax, data.x, data.center, data.lower, data.upper, data.labels, theme);
xlabel(ax, 'Input');
ylabel(ax, 'Estimate');
title(ax, 'Line Chart With Confidence Interval');
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'confidence_interval'), formats);
end
