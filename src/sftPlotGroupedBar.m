function [ax, barHandles] = sftPlotGroupedBar(ax, values, groupLabels, seriesLabels, theme)
%SFTPLOTGROUPEDBAR Draw grouped bars for scenario or method comparison.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(values) || isempty(groupLabels) || isempty(seriesLabels)
    error('sft:InvalidData', 'Values, group labels, and series labels are required.');
end
if ~isnumeric(values) || ~ismatrix(values) || isempty(values)
    error('sft:InvalidData', 'Values must be a nonempty numeric matrix.');
end
if any(~isfinite(values), 'all')
    error('sft:InvalidData', 'Values must be finite.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [14 9]);
end

groupLabels = string(groupLabels(:));
seriesLabels = string(seriesLabels(:));
if numel(groupLabels) ~= size(values, 1)
    error('sft:InvalidLabels', 'Group labels must match the number of value rows.');
end
if numel(seriesLabels) ~= size(values, 2)
    error('sft:InvalidLabels', 'Series labels must match the number of value columns.');
end

colors = sftPalette('main', numel(seriesLabels));
barHandles = bar(ax, values, 'grouped', 'EdgeColor', 'none');
for k = 1:numel(barHandles)
    barHandles(k).FaceColor = colors(k, :);
end

set(ax, 'XTick', 1:numel(groupLabels), 'XTickLabel', groupLabels);
grid(ax, 'on');
xlabel(ax, 'Scenario');
ylabel(ax, 'Score');
title(ax, 'Grouped Bar Chart');
legendHandle = legend(ax, barHandles, cellstr(seriesLabels), ...
    'Location', 'northoutside', ...
    'Orientation', 'horizontal');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
