function [mainAx, insetAx, handles] = sftPlotZoomedInsetLine(fig, x, y, zoomRange, theme)
%SFTPLOTZOOMEDINSETLINE Draw a full trend with a detailed inset window.

if nargin < 1 || isempty(fig) || ~ishandle(fig)
    error('sft:InvalidFigure', 'A valid figure handle is required.');
end
if nargin < 4 || isempty(x) || isempty(y) || isempty(zoomRange)
    error('sft:InvalidData', 'X, Y, and zoom range are required.');
end
if ~isnumeric(x) || ~isnumeric(y) || ~isnumeric(zoomRange)
    error('sft:InvalidData', 'X, Y, and zoom range must be numeric.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [14 9.3]);
end

x = x(:).';
y = y(:).';
zoomRange = zoomRange(:).';
if numel(x) ~= numel(y)
    error('sft:InvalidData', 'X and Y must have the same length.');
end
if numel(zoomRange) ~= 2 || zoomRange(1) >= zoomRange(2)
    error('sft:InvalidRange', 'Zoom range must contain two increasing values.');
end
if any(~isfinite(x)) || any(~isfinite(y)) || any(~isfinite(zoomRange))
    error('sft:InvalidData', 'X, Y, and zoom range values must be finite.');
end

inZoom = x >= zoomRange(1) & x <= zoomRange(2);
if ~any(inZoom)
    error('sft:InvalidRange', 'Zoom range must include at least one data point.');
end

colors = sftPalette('contrast', 3);
yPad = 0.12 * range(y);
if yPad == 0
    yPad = 0.1;
end
highlightY = [min(y) - yPad, max(y) + yPad];

mainAx = axes(fig, 'Position', [0.09 0.12 0.82 0.66]);
hold(mainAx, 'on');
handles.highlightPatch = patch(mainAx, ...
    [zoomRange(1) zoomRange(2) zoomRange(2) zoomRange(1)], ...
    [highlightY(1) highlightY(1) highlightY(2) highlightY(2)], ...
    colors(2, :), ...
    'FaceAlpha', 0.13, ...
    'EdgeColor', 'none', ...
    'HandleVisibility', 'off');
handles.fullLine = plot(mainAx, x, y, ...
    'Color', colors(1, :), ...
    'LineWidth', theme.LineWidth + 0.2);
handles.zoomLine = plot(mainAx, x(inZoom), y(inZoom), ...
    'Color', colors(2, :), ...
    'LineWidth', theme.LineWidth + 0.9);

xlim(mainAx, [min(x) max(x)]);
ylim(mainAx, highlightY);
grid(mainAx, 'on');
xlabel(mainAx, 'Time');
ylabel(mainAx, 'Response');
title(mainAx, 'Zoomed Inset Line');
legendHandle = legend(mainAx, [handles.fullLine, handles.zoomLine], ...
    ["Full signal", "Zoom window"], ...
    'Location', 'northwest');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(mainAx, theme);
set(mainAx.Title, 'FontSize', theme.FontSize + 1);

insetAx = axes(fig, 'Position', [0.59 0.47 0.28 0.27]);
hold(insetAx, 'on');
handles.insetLine = plot(insetAx, x(inZoom), y(inZoom), ...
    'Color', colors(2, :), ...
    'LineWidth', theme.LineWidth + 0.5);
handles.insetPoints = scatter(insetAx, x(inZoom), y(inZoom), 16, colors(2, :), ...
    'filled', ...
    'MarkerFaceAlpha', 0.55, ...
    'MarkerEdgeColor', 'none');
xlim(insetAx, zoomRange);
insetPad = yPad / 2;
if range(y(inZoom)) == 0
    insetPad = max(insetPad, 0.1);
end
ylim(insetAx, [min(y(inZoom)) - insetPad, max(y(inZoom)) + insetPad]);
grid(insetAx, 'on');
xlabel(insetAx, 'Time');
ylabel(insetAx, 'Y');
title(insetAx, 'Detail');
sftApplyTheme(insetAx, theme);
set(insetAx, 'FontSize', theme.FontSize - 2, 'Box', 'on');
set([insetAx.Title, insetAx.XLabel, insetAx.YLabel], 'FontSize', theme.FontSize - 1);
end
