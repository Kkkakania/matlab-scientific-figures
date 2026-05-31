function [ax, pointHandles] = sftPlotGroupedScatter(ax, x, y, groups, theme)
%SFTPLOTGROUPEDSCATTER Draw a themed grouped x-y scatter plot.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(x) || isempty(y) || isempty(groups)
    error('sft:InvalidData', 'X, Y, and groups are required.');
end
if ~isnumeric(x) || ~isnumeric(y)
    error('sft:InvalidData', 'X and Y must be numeric arrays.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme();
end

x = x(:);
y = y(:);
groups = categorical(groups(:));
if numel(x) ~= numel(y) || numel(x) ~= numel(groups)
    error('sft:InvalidData', 'X, Y, and groups must have the same number of elements.');
end

groupNames = categories(groups);
colors = sftPalette('main', numel(groupNames));
wasHold = ishold(ax);
hold(ax, 'on');
pointHandles = gobjects(numel(groupNames), 1);
for k = 1:numel(groupNames)
    mask = groups == groupNames{k};
    pointHandles(k) = scatter(ax, x(mask), y(mask), theme.MarkerSize, colors(k, :), ...
        'filled', ...
        'MarkerFaceAlpha', 0.72, ...
        'MarkerEdgeColor', 'none');
end
if ~wasHold
    hold(ax, 'off');
end

grid(ax, 'on');
legendHandle = legend(ax, pointHandles, groupNames, 'Location', 'best');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
