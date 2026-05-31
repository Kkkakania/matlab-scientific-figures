function [files, report] = renderBubbleMatrix(outputDir, formats)
data = sftExampleData('bubble_matrix');
theme = sftTheme('FigureSize', [12 10]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotBubbleMatrix(ax, data.matrix, data.rows, data.cols, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'bubble_matrix'), formats);
end
