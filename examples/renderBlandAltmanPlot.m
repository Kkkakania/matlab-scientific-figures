function [files, report] = renderBlandAltmanPlot(outputDir, formats)
data = sftExampleData('bland_altman_plot');
theme = sftTheme('FigureSize', [13.5 9]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotBlandAltman(ax, data.methodA, data.methodB, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'bland_altman_plot'), formats);
end
