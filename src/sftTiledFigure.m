function [fig, layout] = sftTiledFigure(rows, cols, options)
%SFTTILEDFIGURE Create a themed figure with a compact tiled layout.

arguments
    rows (1, 1) double {mustBeInteger, mustBePositive}
    cols (1, 1) double {mustBeInteger, mustBePositive}
    options.Theme struct = sftTheme()
    options.Visible {mustBeTextScalar} = "off"
    options.FigureSize (1, 2) double = [16 10]
    options.TileSpacing {mustBeTextScalar} = "compact"
    options.Padding {mustBeTextScalar} = "compact"
end

theme = options.Theme;
fig = figure( ...
    'Visible', char(options.Visible), ...
    'Color', theme.BackgroundColor, ...
    'Units', 'centimeters', ...
    'Position', [1 1 options.FigureSize]);

layout = tiledlayout(fig, rows, cols, ...
    'TileSpacing', char(options.TileSpacing), ...
    'Padding', char(options.Padding));
end
