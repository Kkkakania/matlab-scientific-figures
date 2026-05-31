function [files, report] = renderTernaryScatter(outputDir, formats)
data = sftExampleData('ternary_scatter');
theme = sftTheme('FigureSize', [12 10]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
compositions = [data.table.A, data.table.B, data.table.C];
sftPlotTernaryScatter(ax, compositions, data.table.Group, data.componentLabels, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'ternary_scatter'), formats);
end
