function [files, report] = renderPairedSlopegraph(outputDir, formats)
data = sftExampleData('paired_slopegraph');
theme = sftTheme('FigureSize', [16 9.2], 'FontSize', 8);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotPairedSlopegraph(ax, data.before, data.after, data.labels, ...
    [data.beforeLabel, data.afterLabel], theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'paired_slopegraph'), formats);
end
