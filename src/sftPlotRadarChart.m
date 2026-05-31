function [ax, lineHandles, patchHandles, labelHandles] = sftPlotRadarChart(ax, values, metrics, series, theme)
%SFTPLOTRADARCHART Draw normalized metric profiles as radar polygons.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(values) || isempty(metrics) || isempty(series)
    error('sft:InvalidData', 'Values, metrics, and series labels are required.');
end
if ~isnumeric(values) || ~ismatrix(values)
    error('sft:InvalidData', 'Values must be a numeric matrix.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [12 9]);
end

metrics = string(metrics(:)).';
series = string(series(:));
if numel(metrics) ~= size(values, 2)
    error('sft:InvalidLabels', 'Metric labels must match the value columns.');
end
if numel(series) ~= size(values, 1)
    error('sft:InvalidLabels', 'Series labels must match the value rows.');
end
if any(~isfinite(values(:))) || any(values(:) < 0) || any(values(:) > 1)
    error('sft:InvalidData', 'Radar values must be finite normalized values between 0 and 1.');
end

colors = sftPalette('contrast', size(values, 1));
n = numel(metrics);
theta = linspace(0, 2 * pi, n + 1);
theta(end) = [];
theta = pi / 2 - theta;

wasHold = ishold(ax);
hold(ax, 'on');
for ring = 0.25:0.25:1
    [xRing, yRing] = radarPolarToCartesian(ring * ones(1, n), theta);
    plot(ax, [xRing xRing(1)], [yRing yRing(1)], ...
        'Color', theme.GridColor, ...
        'LineWidth', 0.8, ...
        'HandleVisibility', 'off');
end

labelHandles = gobjects(n, 1);
for k = 1:n
    [xSpoke, ySpoke] = radarPolarToCartesian([0 1], [theta(k) theta(k)]);
    plot(ax, xSpoke, ySpoke, ...
        'Color', theme.GridColor, ...
        'LineWidth', 0.8, ...
        'HandleVisibility', 'off');
    [xText, yText] = radarPolarToCartesian(1.12, theta(k));
    labelHandles(k) = text(ax, xText, yText, metrics(k), ...
        'HorizontalAlignment', radarAlignmentForAngle(theta(k)), ...
        'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, ...
        'FontSize', theme.FontSize, ...
        'Color', theme.AxisColor);
end

lineHandles = gobjects(size(values, 1), 1);
patchHandles = gobjects(size(values, 1), 1);
for row = 1:size(values, 1)
    [x, y] = radarPolarToCartesian(values(row, :), theta);
    patchHandles(row) = patch(ax, [x x(1)], [y y(1)], colors(row, :), ...
        'FaceAlpha', 0.16, ...
        'EdgeColor', colors(row, :), ...
        'LineWidth', theme.LineWidth + 0.4, ...
        'HandleVisibility', 'off');
    lineHandles(row) = plot(ax, [x x(1)], [y y(1)], '-o', ...
        'Color', colors(row, :), ...
        'MarkerFaceColor', colors(row, :), ...
        'MarkerSize', 4, ...
        'LineWidth', theme.LineWidth + 0.4);
end
if ~wasHold
    hold(ax, 'off');
end

axis(ax, 'equal');
xlim(ax, [-1.24 1.24]);
ylim(ax, [-1.18 1.22]);
set(ax, 'XTick', [], 'YTick', [], 'XColor', 'none', 'YColor', 'none', 'Box', 'off');
xlabel(ax, 'Normalized score');
ylabel(ax, 'Normalized score');
title(ax, 'Radar Chart');
set([ax.XLabel, ax.YLabel], 'Visible', 'off');
set(ax.Title, 'Visible', 'on');
legendHandle = legend(ax, lineHandles, cellstr(series), ...
    'Location', 'southoutside', ...
    'Orientation', 'horizontal');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end

function [x, y] = radarPolarToCartesian(radius, theta)
x = radius .* cos(theta);
y = radius .* sin(theta);
end

function align = radarAlignmentForAngle(theta)
if cos(theta) > 0.25
    align = 'left';
elseif cos(theta) < -0.25
    align = 'right';
else
    align = 'center';
end
end
