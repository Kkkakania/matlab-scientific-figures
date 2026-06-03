function [files, report] = renderVectorField(outputDir, formats)
%RENDERVECTORFIELD Render a synthetic vector-field example.

if nargin < 2 || isempty(formats)
    formats = ["png", "svg"];
end

data = sftExampleData('vector_field');
theme = sftTheme('FigureSize', [12 10]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
contourf(ax, data.x, data.y, data.speed, 12, 'LineColor', 'none');
hold(ax, 'on');
quiver(ax, data.x, data.y, data.u, data.v, 0.82, ...
    'Color', [0.12 0.15 0.18], ...
    'LineWidth', 0.7);
hold(ax, 'off');
axis(ax, 'equal', 'tight');
colormap(ax, sftPalette('sequential', 128));
cb = colorbar(ax);
cb.Label.String = 'Speed';
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
xlabel(ax, 'X coordinate');
ylabel(ax, 'Y coordinate');
title(ax, 'Synthetic Vector Field');
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'vector_field'), formats);
end
