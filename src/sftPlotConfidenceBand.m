function [ax, lineHandles, bandHandles] = sftPlotConfidenceBand(ax, x, center, lower, upper, labels, theme)
%SFTPLOTCONFIDENCEBAND Draw themed line series with uncertainty bands.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 5 || isempty(x) || isempty(center) || isempty(lower) || isempty(upper)
    error('sft:InvalidData', 'X, center, lower, and upper data are required.');
end
if ~isnumeric(x) || ~isnumeric(center) || ~isnumeric(lower) || ~isnumeric(upper)
    error('sft:InvalidData', 'X, center, lower, and upper must be numeric.');
end
if nargin < 6 || isempty(labels)
    labels = "Series " + string(1:size(center, 1));
end
if nargin < 7 || isempty(theme)
    theme = sftTheme();
end

x = x(:).';
if isvector(center)
    center = center(:).';
end
if isvector(lower)
    lower = lower(:).';
end
if isvector(upper)
    upper = upper(:).';
end
labels = string(labels(:));
if ~isequal(size(center), size(lower), size(upper)) || size(center, 2) ~= numel(x)
    error('sft:InvalidData', 'Center, lower, and upper must match and align with X.');
end
if any(lower(:) > upper(:))
    error('sft:InvalidData', 'Lower bounds must not exceed upper bounds.');
end
if numel(labels) ~= size(center, 1)
    error('sft:InvalidLabels', 'Labels must match the number of center rows.');
end

colors = sftPalette('main', size(center, 1));
wasHold = ishold(ax);
hold(ax, 'on');
lineHandles = gobjects(size(center, 1), 1);
bandHandles = gobjects(size(center, 1), 1);
for k = 1:size(center, 1)
    xPatch = [x, fliplr(x)];
    yPatch = [lower(k, :), fliplr(upper(k, :))];
    bandHandles(k) = fill(ax, xPatch, yPatch, colors(k, :), ...
        'FaceAlpha', 0.18, ...
        'EdgeColor', 'none', ...
        'HandleVisibility', 'off');
    lineHandles(k) = plot(ax, x, center(k, :), ...
        'Color', colors(k, :), ...
        'LineWidth', theme.LineWidth + 0.3);
end
if ~wasHold
    hold(ax, 'off');
end

grid(ax, 'on');
legendHandle = legend(ax, lineHandles, cellstr(labels), 'Location', 'best');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
end
