function report = sftValidateFigure(fig, options)
%SFTVALIDATEFIGURE Run lightweight quality checks for a figure.
%
%   REPORT = SFTVALIDATEFIGURE(FIG) checks whether FIG has plot axes,
%   readable labels, a reasonable canvas size, readable tick fonts, and a
%   white background. The function returns a struct with a Passed flag and a
%   Checks struct array.

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
