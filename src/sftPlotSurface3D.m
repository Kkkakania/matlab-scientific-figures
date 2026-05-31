function [ax, surfaceHandle, colorbarHandle] = sftPlotSurface3D(ax, x, y, z, theme)
%SFTPLOTSURFACE3D Draw a smooth themed 3D response surface.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(x) || isempty(y) || isempty(z)
    error('sft:InvalidData', 'X, Y, and Z grids are required.');
end
if ~isnumeric(x) || ~isnumeric(y) || ~isnumeric(z)
    error('sft:InvalidData', 'X, Y, and Z must be numeric arrays.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [13 10]);
end
if ~isequal(size(x), size(y), size(z)) || ~ismatrix(z)
    error('sft:InvalidData', 'X, Y, and Z must be matrices with the same size.');
end
if any(~isfinite(x), 'all') || any(~isfinite(y), 'all') || any(~isfinite(z), 'all')
    error('sft:InvalidData', 'X, Y, and Z values must be finite.');
end

surfaceHandle = surf(ax, x, y, z, 'EdgeColor', 'none');
shading(ax, 'interp');
colormap(ax, sftPalette('sequential', 128));
colorbarHandle = colorbar(ax);
colorbarHandle.Color = theme.AxisColor;
colorbarHandle.FontName = theme.FontName;
colorbarHandle.FontSize = theme.FontSize;
view(ax, 42, 28);
xlabel(ax, 'X');
ylabel(ax, 'Y');
zlabel(ax, 'Z');
title(ax, '3D Surface');
sftApplyTheme(ax, theme);
end
