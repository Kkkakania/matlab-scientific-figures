function [layout, axesHandles, lineHandles] = sftPlotStackedTimeSeries(fig, time, values, labels, units, theme)
%SFTPLOTSTACKEDTIMESERIES Draw stacked signals that share one time axis.

if nargin < 1 || isempty(fig) || ~ishandle(fig)
    error('sft:InvalidFigure', 'A valid figure handle is required.');
end
if nargin < 3 || isempty(time) || isempty(values)
    error('sft:InvalidData', 'Time and values are required.');
end
if ~isnumeric(time) || ~isnumeric(values)
    error('sft:InvalidData', 'Time and values must be numeric.');
end
if nargin < 4 || isempty(labels)
    labels = "Signal " + string(1:size(values, 1));
end
if nargin < 5 || isempty(units)
    units = strings(1, size(values, 1));
end
if nargin < 6 || isempty(theme)
    theme = sftTheme('FigureSize', [14 10]);
end

time = time(:).';
if isvector(values)
    values = values(:).';
end
labels = string(labels(:));
units = string(units(:));

if isempty(time) || isempty(values) || size(values, 2) ~= numel(time)
    error('sft:InvalidData', 'Each value row must share the same length as time.');
end
if any(~isfinite(time)) || any(~isfinite(values(:)))
    error('sft:InvalidData', 'Time and values must be finite.');
end
if any(diff(time) <= 0)
    error('sft:InvalidData', 'Time values must be strictly increasing.');
end
if numel(labels) ~= size(values, 1)
    error('sft:InvalidLabels', 'Labels must match the number of value rows.');
end
if numel(units) ~= size(values, 1)
    error('sft:InvalidLabels', 'Units must match the number of value rows.');
end

seriesCount = size(values, 1);
colors = sftPalette('main', seriesCount);
layout = tiledlayout(fig, seriesCount, 1, ...
    'TileSpacing', 'compact', ...
    'Padding', 'compact');
title(layout, 'Stacked Time Series', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize + 2.5, ...
    'FontWeight', 'bold', ...
    'Color', theme.AxisColor);

axesHandles = gobjects(seriesCount, 1);
lineHandles = gobjects(seriesCount, 1);
for k = 1:seriesCount
    axesHandles(k) = nexttile(layout);
    lineHandles(k) = plot(axesHandles(k), time, values(k, :), ...
        'Color', colors(k, :), ...
        'LineWidth', theme.LineWidth + 0.1);
    grid(axesHandles(k), 'on');
    title(axesHandles(k), labels(k));
    xlabel(axesHandles(k), 'Time (s)');
    ylabel(axesHandles(k), axisLabel(labels(k), units(k)));
    xlim(axesHandles(k), [min(time) max(time)]);
    sftApplyTheme(axesHandles(k), theme);
    if k < seriesCount
        set(axesHandles(k), 'XTickLabel', []);
        set(axesHandles(k).XLabel, 'Visible', 'off');
    end
end

linkaxes(axesHandles, 'x');
end

function labelText = axisLabel(label, unit)
if strlength(unit) > 0
    labelText = char(label + " (" + unit + ")");
else
    labelText = char(label);
end
end
