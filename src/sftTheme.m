function theme = sftTheme(varargin)
%SFTTHEME Return shared style settings for scientific figures.
%
%   theme = SFTTHEME() returns a struct with stable defaults for figures,
%   axes, fonts, lines, grid styling, and export size.

p = inputParser;
p.FunctionName = 'sftTheme';
addParameter(p, 'FontName', 'Arial', @(x) ischar(x) || isstring(x));
addParameter(p, 'FontSize', 10, @(x) isnumeric(x) && isscalar(x) && x > 0);
addParameter(p, 'LineWidth', 1.4, @(x) isnumeric(x) && isscalar(x) && x > 0);
addParameter(p, 'MarkerSize', 42, @(x) isnumeric(x) && isscalar(x) && x > 0);
addParameter(p, 'FigureSize', [14 9], @(x) isnumeric(x) && numel(x) == 2 && all(x > 0));
addParameter(p, 'BackgroundColor', [1 1 1], @(x) isnumeric(x) && numel(x) == 3);
addParameter(p, 'AxisColor', [0.12 0.12 0.12], @(x) isnumeric(x) && numel(x) == 3);
addParameter(p, 'GridColor', [0.86 0.86 0.86], @(x) isnumeric(x) && numel(x) == 3);
addParameter(p, 'ApplyDefaults', false, @(x) islogical(x) && isscalar(x));
parse(p, varargin{:});

theme = p.Results;
theme.FontName = char(theme.FontName);
theme.FigureSize = double(theme.FigureSize(:).');
theme.BackgroundColor = double(theme.BackgroundColor(:).');
theme.AxisColor = double(theme.AxisColor(:).');
theme.GridColor = double(theme.GridColor(:).');

if theme.ApplyDefaults
    set(groot, ...
        'defaultFigureColor', theme.BackgroundColor, ...
        'defaultAxesFontName', theme.FontName, ...
        'defaultAxesFontSize', theme.FontSize, ...
        'defaultAxesLineWidth', theme.LineWidth, ...
        'defaultLineLineWidth', theme.LineWidth);
end
end
