function [ax, barHandles, connectorHandles, labelHandles] = sftPlotWaterfallChart(ax, startValue, steps, stepLabels, theme)
%SFTPLOTWATERFALLCHART Draw cumulative contribution steps.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(startValue) || isempty(steps) || isempty(stepLabels)
    error('sft:InvalidData', 'Start value, steps, and step labels are required.');
end
if ~isnumeric(startValue) || ~isscalar(startValue) || ~isnumeric(steps)
    error('sft:InvalidData', 'Start value and steps must be numeric.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme();
end

steps = steps(:).';
stepLabels = string(stepLabels(:)).';
if numel(stepLabels) ~= numel(steps)
    error('sft:InvalidData', 'Step labels must match the number of steps.');
end
if ~isfinite(startValue) || any(~isfinite(steps))
    error('sft:InvalidData', 'Start value and steps must be finite.');
end

colors = sftPalette('contrast', 3);
before = startValue + [0 cumsum(steps(1:end - 1))];
after = startValue + cumsum(steps);
finalValue = startValue + sum(steps);
labels = ["Start", stepLabels, "Final"];
x = 1:numel(labels);
barWidth = 0.62;

wasHold = ishold(ax);
hold(ax, 'on');
barHandles = gobjects(numel(labels), 1);
connectorHandles = gobjects(numel(steps), 1);
labelHandles = gobjects(numel(labels), 1);

barHandles(1) = drawFloatingBar(ax, x(1), 0, startValue, barWidth, colors(1, :));
for k = 1:numel(steps)
    barColor = colors(2, :);
    if steps(k) < 0
        barColor = colors(3, :);
    end
    barHandles(k + 1) = drawFloatingBar(ax, x(k + 1), before(k), after(k), barWidth, barColor);
    connectorHandles(k) = plot(ax, [x(k) + barWidth / 2, x(k + 1) - barWidth / 2], ...
        [before(k), before(k)], '-', 'Color', [0.65 0.65 0.65], ...
        'LineWidth', 0.8, 'HandleVisibility', 'off');
end
barHandles(end) = drawFloatingBar(ax, x(end), 0, finalValue, barWidth, colors(1, :));

valuesForLabels = [startValue steps finalValue];
labelBase = [startValue max(before, after) finalValue];
labelOffset = 0.035 * max(1, range([0 startValue before after finalValue]));
for k = 1:numel(x)
    if k == 1 || k == numel(x)
        labelText = sprintf('%g', valuesForLabels(k));
    else
        labelText = sprintf('%+g', valuesForLabels(k));
    end
    labelHandles(k) = text(ax, x(k), labelBase(k) + labelOffset, labelText, ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
        'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end
if ~wasHold
    hold(ax, 'off');
end

yMax = max([0 startValue after finalValue]);
yMin = min([0 startValue before after finalValue]);
ySpan = yMax - yMin;
if ySpan == 0
    ySpan = max(1, abs(yMax));
end

xlim(ax, [0.35 numel(labels) + 0.65]);
ylim(ax, [yMin - 0.06 * ySpan, yMax + 0.18 * ySpan]);
set(ax, 'XTick', x, 'XTickLabel', labels);
xtickangle(ax, 30);
grid(ax, 'on');
xlabel(ax, 'Contribution step');
ylabel(ax, 'Cumulative value');
title(ax, 'Waterfall Chart');
sftApplyTheme(ax, theme);
end

function rectangleHandle = drawFloatingBar(ax, x, y0, y1, width, color)
bottom = min(y0, y1);
height = abs(y1 - y0);
rectangleHandle = rectangle(ax, 'Position', [x - width / 2, bottom, width, height], ...
    'FaceColor', color, 'EdgeColor', 'none');
end
