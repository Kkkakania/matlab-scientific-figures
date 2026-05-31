function [files, report] = renderZoomedInsetLine(outputDir, formats)
data = sftExampleData('zoomed_inset_line');
theme = sftTheme('FigureSize', [14 9.3]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
sftPlotZoomedInsetLine(fig, data.x, data.y, data.zoomRange, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'zoomed_inset_line'), formats);
end
