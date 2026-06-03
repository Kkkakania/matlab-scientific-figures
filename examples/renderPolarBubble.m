function [files, report] = renderPolarBubble(outputDir, formats)
%RENDERPOLARBUBBLE Render a clean-room polar bubble example on Cartesian axes.

if nargin < 2 || isempty(formats)
    formats = ["png", "svg"];
end

data = sftExampleData('polar_bubble');
theme = sftTheme('FigureSize', [12 12]);
theta = deg2rad(90 - data.thetaDegrees);
x = data.radius .* cos(theta);
y = data.radius .* sin(theta);
sizes = 45 + 180 * data.sizeValue ./ max(data.sizeValue);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
hold(ax, 'on');
circleTheta = linspace(0, 2 * pi, 240);
for radius = 0.25:0.25:1.0
    plot(ax, radius * cos(circleTheta), radius * sin(circleTheta), ...
        'Color', [0.87 0.89 0.91], 'LineWidth', 0.55);
end
scatter(ax, x, y, sizes, data.sizeValue, 'filled', ...
    'MarkerFaceAlpha', 0.76, 'MarkerEdgeColor', [1 1 1] * 0.98);
hold(ax, 'off');

axis(ax, 'equal');
xlim(ax, [-1.08 1.08]);
ylim(ax, [-1.08 1.08]);
colormap(ax, sftPalette('sequential', 128));
cb = colorbar(ax);
cb.Label.String = 'Magnitude';
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
set(ax, 'XTick', [], 'YTick', [], 'Box', 'off');
xlabel(ax, 'East-West component');
ylabel(ax, 'North-South component');
title(ax, 'Synthetic Polar Bubble Map');
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'polar_bubble'), formats);
end
