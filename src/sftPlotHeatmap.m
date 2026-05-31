function ax = sftPlotHeatmap(ax, matrix, labels, theme)
%SFTPLOTHEATMAP Draw a themed matrix heatmap into an axes.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 2 || isempty(matrix) || ~isnumeric(matrix) || ~ismatrix(matrix)
    error('sft:InvalidMatrix', 'Matrix must be a nonempty numeric 2-D array.');
end
if nargin < 3 || isempty(labels)
    labels = string(1:size(matrix, 2));
end
if nargin < 4 || isempty(theme)
    theme = sftTheme();
end

labels = string(labels(:));
if size(matrix, 1) ~= size(matrix, 2) || numel(labels) ~= size(matrix, 2)
    error('sft:InvalidLabels', ...
        'Heatmap labels must match both dimensions of a square matrix.');
end

imagesc(ax, matrix);
axis(ax, 'equal', 'tight');
colormap(ax, sftPalette('sequential', 128));

cb = colorbar(ax);
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;

set(ax, ...
    'XTick', 1:numel(labels), ...
    'XTickLabel', labels, ...
    'YTick', 1:numel(labels), ...
    'YTickLabel', labels);
xtickangle(ax, 45);
xlabel(ax, 'Feature');
ylabel(ax, 'Feature');
title(ax, 'Matrix Heatmap');
sftApplyTheme(ax, theme);
end
