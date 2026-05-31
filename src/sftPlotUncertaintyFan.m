function [ax, outerBand, innerBand, medianLine] = sftPlotUncertaintyFan(ax, x, medianValue, p10, p25, p75, p90, theme)
%SFTPLOTUNCERTAINTYFAN Draw nested uncertainty bands around a median trend.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 7 || isempty(x) || isempty(medianValue) || isempty(p10) || isempty(p25) || isempty(p75) || isempty(p90)
    error('sft:InvalidData', 'X, median, and percentile vectors are required.');
end
if ~isnumeric(x) || ~isnumeric(medianValue) || ~isnumeric(p10) || ~isnumeric(p25) ...
        || ~isnumeric(p75) || ~isnumeric(p90)
    error('sft:InvalidData', 'Fan chart inputs must be numeric.');
end
if nargin < 8 || isempty(theme)
    theme = sftTheme('FigureSize', [14 8.5]);
end

x = x(:).';
medianValue = medianValue(:).';
p10 = p10(:).';
p25 = p25(:).';
p75 = p75(:).';
p90 = p90(:).';
inputLengths = [numel(x), numel(medianValue), numel(p10), numel(p25), numel(p75), numel(p90)];
if numel(unique(inputLengths)) ~= 1 || isempty(x)
    error('sft:InvalidData', 'All fan chart vectors must be nonempty and have the same length.');
end
allValues = [x, medianValue, p10, p25, p75, p90];
if any(~isfinite(allValues))
    error('sft:InvalidData', 'Fan chart inputs must be finite.');
end
if any(diff(x) <= 0)
    error('sft:InvalidData', 'X values must be strictly increasing.');
end
if any(p10 > p25 | p25 > medianValue | medianValue > p75 | p75 > p90)
    error('sft:InvalidData', 'Percentile vectors must satisfy p10 <= p25 <= median <= p75 <= p90.');
end

colors = sftPalette('main', 1);
bandColor = colors(1, :);
wasHold = ishold(ax);
hold(ax, 'on');
outerBand = fill(ax, [x fliplr(x)], [p10 fliplr(p90)], bandColor, ...
    'FaceAlpha', 0.16, ...
    'EdgeColor', 'none');
innerBand = fill(ax, [x fliplr(x)], [p25 fliplr(p75)], bandColor, ...
    'FaceAlpha', 0.32, ...
    'EdgeColor', 'none');
medianLine = plot(ax, x, medianValue, ...
    'Color', bandColor * 0.72, ...
    'LineWidth', theme.LineWidth + 0.4);
if ~wasHold
    hold(ax, 'off');
end

grid(ax, 'on');
xlabel(ax, 'Forecast horizon');
ylabel(ax, 'Response');
title(ax, 'Uncertainty Fan Chart');
legendHandle = legend(ax, [outerBand, innerBand, medianLine], ...
    ["10-90% band", "25-75% band", "Median"], ...
    'Location', 'northwest');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
