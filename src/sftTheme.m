function [theme, cleanup] = sftTheme(varargin)
%SFTTHEME Return shared style settings for scientific figures.
%
%   theme = SFTTHEME() returns a struct with stable defaults for figures,
%   axes, fonts, lines, grid styling, and export size.
%
%   [theme, cleanup] = SFTTHEME('ApplyDefaults', true) applies the theme to
%   MATLAB root graphics defaults and returns an onCleanup handle that
%   restores the previous values when it is cleared.
%
%   theme = SFTTHEME("TextScript", "cjk") selects the first available
%   CJK-friendly fallback font for Chinese, Japanese, or Korean labels.
%
%   theme = SFTTHEME("FontMode", "cjk") is an equivalent compatibility
%   spelling for users who already adopted the CJK font mode.
%
%   theme = SFTTHEME("FontName", "Journal Sans", ...
%       "FontFallbacks", ["Arial", "Helvetica"]) uses the requested font
%   when available and otherwise falls back to the first installed fallback.

p = inputParser;
p.FunctionName = 'sftTheme';
addParameter(p, 'FontName', 'Arial', @(x) ischar(x) || isstring(x));
addParameter(p, 'FontMode', 'latin', @(x) any(strcmpi(string(x), ["latin", "cjk"])));
addParameter(p, 'TextScript', 'latin', @(x) any(strcmpi(string(x), ["latin", "cjk"])));
addParameter(p, 'CjkFontCandidates', defaultCjkFontCandidates(), ...
    @(x) ischar(x) || isstring(x) || iscellstr(x));
addParameter(p, 'FontFallbacks', string.empty(1, 0), @(x) ischar(x) || isstring(x) || iscellstr(x));
addParameter(p, 'AvailableFonts', string.empty(1, 0), @(x) ischar(x) || isstring(x) || iscellstr(x));
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
requestedFontName = char(theme.FontName);
theme.FontMode = char(lower(string(theme.FontMode)));
theme.TextScript = char(lower(string(theme.TextScript)));
if strcmp(theme.FontMode, 'cjk') || strcmp(theme.TextScript, 'cjk')
    theme.FontMode = 'cjk';
    theme.TextScript = 'cjk';
else
    theme.FontMode = 'latin';
    theme.TextScript = 'latin';
end

theme.CjkFontCandidates = normalizeFontCandidates(theme.CjkFontCandidates);
if isempty(theme.FontFallbacks)
    theme.FontFallbacks = defaultFontFallbacks(theme.TextScript, theme.CjkFontCandidates);
else
    theme.FontFallbacks = string(theme.FontFallbacks);
end

availableFonts = string(theme.AvailableFonts);
theme = rmfield(theme, 'AvailableFonts');
if strcmp(theme.TextScript, 'cjk') && ~wasParameterProvided(varargin, 'FontName')
    requestedFontName = char(theme.FontFallbacks(1));
end
theme.RequestedFontName = requestedFontName;
theme.FontName = char(resolveFontName(requestedFontName, theme.FontFallbacks, availableFonts));
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
    'PingFang SC', ...
    'Hiragino Sans GB', ...
    'Microsoft YaHei', ...
    'SimHei', ...
    'WenQuanYi Micro Hei', ...
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

function fallbacks = defaultFontFallbacks(textScript, cjkCandidates)
switch textScript
    case 'cjk'
        fallbacks = string(cjkCandidates);
    otherwise
        fallbacks = ["Arial", "Helvetica", "DejaVu Sans"];
end
end

function tf = wasParameterProvided(args, name)
tf = false;
for k = 1:2:numel(args)
    if ischar(args{k}) || isstring(args{k})
        tf = strcmpi(string(args{k}), string(name));
        if tf
            return
        end
    end
end
end

function fontName = resolveFontName(requestedFontName, fallbacks, availableFonts)
if isempty(availableFonts)
    availableFonts = installedFonts();
end

candidates = unique([string(requestedFontName), string(fallbacks)], 'stable');
availableFonts = string(availableFonts);
for k = 1:numel(candidates)
    if any(strcmpi(candidates(k), availableFonts))
        fontName = candidates(k);
        return
    end
end

fontName = string(requestedFontName);
end

function fonts = installedFonts()
try
    fonts = string(listfonts);
catch
    fonts = string.empty(1, 0);
end
end
