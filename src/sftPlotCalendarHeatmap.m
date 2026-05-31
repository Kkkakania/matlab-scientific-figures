function [ax, imageHandle, colorbarHandle] = sftPlotCalendarHeatmap(ax, values, weekLabels, dayLabels, theme)
%SFTPLOTCALENDARHEATMAP Draw daily values in a day-by-week heatmap.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(values) || isempty(weekLabels) || isempty(dayLabels)
    error('sft:InvalidData', 'Values, week labels, and day labels are required.');
end
if ~isnumeric(values) || ~ismatrix(values)
    error('sft:InvalidData', 'Values must be a numeric matrix.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [13.5 7.5], 'FontSize', 9);
end

weekLabels = string(weekLabels(:)).';
dayLabels = string(dayLabels(:));
if numel(dayLabels) ~= size(values, 1)
    error('sft:InvalidLabels', 'Day labels must match the value rows.');
end
if numel(weekLabels) ~= size(values, 2)
    error('sft:InvalidLabels', 'Week labels must match the value columns.');
end
if any(~isfinite(values(:)))
    error('sft:InvalidData', 'Values must be finite.');
end

imageHandle = imagesc(ax, values);
axis(ax, 'equal', 'tight');
colormap(ax, sftPalette('sequential', 128));
colorLimits = [min(values(:)) max(values(:))];
if colorLimits(1) == colorLimits(2)
    colorLimits = colorLimits + [-0.5 0.5];
end
set(ax, 'CLim', colorLimits);
colorbarHandle = colorbar(ax);
colorbarHandle.Label.String = 'Daily value';
colorbarHandle.Color = theme.AxisColor;
colorbarHandle.FontName = theme.FontName;
colorbarHandle.FontSize = theme.FontSize;
colorbarHandle.Label.Color = theme.AxisColor;
set(ax, ...
    'XTick', 1:numel(weekLabels), ...
    'XTickLabel', weekLabels, ...
    'YTick', 1:numel(dayLabels), ...
    'YTickLabel', dayLabels, ...
    'YDir', 'reverse', ...
    'TickLength', [0 0]);
grid(ax, 'on');
xlabel(ax, 'Week');
ylabel(ax, 'Day');
title(ax, 'Calendar Heatmap');
sftApplyTheme(ax, theme);
set(ax, 'GridColor', [1 1 1], 'GridAlpha', 0.72, 'Layer', 'top');
end
