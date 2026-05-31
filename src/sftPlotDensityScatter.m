function [ax, pointHandle, density] = sftPlotDensityScatter(ax, x, y, bins, theme)
%SFTPLOTDENSITYSCATTER Draw a density-colored x-y scatter plot.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(x) || isempty(y) || ~isnumeric(x) || ~isnumeric(y)
    error('sft:InvalidData', 'X and Y must be nonempty numeric arrays.');
end
if nargin < 4 || isempty(bins)
    bins = 36;
end
if nargin < 5 || isempty(theme)
    theme = sftTheme();
end
if ~isscalar(bins) || bins < 2 || bins ~= round(bins)
    error('sft:InvalidBins', 'Bins must be an integer scalar greater than 1.');
end

x = x(:);
y = y(:);
if numel(x) ~= numel(y)
    error('sft:InvalidData', 'X and Y must have the same number of elements.');
end

[counts, xedges, yedges] = histcounts2(x, y, bins);
xb = discretize(x, xedges);
yb = discretize(y, yedges);
valid = ~isnan(xb) & ~isnan(yb);
density = zeros(size(x));
density(valid) = counts(sub2ind(size(counts), xb(valid), yb(valid)));

pointHandle = scatter(ax, x, y, 22, density, ...
    'filled', ...
    'MarkerFaceAlpha', 0.78, ...
    'MarkerEdgeColor', 'none');
colormap(ax, sftPalette('sequential', 128));
cb = colorbar(ax);
cb.Label.String = 'Local density';
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
cb.Label.Color = theme.AxisColor;
grid(ax, 'on');
sftApplyTheme(ax, theme);
end
