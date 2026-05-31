function [files, report] = renderBoxJitter(outputDir, formats)
data = sftExampleData('box_jitter');
theme = sftTheme('FigureSize', [12 9]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotBoxJitter(ax, data.group, data.value, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'box_jitter'), formats);
end
