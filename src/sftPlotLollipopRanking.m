function [ax, lineHandles, pointHandles, order] = sftPlotLollipopRanking(ax, labels, values, theme)
%SFTPLOTLOLLIPOPRANKING Draw a sorted lollipop ranking chart.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(labels) || isempty(values)
    error('sft:InvalidData', 'Labels and values are required.');
end
if ~isnumeric(values)
    error('sft:InvalidData', 'Values must be numeric.');
end
if nargin < 4 || isempty(theme)
    theme = sftTheme();
end

labels = string(labels(:));
values = values(:);
if numel(labels) ~= numel(values)
    error('sft:InvalidData', 'Labels and values must have the same number of elements.');
end
if any(~isfinite(values))
    error('sft:InvalidData', 'Values must be finite.');
end

[sortedValues, order] = sort(values, 'ascend');
sortedLabels = labels(order);
colors = sftPalette('contrast', numel(sortedValues));
colors = colors(order, :);
y = 1:numel(sortedValues);
wasHold = ishold(ax);
hold(ax, 'on');
lineHandles = gobjects(numel(sortedValues), 1);
pointHandles = gobjects(numel(sortedValues), 1);
baseline = min(0, min(sortedValues));

for k = 1:numel(sortedValues)
    lineHandles(k) = plot(ax, [baseline sortedValues(k)], [y(k) y(k)], '-', ...
        'Color', [0.72 0.72 0.72], ...
        'LineWidth', theme.LineWidth);
    pointHandles(k) = scatter(ax, sortedValues(k), y(k), 80, colors(k, :), ...
        'filled', ...
        'MarkerEdgeColor', 'none');
end
if ~wasHold
    hold(ax, 'off');
end

grid(ax, 'on');
valueSpan = max(sortedValues) - baseline;
if valueSpan == 0
    valueSpan = max(1, abs(baseline));
end
xlim(ax, [baseline max(sortedValues) + 0.04 * valueSpan]);
set(ax, 'YTick', y, 'YTickLabel', sortedLabels);
xlabel(ax, 'Relative score');
ylabel(ax, 'Factor');
title(ax, 'Lollipop Ranking');
sftApplyTheme(ax, theme);
end
