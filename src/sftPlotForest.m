function [ax, pointHandles, intervalHandles, labelHandles] = sftPlotForest(ax, estimate, lower, upper, labels, reference, theme)
%SFTPLOTFOREST Draw a themed forest plot with intervals and estimates.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 5 || isempty(estimate) || isempty(lower) || isempty(upper) || isempty(labels)
    error('sft:InvalidData', 'Estimate, lower, upper, and labels are required.');
end
if ~isnumeric(estimate) || ~isnumeric(lower) || ~isnumeric(upper)
    error('sft:InvalidData', 'Estimate, lower, and upper must be numeric.');
end
if nargin < 6 || isempty(reference)
    reference = 0;
end
if nargin < 7 || isempty(theme)
    theme = sftTheme();
end
if ~isscalar(reference) || ~isnumeric(reference)
    error('sft:InvalidReference', 'Reference must be a numeric scalar.');
end

estimate = estimate(:);
lower = lower(:);
upper = upper(:);
labels = string(labels(:));
if numel(estimate) ~= numel(lower) || numel(estimate) ~= numel(upper) || numel(estimate) ~= numel(labels)
    error('sft:InvalidData', 'Estimate, lower, upper, and labels must have the same number of elements.');
end
if any(lower > estimate) || any(estimate > upper)
    error('sft:InvalidData', 'Intervals must satisfy lower <= estimate <= upper.');
end

colors = sftPalette('contrast', 2);
y = 1:numel(labels);
isAwayFromReference = lower > reference | upper < reference;
wasHold = ishold(ax);
hold(ax, 'on');
xline(ax, reference, '-', 'Color', [0.42 0.42 0.42], ...
    'LineWidth', 1.0, 'HandleVisibility', 'off');
pointHandles = gobjects(numel(labels), 1);
intervalHandles = gobjects(numel(labels), 1);
labelHandles = gobjects(numel(labels), 1);

for k = 1:numel(labels)
    color = colors(1, :);
    if ~isAwayFromReference(k)
        color = colors(2, :);
    end
    intervalHandles(k) = plot(ax, [lower(k) upper(k)], [y(k) y(k)], '-', ...
        'Color', color, 'LineWidth', theme.LineWidth + 0.4);
    pointHandles(k) = scatter(ax, estimate(k), y(k), 64, color, 'filled', ...
        'MarkerEdgeColor', 'w', 'LineWidth', 0.8);
    labelHandles(k) = text(ax, upper(k) + 0.035, y(k), sprintf('%.2f', estimate(k)), ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end
if ~wasHold
    hold(ax, 'off');
end

xlim(ax, [min(lower) - 0.08, max(upper) + 0.18]);
ylim(ax, [0.45 numel(labels) + 0.55]);
set(ax, 'YTick', y, 'YTickLabel', labels, 'YDir', 'reverse');
grid(ax, 'on');
xlabel(ax, 'Effect estimate');
ylabel(ax, 'Scenario');
title(ax, 'Forest Plot');
sftApplyTheme(ax, theme);
end
