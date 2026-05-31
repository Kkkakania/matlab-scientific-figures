function [ax, pointHandle, textHandles] = sftPlotCorrelationBubble(ax, matrix, labels, theme)
%SFTPLOTCORRELATIONBUBBLE Draw a bubble heatmap for a correlation matrix.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 2 || isempty(matrix) || ~isnumeric(matrix) || ~ismatrix(matrix)
    error('sft:InvalidMatrix', 'Matrix must be a nonempty numeric 2-D array.');
end
if size(matrix, 1) ~= size(matrix, 2)
    error('sft:InvalidMatrix', 'Correlation bubble input must be a square matrix.');
end
if any(matrix(:) < -1) || any(matrix(:) > 1)
    error('sft:InvalidMatrix', 'Correlation values must be between -1 and 1.');
end
if nargin < 3 || isempty(labels)
    labels = string(1:size(matrix, 1));
end
if nargin < 4 || isempty(theme)
    theme = sftTheme();
end

labels = string(labels(:));
n = size(matrix, 1);
if numel(labels) ~= n
    error('sft:InvalidLabels', 'Labels must match the matrix dimensions.');
end

[xx, yy] = meshgrid(1:n, 1:n);
markerSizes = 60 + 620 * abs(matrix(:));
pointHandle = scatter(ax, xx(:), yy(:), markerSizes, matrix(:), 'filled', ...
    'MarkerFaceAlpha', 0.86, ...
    'MarkerEdgeColor', [0.98 0.98 0.98], ...
    'LineWidth', 0.5);

axis(ax, 'equal');
xlim(ax, [0.4 n + 0.6]);
ylim(ax, [0.4 n + 0.6]);
set(ax, ...
    'YDir', 'reverse', ...
    'XTick', 1:n, ...
    'XTickLabel', labels, ...
    'YTick', 1:n, ...
    'YTickLabel', labels, ...
    'CLim', [-1 1]);
xtickangle(ax, 45);
grid(ax, 'on');

colormap(ax, sftPalette('diverging', 256));
cb = colorbar(ax);
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
cb.Label.String = 'Correlation';
cb.Label.FontName = theme.FontName;
cb.Label.Color = theme.AxisColor;

strongMask = abs(matrix) >= 0.65;
textHandles = gobjects(nnz(strongMask), 1);
textIndex = 1;
for k = 1:numel(matrix)
    if strongMask(k)
        textHandles(textIndex) = text(ax, xx(k), yy(k), sprintf('%.2f', matrix(k)), ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontName', theme.FontName, ...
            'FontSize', theme.FontSize - 1, ...
            'Color', correlationBubbleTextColor(matrix(k)));
        textIndex = textIndex + 1;
    end
end

xlabel(ax, 'Variable');
ylabel(ax, 'Variable');
title(ax, 'Correlation Bubble Heatmap');
sftApplyTheme(ax, theme);
end

function color = correlationBubbleTextColor(value)
if abs(value) >= 0.82
    color = [1 1 1];
else
    color = [0.18 0.18 0.18];
end
end
