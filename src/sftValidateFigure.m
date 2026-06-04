function report = sftValidateFigure(fig, options)
%SFTVALIDATEFIGURE Run lightweight quality checks for a figure.
%
%   REPORT = SFTVALIDATEFIGURE(FIG) checks whether FIG has plot axes,
%   readable labels, a reasonable canvas size, readable tick fonts, and a
%   white background. The function returns a struct with a Passed flag and a
%   Checks struct array.
%
%   REPORT = SFTVALIDATEFIGURE(..., 'CheckColorContrast', true) also checks
%   whether extracted line, marker, and patch colors are separated by at
%   least MinimumColorDistance in Lab color space.

arguments
    fig = gcf
    options.RequireTitle (1, 1) logical = true
    options.RequireAxisLabels (1, 1) logical = true
    options.RequireWhiteBackground (1, 1) logical = true
    options.MinimumWidth (1, 1) double = 480
    options.MinimumHeight (1, 1) double = 320
    options.MinimumWidthCentimeters (1, 1) double = 10
    options.MinimumHeightCentimeters (1, 1) double = 6
    options.MinimumFontSize (1, 1) double = 8
    options.CheckColorContrast (1, 1) logical = false
    options.MinimumColorDistance (1, 1) double = 2
end

if isempty(fig) || ~ishandle(fig) || ~strcmp(get(fig, 'Type'), 'figure')
    error('sftValidateFigure:InvalidFigure', 'Input must be a valid figure handle.');
end

axesList = getPlotAxes(fig);
checks = struct('Name', {}, 'Passed', {}, 'Message', {});

checks(end + 1) = makeCheck( ...
    'HasAxes', ...
    ~isempty(axesList), ...
    'Figure contains at least one plot axes.');

hasEnoughPixels = hasEnoughCanvasSize(fig, options);
checks(end + 1) = makeCheck( ...
    'FigureSize', ...
    hasEnoughPixels, ...
    sprintf('Figure canvas is at least %.0f x %.0f pixels or %.0f x %.0f cm.', ...
    options.MinimumWidth, options.MinimumHeight, ...
    options.MinimumWidthCentimeters, options.MinimumHeightCentimeters));

if options.RequireWhiteBackground
    figColor = get(fig, 'Color');
    checks(end + 1) = makeCheck( ...
        'WhiteBackground', ...
        isnumeric(figColor) && numel(figColor) == 3 && all(abs(figColor - [1 1 1]) < 1e-6), ...
        'Figure background is white for clean exports.');
end

if ~isempty(axesList)
    fontSizes = arrayfun(@(ax) get(ax, 'FontSize'), axesList);
    checks(end + 1) = makeCheck( ...
        'ReadableFontSize', ...
        all(fontSizes >= options.MinimumFontSize), ...
        sprintf('All axes use tick fonts of at least %.0f pt.', options.MinimumFontSize));

    if options.RequireTitle
        titlePass = all(arrayfun(@(ax) hasText(ax.Title), axesList));
        checks(end + 1) = makeCheck( ...
            'HasTitle', ...
            titlePass, ...
            'Each plot axes has a non-empty title.');
    end

    if options.RequireAxisLabels
        labelPass = all(arrayfun(@(ax) hasText(ax.XLabel) && hasText(ax.YLabel), axesList));
        checks(end + 1) = makeCheck( ...
            'HasAxisLabels', ...
            labelPass, ...
            'Each plot axes has non-empty x and y labels.');
    end

    if options.CheckColorContrast
        [contrastPass, minDistance] = hasEnoughColorSeparation(axesList, options.MinimumColorDistance);
        checks(end + 1) = makeCheck( ...
            'PairwiseColorContrast', ...
            contrastPass, ...
            sprintf('Extracted series colors are at least %.1f Lab units apart (minimum observed %.2f).', ...
            options.MinimumColorDistance, minDistance));
    end
end

report = struct();
report.Passed = all([checks.Passed]);
report.Checks = checks;
end

function axesList = getPlotAxes(fig)
axesList = findall(fig, 'Type', 'axes');
keep = true(size(axesList));
for k = 1:numel(axesList)
    tag = string(get(axesList(k), 'Tag'));
    className = string(class(axesList(k)));
    keep(k) = tag ~= "legend" ...
        && tag ~= "Colorbar" ...
        && ~contains(className, "Legend") ...
        && ~contains(className, "ColorBar");
end
axesList = axesList(keep);
end

function check = makeCheck(name, passed, message)
check = struct( ...
    'Name', char(name), ...
    'Passed', logical(passed), ...
    'Message', char(message));
end

function tf = hasEnoughCanvasSize(fig, options)
units = string(get(fig, 'Units'));
position = get(fig, 'Position');
if numel(position) < 4
    tf = false;
    return
end

switch units
    case "pixels"
        tf = position(3) >= options.MinimumWidth && position(4) >= options.MinimumHeight;
    case "centimeters"
        tf = position(3) >= options.MinimumWidthCentimeters ...
            && position(4) >= options.MinimumHeightCentimeters;
    case "inches"
        tf = position(3) * 2.54 >= options.MinimumWidthCentimeters ...
            && position(4) * 2.54 >= options.MinimumHeightCentimeters;
    case "points"
        tf = position(3) / 72 * 2.54 >= options.MinimumWidthCentimeters ...
            && position(4) / 72 * 2.54 >= options.MinimumHeightCentimeters;
    otherwise
        pixelPosition = getpixelposition(fig);
        tf = numel(pixelPosition) >= 4 ...
            && pixelPosition(3) >= options.MinimumWidth ...
            && pixelPosition(4) >= options.MinimumHeight;
end
end

function tf = hasText(textHandle)
value = get(textHandle, 'String');
value = string(value);
tf = any(strlength(strtrim(value)) > 0);
end

function [tf, minDistance] = hasEnoughColorSeparation(axesList, threshold)
minDistance = inf;
for axesIndex = 1:numel(axesList)
    colors = collectAxesColors(axesList(axesIndex));
    if size(colors, 1) < 2
        continue
    end
    labColors = rgbToLab(colors);
    for row = 1:size(labColors, 1)
        for other = row + 1:size(labColors, 1)
            distance = norm(labColors(row, :) - labColors(other, :));
            minDistance = min(minDistance, distance);
        end
    end
end

if isinf(minDistance)
    minDistance = NaN;
    tf = true;
else
    tf = minDistance >= threshold;
end
end

function colors = collectAxesColors(ax)
graphicsObjects = findall(ax);
colors = zeros(0, 3);
for index = 1:numel(graphicsObjects)
    colors = [colors; collectObjectColor(graphicsObjects(index), 'Color')]; %#ok<AGROW>
    colors = [colors; collectObjectColor(graphicsObjects(index), 'FaceColor')]; %#ok<AGROW>
    colors = [colors; collectObjectColor(graphicsObjects(index), 'MarkerFaceColor')]; %#ok<AGROW>
end
colors = unique(round(colors, 6), 'rows');
end

function color = collectObjectColor(objectHandle, propertyName)
color = zeros(0, 3);
if ~isprop(objectHandle, propertyName)
    return
end
try
    value = get(objectHandle, propertyName);
catch
    return
end
if isnumeric(value) && ismatrix(value) && size(value, 2) == 3
    value = double(value);
    keep = all(isfinite(value), 2) & all(value >= 0, 2) & all(value <= 1, 2);
    color = value(keep, :);
end
end

function lab = rgbToLab(rgb)
rgb = max(0, min(1, rgb));
linearRgb = zeros(size(rgb));
low = rgb <= 0.04045;
linearRgb(low) = rgb(low) / 12.92;
linearRgb(~low) = ((rgb(~low) + 0.055) / 1.055) .^ 2.4;

xyz = linearRgb * [ ...
    0.4124564 0.3575761 0.1804375; ...
    0.2126729 0.7151522 0.0721750; ...
    0.0193339 0.1191920 0.9503041]';
white = [0.95047 1.00000 1.08883];
xyz = xyz ./ white;

f = zeros(size(xyz));
low = xyz <= (6 / 29) ^ 3;
f(low) = xyz(low) / (3 * (6 / 29) ^ 2) + 4 / 29;
f(~low) = xyz(~low) .^ (1 / 3);

lab = [100 * f(:, 2) - 100, ...
    500 * (f(:, 1) - f(:, 2)), ...
    200 * (f(:, 2) - f(:, 3))];
end
