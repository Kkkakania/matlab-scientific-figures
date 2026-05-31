function [ax, lineHandles, pointHandles, labelHandles, order] = sftPlotPairedSlopegraph(ax, before, after, labels, conditionLabels, theme)
%SFTPLOTPAIREDSLOPEGRAPH Draw paired before-after changes for matched items.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(before) || isempty(after) || isempty(labels)
    error('sft:InvalidData', 'Before values, after values, and labels are required.');
end
if ~isnumeric(before) || ~isnumeric(after)
    error('sft:InvalidData', 'Before and after values must be numeric.');
end
if nargin < 5 || isempty(conditionLabels)
    conditionLabels = ["Before", "After"];
end
if nargin < 6 || isempty(theme)
    theme = sftTheme('FigureSize', [16 9.2], 'FontSize', 8);
end

before = before(:);
after = after(:);
labels = string(labels(:));
conditionLabels = string(conditionLabels(:));
if numel(before) ~= numel(after) || numel(before) ~= numel(labels)
    error('sft:InvalidData', 'Before values, after values, and labels must have the same length.');
end
if numel(conditionLabels) ~= 2
    error('sft:InvalidLabels', 'Condition labels must contain exactly two labels.');
end
if any(~isfinite(before)) || any(~isfinite(after))
    error('sft:InvalidData', 'Before and after values must be finite.');
end

[before, order] = sort(before, 'ascend');
after = after(order);
labels = labels(order);
delta = after - before;
valueLimits = [min([before; after]) - 0.08, max([before; after]) + 0.09];
leftTextY = spreadSlopeTextPositions(before, 0.046, valueLimits(1), valueLimits(2));
rightTextY = spreadSlopeTextPositions(after, 0.046, valueLimits(1), valueLimits(2));
colors = sftPalette('contrast', 2);

wasHold = ishold(ax);
hold(ax, 'on');
lineHandles = gobjects(numel(labels), 1);
pointHandles = gobjects(numel(labels), 1);
labelHandles = gobjects(numel(labels) * 2, 1);
for k = 1:numel(labels)
    color = colors(1, :);
    if delta(k) < 0
        color = colors(2, :);
    end
    lineHandles(k) = plot(ax, [1 2], [before(k) after(k)], '-', ...
        'Color', color, ...
        'LineWidth', theme.LineWidth + 0.2);
    pointHandles(k) = scatter(ax, [1 2], [before(k) after(k)], 46, color, ...
        'filled', ...
        'MarkerEdgeColor', 'w', ...
        'LineWidth', 0.8);
    labelHandles(k) = text(ax, 0.86, leftTextY(k), sprintf('%s  %.2f', labels(k), before(k)), ...
        'HorizontalAlignment', 'right', ...
        'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, ...
        'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
    labelHandles(numel(labels) + k) = text(ax, 2.14, rightTextY(k), sprintf('%.2f', after(k)), ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, ...
        'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end

increaseHandle = plot(ax, nan, nan, '-', ...
    'Color', colors(1, :), ...
    'LineWidth', theme.LineWidth + 0.2);
decreaseHandle = plot(ax, nan, nan, '-', ...
    'Color', colors(2, :), ...
    'LineWidth', theme.LineWidth + 0.2);
if ~wasHold
    hold(ax, 'off');
end

xlim(ax, [0.05 2.62]);
ylim(ax, valueLimits);
set(ax, 'XTick', [1 2], 'XTickLabel', conditionLabels);
grid(ax, 'on');
xlabel(ax, 'Condition');
ylabel(ax, 'Score');
title(ax, 'Paired Slopegraph');
sftApplyTheme(ax, theme);
legendHandle = legend(ax, [increaseHandle, decreaseHandle], ...
    ["Increase", "Decrease"], ...
    'Location', 'southoutside', ...
    'Orientation', 'horizontal');
sftStyleLegend(legendHandle, theme);
end

function adjusted = spreadSlopeTextPositions(values, minGap, lowerLimit, upperLimit)
[sortedValues, order] = sort(values(:), 'ascend');
adjustedSorted = sortedValues;

for k = 2:numel(adjustedSorted)
    if adjustedSorted(k) - adjustedSorted(k - 1) < minGap
        adjustedSorted(k) = adjustedSorted(k - 1) + minGap;
    end
end

overflow = adjustedSorted(end) - upperLimit;
if overflow > 0
    adjustedSorted = adjustedSorted - overflow;
end

for k = numel(adjustedSorted) - 1:-1:1
    if adjustedSorted(k + 1) - adjustedSorted(k) < minGap
        adjustedSorted(k) = adjustedSorted(k + 1) - minGap;
    end
end

underflow = lowerLimit - adjustedSorted(1);
if underflow > 0
    adjustedSorted = adjustedSorted + underflow;
end

adjusted = zeros(size(values(:)));
adjusted(order) = adjustedSorted;
end
