function [ax, upperHandles, lowerHandles, colorbarHandle] = sftPlotDoubleTriangleHeatmap(ax, upperValues, lowerValues, labels, theme)
%SFTPLOTDOUBLETRIANGLEHEATMAP Compare two square matrices in one layout.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(upperValues) || isempty(lowerValues) || isempty(labels)
    error('sft:InvalidData', 'Upper values, lower values, and labels are required.');
end
if ~isnumeric(upperValues) || ~isnumeric(lowerValues) || ~ismatrix(upperValues) || ~ismatrix(lowerValues)
    error('sft:InvalidData', 'Upper and lower values must be numeric matrices.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [13 11]);
end

labels = string(labels(:));
if ~isequal(size(upperValues), size(lowerValues)) || size(upperValues, 1) ~= size(upperValues, 2)
    error('sft:InvalidData', 'Upper and lower values must be same-size square matrices.');
end
n = size(upperValues, 1);
if numel(labels) ~= n
    error('sft:InvalidLabels', 'Labels must match the matrix dimensions.');
end
if any(~isfinite(upperValues(:))) || any(~isfinite(lowerValues(:)))
    error('sft:InvalidData', 'Upper and lower values must be finite.');
end

wasHold = ishold(ax);
hold(ax, 'on');
upperHandles = gobjects(n, n);
lowerHandles = gobjects(n, n);
for row = 1:n
    for col = 1:n
        upperHandles(row, col) = drawCellTriangle(ax, row, col, upperValues(row, col), "upper");
        lowerHandles(row, col) = drawCellTriangle(ax, row, col, lowerValues(row, col), "lower");
    end
end
if ~wasHold
    hold(ax, 'off');
end

axis(ax, 'equal');
xlim(ax, [0.5 n + 0.5]);
ylim(ax, [0.5 n + 0.5]);
set(ax, ...
    'YDir', 'reverse', ...
    'XTick', 1:n, ...
    'XTickLabel', labels, ...
    'YTick', 1:n, ...
    'YTickLabel', labels, ...
    'Layer', 'top');
xtickangle(ax, 45);
box(ax, 'on');
grid(ax, 'off');

colormap(ax, sftPalette('diverging', 256));
limit = max(abs([upperValues(:); lowerValues(:)]));
if limit == 0
    limit = 1;
end
set(ax, 'CLim', [-limit limit]);
colorbarHandle = colorbar(ax);
colorbarHandle.Color = theme.AxisColor;
colorbarHandle.FontName = theme.FontName;
colorbarHandle.FontSize = theme.FontSize;
colorbarHandle.Label.String = 'Value';
colorbarHandle.Label.FontName = theme.FontName;
colorbarHandle.Label.Color = theme.AxisColor;

xlabel(ax, 'Metric');
ylabel(ax, 'Metric');
title(ax, {'Double-Triangle Heatmap'; 'Upper: condition A | Lower: condition B'});
sftApplyTheme(ax, theme);
set(ax.Title, 'FontSize', theme.FontSize + 1);
end

function triangleHandle = drawCellTriangle(ax, row, col, value, half)
left = col - 0.5;
right = col + 0.5;
top = row - 0.5;
bottom = row + 0.5;

if half == "upper"
    x = [left right right];
    y = [top top bottom];
else
    x = [left left right];
    y = [top bottom bottom];
end

triangleHandle = patch(ax, x, y, value, ...
    'FaceColor', 'flat', ...
    'EdgeColor', [1 1 1], ...
    'LineWidth', 0.35);
end
