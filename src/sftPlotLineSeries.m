function [ax, lineHandles] = sftPlotLineSeries(ax, x, y, labels, theme)
%SFTPLOTLINESERIES Draw themed line series into an axes.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(x) || isempty(y) || ~isnumeric(x) || ~isnumeric(y)
    error('sft:InvalidData', 'X and Y must be nonempty numeric arrays.');
end
if nargin < 4 || isempty(labels)
    labels = "Series " + string(1:size(y, 1));
end
if nargin < 5 || isempty(theme)
    theme = sftTheme();
end

x = x(:).';
if isvector(y)
    y = y(:).';
end
labels = string(labels(:));
if size(y, 2) ~= numel(x)
    error('sft:InvalidData', 'Each Y row must have the same length as X.');
end
if numel(labels) ~= size(y, 1)
    error('sft:InvalidLabels', 'Labels must match the number of Y rows.');
end

colors = sftPalette('main', size(y, 1));
wasHold = ishold(ax);
hold(ax, 'on');
lineHandles = gobjects(size(y, 1), 1);
for k = 1:size(y, 1)
    lineHandles(k) = plot(ax, x, y(k, :), ...
        'Color', colors(k, :), ...
        'LineWidth', theme.LineWidth);
end
if ~wasHold
    hold(ax, 'off');
end

grid(ax, 'on');
legendHandle = legend(ax, lineHandles, cellstr(labels), 'Location', 'best');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
