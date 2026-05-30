function [files, report] = renderRadarChart(outputDir, formats)
data = sftExampleData('radar');
theme = sftTheme('FigureSize', [12 9]);
colors = sftPalette('contrast', size(data.values, 1));

metrics = data.metrics;
values = data.values;
series = data.series;
n = numel(metrics);
theta = linspace(0, 2 * pi, n + 1);
theta(end) = [];
theta = pi / 2 - theta;

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on

for ring = 0.25:0.25:1
    [xRing, yRing] = polarToCartesian(ring * ones(1, n), theta);
    plot([xRing xRing(1)], [yRing yRing(1)], ...
        'Color', theme.GridColor, 'LineWidth', 0.8, 'HandleVisibility', 'off');
end

for k = 1:n
    [xSpoke, ySpoke] = polarToCartesian([0 1], [theta(k) theta(k)]);
    plot(xSpoke, ySpoke, 'Color', theme.GridColor, ...
        'LineWidth', 0.8, 'HandleVisibility', 'off');
    [xText, yText] = polarToCartesian(1.12, theta(k));
    text(xText, yText, metrics(k), ...
        'HorizontalAlignment', alignmentForAngle(theta(k)), ...
        'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, ...
        'FontSize', theme.FontSize, ...
        'Color', theme.AxisColor);
end

handles = gobjects(size(values, 1), 1);
for row = 1:size(values, 1)
    rowValues = values(row, :);
    [x, y] = polarToCartesian(rowValues, theta);
    patch([x x(1)], [y y(1)], colors(row, :), ...
        'FaceAlpha', 0.16, ...
        'EdgeColor', colors(row, :), ...
        'LineWidth', theme.LineWidth + 0.4, ...
        'HandleVisibility', 'off');
    handles(row) = plot([x x(1)], [y y(1)], '-o', ...
        'Color', colors(row, :), ...
        'MarkerFaceColor', colors(row, :), ...
        'MarkerSize', 4, ...
        'LineWidth', theme.LineWidth + 0.4);
end

axis equal
xlim([-1.24 1.24]);
ylim([-1.18 1.22]);
set(gca, 'XTick', [], 'YTick', []);
xlabel('Normalized score');
ylabel('Normalized score');
title('Radar Chart');
sftStyleLegend(legend(handles, series, 'Location', 'southoutside', ...
    'Orientation', 'horizontal'), theme);
sftApplyTheme(gca, theme);
ax = gca;
set(ax, 'XColor', 'none', 'YColor', 'none', 'Box', 'off');
set([ax.XLabel, ax.YLabel], 'Visible', 'off');
set(ax.Title, 'Visible', 'on');

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'radar_chart'), formats);
end

function [x, y] = polarToCartesian(radius, theta)
x = radius .* cos(theta);
y = radius .* sin(theta);
end

function align = alignmentForAngle(theta)
if cos(theta) > 0.25
    align = 'left';
elseif cos(theta) < -0.25
    align = 'right';
else
    align = 'center';
end
end
