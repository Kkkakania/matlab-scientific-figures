function [ax, sampleHandles, medianHandles] = sftPlotParallelCoordinates(ax, values, features, groups, theme)
%SFTPLOTPARALLELCOORDINATES Draw normalized multivariate profiles by group.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(values) || isempty(features) || isempty(groups)
    error('sft:InvalidData', 'Values, features, and groups are required.');
end
if ~isnumeric(values) || ~ismatrix(values)
    error('sft:InvalidData', 'Values must be a numeric matrix.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [14 8]);
end

features = string(features(:)).';
groups = string(groups(:));
if numel(features) ~= size(values, 2)
    error('sft:InvalidLabels', 'Feature labels must match the value columns.');
end
if numel(groups) ~= size(values, 1)
    error('sft:InvalidLabels', 'Groups must match the value rows.');
end
if any(~isfinite(values(:))) || any(values(:) < 0) || any(values(:) > 1)
    error('sft:InvalidData', 'Parallel coordinate values must be finite normalized values between 0 and 1.');
end

groupNames = unique(groups, 'stable');
colors = sftPalette('contrast', numel(groupNames));
x = 1:numel(features);

wasHold = ishold(ax);
hold(ax, 'on');
for k = 1:numel(features)
    plot(ax, [x(k) x(k)], [0 1], ...
        'Color', theme.GridColor, ...
        'LineWidth', 0.8, ...
        'HandleVisibility', 'off');
end

sampleHandles = gobjects(size(values, 1), 1);
medianHandles = gobjects(numel(groupNames), 1);
for groupIndex = 1:numel(groupNames)
    groupMask = groups == groupNames(groupIndex);
    lineColor = colors(groupIndex, :) * 0.72 + 0.28;
    sampleRows = find(groupMask).';
    for row = sampleRows
        sampleHandles(row) = plot(ax, x, values(row, :), '-', ...
            'Color', lineColor, ...
            'LineWidth', 0.7, ...
            'HandleVisibility', 'off');
    end

    medianValues = median(values(groupMask, :), 1);
    medianHandles(groupIndex) = plot(ax, x, medianValues, '-o', ...
        'Color', colors(groupIndex, :), ...
        'MarkerFaceColor', colors(groupIndex, :), ...
        'MarkerSize', 4.5, ...
        'LineWidth', theme.LineWidth + 0.6);
end
if ~wasHold
    hold(ax, 'off');
end

xlim(ax, [0.75 numel(features) + 0.25]);
ylim(ax, [0 1]);
set(ax, ...
    'XTick', x, ...
    'XTickLabel', features, ...
    'YTick', 0:0.25:1);
grid(ax, 'on');
xlabel(ax, 'Feature');
ylabel(ax, 'Normalized value');
title(ax, 'Parallel Coordinates');
legendHandle = legend(ax, medianHandles, cellstr(groupNames), ...
    'Location', 'southoutside', ...
    'Orientation', 'horizontal');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
