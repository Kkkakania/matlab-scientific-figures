function [theme, cleanup] = sftTheme(varargin)
%SFTTHEME Return shared style settings for scientific figures.
%
%   theme = SFTTHEME() returns a struct with stable defaults for figures,
%   axes, fonts, lines, grid styling, and export size.
%
%   [theme, cleanup] = SFTTHEME('ApplyDefaults', true) applies the theme to
%   MATLAB root graphics defaults and returns an onCleanup handle that
%   restores the previous values when it is cleared.

p = inputParser;
p.FunctionName = 'sftTheme';
addParameter(p, 'FontName', 'Arial', @(x) ischar(x) || isstring(x));
addParameter(p, 'FontMode', 'latin', @(x) any(strcmpi(string(x), ["latin", "cjk"])));
addParameter(p, 'CjkFontCandidates', defaultCjkFontCandidates(), ...
    @(x) ischar(x) || isstring(x) || iscellstr(x));
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
theme.FontMode = char(lower(string(theme.FontMode)));
theme.CjkFontCandidates = normalizeFontCandidates(theme.CjkFontCandidates);
theme.FontName = char(theme.FontName);
if strcmp(theme.FontMode, 'cjk') && any(strcmp(p.UsingDefaults, 'FontName'))
    theme.FontName = chooseAvailableFont(theme.CjkFontCandidates, theme.FontName);
end
theme.FigureSize = double(theme.FigureSize(:).');
theme.BackgroundColor = double(theme.BackgroundColor(:).');
theme.AxisColor = double(theme.AxisColor(:).');
theme.GridColor = double(theme.GridColor(:).');

cleanup = [];
if theme.ApplyDefaults
    snapshot = captureDefaultSnapshot();
    set(groot, ...
        'defaultFigureColor', theme.BackgroundColor, ...
        'defaultAxesFontName', theme.FontName, ...
        'defaultAxesFontSize', theme.FontSize, ...
        'defaultAxesLineWidth', theme.LineWidth, ...
        'defaultLineLineWidth', theme.LineWidth);
    if nargout > 1
        cleanup = onCleanup(@() restoreDefaultSnapshot(snapshot));
    end
end
end

function properties = themeDefaultProperties()
properties = { ...
    'defaultFigureColor', ...
    'defaultAxesFontName', ...
    'defaultAxesFontSize', ...
    'defaultAxesLineWidth', ...
    'defaultLineLineWidth'};
end

function snapshot = captureDefaultSnapshot()
properties = themeDefaultProperties();
snapshot = struct('Property', properties, 'Value', cell(size(properties)));
for index = 1:numel(properties)
    snapshot(index).Value = get(groot, properties{index});
end
end

function restoreDefaultSnapshot(snapshot)
for index = 1:numel(snapshot)
    set(groot, snapshot(index).Property, snapshot(index).Value);
end
end

function candidates = defaultCjkFontCandidates()
candidates = { ...
    'Noto Sans CJK SC', ...
    'Noto Sans CJK JP', ...
    'Noto Sans CJK KR', ...
    'Source Han Sans SC', ...
    'Source Han Sans', ...
    'Microsoft YaHei', ...
    'PingFang SC', ...
    'Hiragino Sans', ...
    'SimHei', ...
    'Arial Unicode MS', ...
    'DejaVu Sans', ...
    'Arial'};
end

function candidates = normalizeFontCandidates(value)
if ischar(value) || isstring(value)
    candidates = cellstr(string(value));
else
    candidates = value;
end
candidates = candidates(:).';
end

function fontName = chooseAvailableFont(candidates, fallback)
fontName = char(fallback);
try
    availableFonts = string(listfonts);
catch
    return
end
for index = 1:numel(candidates)
    candidate = string(candidates{index});
    if any(strcmpi(candidate, availableFonts))
        fontName = char(candidate);
        return
    end
end
end
