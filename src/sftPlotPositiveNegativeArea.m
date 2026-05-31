function [ax, positivePatch, negativePatch, signalHandle, baselineHandle] = sftPlotPositiveNegativeArea(ax, x, y, baseline, theme)
%SFTPLOTPOSITIVENEGATIVEAREA Draw signed deviations around a baseline.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(x) || isempty(y)
    error('sft:InvalidData', 'X and Y values are required.');
end
if ~isnumeric(x) || ~isnumeric(y)
    error('sft:InvalidData', 'X and Y values must be numeric.');
end
if nargin < 4 || isempty(baseline)
    baseline = 0;
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [14 8]);
end

x = x(:).';
y = y(:).';
if isscalar(baseline)
    baseline = repmat(baseline, size(y));
else
    baseline = baseline(:).';
end
if numel(x) ~= numel(y) || numel(y) ~= numel(baseline)
    error('sft:InvalidData', 'X, Y, and baseline must have compatible lengths.');
end
if any(~isfinite(x)) || any(~isfinite(y)) || any(~isfinite(baseline))
    error('sft:InvalidData', 'X, Y, and baseline values must be finite.');
end

colors = sftPalette('contrast', 2);
positive = max(y, baseline);
negative = min(y, baseline);

wasHold = ishold(ax);
hold(ax, 'on');
positivePatch = fill(ax, [x fliplr(x)], [positive fliplr(baseline)], colors(2, :), ...
    'FaceAlpha', 0.78, ...
    'EdgeColor', 'none');
negativePatch = fill(ax, [x fliplr(x)], [negative fliplr(baseline)], colors(1, :), ...
    'FaceAlpha', 0.78, ...
    'EdgeColor', 'none');
signalHandle = plot(ax, x, y, ...
    'Color', theme.AxisColor, ...
    'LineWidth', theme.LineWidth);
baselineHandle = plot(ax, x, baseline, '-', ...
    'Color', [0.35 0.35 0.35], ...
    'LineWidth', 0.8, ...
    'HandleVisibility', 'off');
if ~wasHold
    hold(ax, 'off');
end

grid(ax, 'on');
xlabel(ax, 'Time');
ylabel(ax, 'Change from baseline');
title(ax, 'Positive-Negative Area');
legendHandle = legend(ax, [positivePatch, negativePatch, signalHandle], ...
    ["Positive", "Negative", "Signal"], ...
    'Location', 'northeast');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
