function [ax, cellHandles, legendHandles] = sftPlotWaffleChart(ax, counts, labels, theme)
%SFTPLOTWAFFLECHART Draw a 100-cell composition chart.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(counts) || isempty(labels)
    error('sft:InvalidData', 'Counts and labels are required.');
end
if ~isnumeric(counts)
    error('sft:InvalidData', 'Counts must be numeric.');
end
if nargin < 4 || isempty(theme)
    theme = sftTheme();
end

counts = counts(:).';
labels = string(labels(:)).';
if numel(labels) ~= numel(counts)
    error('sft:InvalidData', 'Labels must match the number of counts.');
end
if any(~isfinite(counts)) || any(counts < 0) || any(mod(counts, 1) ~= 0)
    error('sft:InvalidData', 'Counts must be finite nonnegative integers.');
end

gridSize = 10;
cellCount = gridSize * gridSize;
if sum(counts) ~= cellCount
    error('sft:InvalidData', 'Waffle counts must sum to %d.', cellCount);
end

categoryIndex = repelem(1:numel(counts), counts);
colors = sftPalette('main', numel(counts));
wasHold = ishold(ax);
hold(ax, 'on');
cellHandles = gobjects(cellCount, 1);
for idx = 1:cellCount
    row = ceil(idx / gridSize);
    col = mod(idx - 1, gridSize) + 1;
    color = colors(categoryIndex(idx), :);
    cellHandles(idx) = rectangle(ax, 'Position', [col - 0.43, row - 0.43, 0.82, 0.82], ...
        'Curvature', 0.12, ...
        'FaceColor', color, ...
        'EdgeColor', [1 1 1], ...
        'LineWidth', 0.8);
end

legendHandles = gobjects(numel(labels), 1);
legendLabels = strings(numel(labels), 1);
for k = 1:numel(labels)
    legendHandles(k) = plot(ax, nan, nan, 's', ...
        'MarkerSize', 9, ...
        'MarkerFaceColor', colors(k, :), ...
        'MarkerEdgeColor', 'none');
    legendLabels(k) = sprintf('%s (%d%%)', labels(k), counts(k));
end
if ~wasHold
    hold(ax, 'off');
end

axis(ax, 'equal');
xlim(ax, [0.45 gridSize + 0.55]);
ylim(ax, [0.45 gridSize + 0.55]);
set(ax, 'YDir', 'reverse', 'XTick', [], 'YTick', []);
grid(ax, 'off');
xlabel(ax, '100 cells');
ylabel(ax, 'Composition');
title(ax, 'Waffle Chart');
legendHandle = legend(ax, legendHandles, legendLabels, 'Location', 'eastoutside');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
