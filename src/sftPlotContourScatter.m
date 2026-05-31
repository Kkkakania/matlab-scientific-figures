function [ax, filledContourHandle, pointHandle, lineContourHandle, density] = sftPlotContourScatter(ax, x, y, bins, theme)
%SFTPLOTCONTOURSCATTER Draw a density contour map with overlaid scatter points.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(x) || isempty(y)
    error('sft:InvalidData', 'X and Y vectors are required.');
end
if ~isnumeric(x) || ~isnumeric(y)
    error('sft:InvalidData', 'X and Y must be numeric arrays.');
end
if nargin < 4 || isempty(bins)
    bins = 34;
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [12 8]);
end

x = x(:);
y = y(:);
if numel(x) ~= numel(y) || isempty(x)
    error('sft:InvalidData', 'X and Y must be nonempty vectors with the same length.');
end
if any(~isfinite(x)) || any(~isfinite(y))
    error('sft:InvalidData', 'X and Y values must be finite.');
end
if ~isscalar(bins) || ~isnumeric(bins) || bins < 4 || bins ~= floor(bins)
    error('sft:InvalidBins', 'Bins must be an integer scalar of at least 4.');
end

xPadding = robustPadding(x, 0.08);
yPadding = robustPadding(y, 0.08);
xEdges = linspace(min(x) - xPadding, max(x) + xPadding, bins);
yEdges = linspace(min(y) - yPadding, max(y) + yPadding, bins);
density = histcounts2(x, y, xEdges, yEdges);
density = smoothDensity(density);
xCenters = binCenters(xEdges);
yCenters = binCenters(yEdges);

wasHold = ishold(ax);
hold(ax, 'on');
filledContourHandle = contourf(ax, xCenters, yCenters, density.', 8, ...
    'LineColor', 'none');
pointHandle = scatter(ax, x, y, 13, [0.08 0.18 0.28], 'filled', ...
    'MarkerFaceAlpha', 0.24, ...
    'MarkerEdgeAlpha', 0.10);
lineContourHandle = contour(ax, xCenters, yCenters, density.', 6, ...
    'LineColor', [0.08 0.18 0.28], ...
    'LineWidth', 0.7);
if ~wasHold
    hold(ax, 'off');
end

colormap(ax, sftPalette('sequential', 64));
cb = colorbar(ax);
cb.Label.String = 'Local density';
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;

xlabel(ax, 'Feature X');
ylabel(ax, 'Feature Y');
title(ax, 'Contour Scatter');
grid(ax, 'on');
sftApplyTheme(ax, theme);
end

function centers = binCenters(edges)
centers = (edges(1:end - 1) + edges(2:end)) / 2;
end

function density = smoothDensity(density)
kernel = [1 2 1; 2 4 2; 1 2 1] / 16;
density = conv2(density, kernel, 'same');
end

function padding = robustPadding(values, fraction)
valueRange = range(values);
if valueRange == 0
    valueRange = max(abs(values(1)), 1);
end
padding = fraction * valueRange;
end
