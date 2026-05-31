function [ax, leftBars, rightBars, labelHandles] = sftPlotButterflyComparison(ax, leftValues, rightValues, labels, sideLabels, theme)
%SFTPLOTBUTTERFLYCOMPARISON Draw mirrored horizontal bars around a shared baseline.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(leftValues) || isempty(rightValues) || isempty(labels)
    error('sft:InvalidData', 'Left values, right values, and labels are required.');
end
if ~isnumeric(leftValues) || ~isnumeric(rightValues)
    error('sft:InvalidData', 'Left and right values must be numeric.');
end
if nargin < 5 || isempty(sideLabels)
    sideLabels = ["Left", "Right"];
end
if nargin < 6 || isempty(theme)
    theme = sftTheme();
end

leftValues = leftValues(:);
rightValues = rightValues(:);
labels = string(labels(:));
sideLabels = string(sideLabels(:));
if numel(leftValues) ~= numel(rightValues) || numel(leftValues) ~= numel(labels)
    error('sft:InvalidData', 'Left values, right values, and labels must have the same length.');
end
if numel(sideLabels) ~= 2
    error('sft:InvalidLabels', 'Side labels must contain exactly two labels.');
end
if any(~isfinite(leftValues)) || any(~isfinite(rightValues)) || any(leftValues < 0) || any(rightValues < 0)
    error('sft:InvalidData', 'Left and right values must be finite nonnegative values.');
end

colors = sftPalette('contrast', 2);
y = 1:numel(labels);
mirroredLeft = -leftValues;
limit = max([leftValues; rightValues]);
if limit == 0
    limit = 1;
end
limit = limit * 1.18;

wasHold = ishold(ax);
hold(ax, 'on');
leftBars = barh(ax, y, mirroredLeft, 0.72, ...
    'FaceColor', colors(1, :), ...
    'EdgeColor', 'none');
rightBars = barh(ax, y, rightValues, 0.72, ...
    'FaceColor', colors(2, :), ...
    'EdgeColor', 'none');
xline(ax, 0, '-', 'Color', [0.28 0.28 0.28], ...
    'LineWidth', 1.0, 'HandleVisibility', 'off');

labelHandles = gobjects(numel(y) * 2, 1);
for k = 1:numel(y)
    labelHandles(k) = text(ax, mirroredLeft(k) - limit * 0.035, y(k), sprintf('%g', leftValues(k)), ...
        'HorizontalAlignment', 'right', ...
        'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, ...
        'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
    labelHandles(numel(y) + k) = text(ax, rightValues(k) + limit * 0.035, y(k), sprintf('%g', rightValues(k)), ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, ...
        'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end
if ~wasHold
    hold(ax, 'off');
end

tickStep = max(1, ceil(limit / 4));
tickValues = -tickStep * 4:tickStep:tickStep * 4;
xlim(ax, [-limit limit]);
ylim(ax, [0.35 numel(y) + 0.65]);
set(ax, ...
    'YTick', y, ...
    'YTickLabel', labels, ...
    'YDir', 'reverse', ...
    'XTick', tickValues, ...
    'XTickLabel', string(abs(tickValues)));
grid(ax, 'on');
xlabel(ax, 'Magnitude from shared baseline');
ylabel(ax, 'Group');
title(ax, 'Butterfly Comparison');
legendHandle = legend(ax, [leftBars, rightBars], cellstr(sideLabels), ...
    'Location', 'southoutside', ...
    'Orientation', 'horizontal');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
