function [ax, pointHandle, colorbarHandle] = sftPlotBubbleMatrix(ax, matrix, rowLabels, colLabels, theme)
%SFTPLOTBUBBLEMATRIX Draw matrix magnitudes with bubble area and color.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(matrix) || isempty(rowLabels) || isempty(colLabels)
    error('sft:InvalidData', 'Matrix, row labels, and column labels are required.');
end
if ~isnumeric(matrix) || ~ismatrix(matrix)
    error('sft:InvalidData', 'Matrix must be a numeric 2-D array.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [12 10]);
end

rowLabels = string(rowLabels(:));
colLabels = string(colLabels(:)).';
if numel(rowLabels) ~= size(matrix, 1)
    error('sft:InvalidLabels', 'Row labels must match the matrix rows.');
end
if numel(colLabels) ~= size(matrix, 2)
    error('sft:InvalidLabels', 'Column labels must match the matrix columns.');
end
if any(~isfinite(matrix(:))) || any(matrix(:) < 0)
    error('sft:InvalidData', 'Matrix values must be finite nonnegative values.');
end

[rowCount, colCount] = size(matrix);
[xx, yy] = meshgrid(1:colCount, 1:rowCount);
values = matrix(:);
maxValue = max(values);
if maxValue == 0
    scaledValues = zeros(size(values));
else
    scaledValues = values ./ maxValue;
end

pointHandle = scatter(ax, xx(:), yy(:), 50 + 520 * scaledValues, values, 'filled', ...
    'MarkerFaceAlpha', 0.82, ...
    'MarkerEdgeColor', [1 1 1] * 0.98);
axis(ax, 'equal');
xlim(ax, [0 colCount + 1]);
ylim(ax, [0 rowCount + 1]);
set(ax, ...
    'YDir', 'reverse', ...
    'XTick', 1:colCount, ...
    'XTickLabel', colLabels, ...
    'YTick', 1:rowCount, ...
    'YTickLabel', rowLabels);
colormap(ax, sftPalette('sequential', 128));
colorLimits = [min(values) max(values)];
if colorLimits(1) == colorLimits(2)
    colorLimits = colorLimits + [-0.5 0.5];
end
set(ax, 'CLim', colorLimits);
colorbarHandle = colorbar(ax);
colorbarHandle.Color = theme.AxisColor;
colorbarHandle.FontName = theme.FontName;
colorbarHandle.FontSize = theme.FontSize;
grid(ax, 'on');
xlabel(ax, 'Column');
ylabel(ax, 'Row');
title(ax, 'Bubble Matrix');
sftApplyTheme(ax, theme);
end
