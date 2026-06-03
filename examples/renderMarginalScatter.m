function [files, report] = renderMarginalScatter(outputDir, formats)
%RENDERMARGINALSCATTER Render a scatter plot with marginal distributions.

if nargin < 2 || isempty(formats)
    formats = ["png", "svg"];
end

data = sftExampleData('marginal_scatter');
theme = sftTheme('FigureSize', [13 11]);
fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize], 'Color', 'w');

mainAx = axes(fig, 'Position', [0.16 0.15 0.62 0.58]);
topAx = axes(fig, 'Position', [0.16 0.77 0.62 0.15]);
rightAx = axes(fig, 'Position', [0.82 0.15 0.13 0.58]);

scatter(mainAx, data.x, data.y, 22, sftPalette('main', 1), 'filled', ...
    'MarkerFaceAlpha', 0.72, 'MarkerEdgeColor', 'none');
grid(mainAx, 'on');
xlabel(mainAx, data.xLabel);
ylabel(mainAx, data.yLabel);
title(mainAx, 'Synthetic Relationship With Marginals');
sftApplyTheme(mainAx, theme);

palette = sftPalette('sequential', 5);
histogram(topAx, data.x, 22, 'FaceColor', palette(3, :), 'EdgeColor', 'none');
set(topAx, 'XTickLabel', [], 'YTick', [], 'Box', 'off');
title(topAx, 'X distribution');
sftApplyTheme(topAx, theme);

histogram(rightAx, data.y, 22, 'Orientation', 'horizontal', ...
    'FaceColor', palette(5, :), 'EdgeColor', 'none');
set(rightAx, 'YTickLabel', [], 'XTick', [], 'Box', 'off');
title(rightAx, 'Y');
sftApplyTheme(rightAx, theme);

files = sftExport(fig, fullfile(outputDir, 'marginal_scatter'), formats);
report = sftValidateFigure(fig, 'RequireAxisLabels', false);
close(fig);
end
