function [files, report] = renderRibbonComparison(outputDir, formats)
%RENDERRIBBONCOMPARISON Render a clean-room 3D ribbon comparison.

if nargin < 2 || isempty(formats)
    formats = ["png", "svg"];
end

data = sftExampleData('ribbon_comparison');
theme = sftTheme('FigureSize', [14 9]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
[xGrid, yGrid] = meshgrid(data.x, 1:numel(data.series));
surf(ax, xGrid, yGrid, data.z, data.z, ...
    'EdgeColor', [1 1 1] * 0.82, ...
    'LineWidth', 0.25, ...
    'FaceAlpha', 0.94);
colormap(ax, sftPalette('sequential', 128));
view(ax, [-38 24]);
grid(ax, 'on');
xlabel(ax, 'Time');
ylabel(ax, 'Series');
zlabel(ax, 'Response');
title(ax, 'Synthetic 3D Ribbon Comparison');
set(ax, 'YTick', 1:numel(data.series), 'YTickLabel', cellstr(data.series));
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'ribbon_comparison'), formats);
end
