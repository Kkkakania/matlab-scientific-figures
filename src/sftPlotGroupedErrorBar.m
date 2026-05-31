function [ax, barHandles, errorHandles] = sftPlotGroupedErrorBar(ax, values, errors, groupLabels, seriesLabels, theme)
%SFTPLOTGROUPEDERRORBAR Draw grouped bars with matching error bars.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 5 || isempty(values) || isempty(errors) || isempty(groupLabels) || isempty(seriesLabels)
    error('sft:InvalidData', 'Values, errors, group labels, and series labels are required.');
end
if ~isnumeric(values) || ~isnumeric(errors) || ~ismatrix(values) || ~ismatrix(errors)
    error('sft:InvalidData', 'Values and errors must be numeric matrices.');
end
if nargin < 6 || isempty(theme)
    theme = sftTheme();
end
if ~isequal(size(values), size(errors))
    error('sft:InvalidData', 'Values and errors must have the same size.');
end
if any(errors(:) < 0)
    error('sft:InvalidData', 'Errors must be nonnegative.');
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
hold(ax, 'on');
errorHandles = gobjects(numel(barHandles), 1);
for k = 1:numel(barHandles)
    barHandles(k).FaceColor = colors(k, :);
    errorHandles(k) = errorbar(ax, barHandles(k).XEndPoints, values(:, k), errors(:, k), ...
        'k', 'LineStyle', 'none', 'LineWidth', 0.9, 'CapSize', 7);
end
hold(ax, 'off');

set(ax, 'XTick', 1:numel(groupLabels), 'XTickLabel', groupLabels);
xtickangle(ax, 15);
ylim(ax, [0 max(values(:) + errors(:)) * 1.16]);
grid(ax, 'on');
xlabel(ax, 'Method');
ylabel(ax, 'Score');
title(ax, 'Grouped Bar With Error Bars');
legendHandle = legend(ax, barHandles, cellstr(seriesLabels), ...
    'Location', 'northoutside', ...
    'Orientation', 'horizontal');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
