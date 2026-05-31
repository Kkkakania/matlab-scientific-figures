function [ax, pointHandles, labelHandles] = sftPlotTernaryScatter(ax, compositions, groups, componentLabels, theme)
%SFTPLOTTERNARYSCATTER Draw grouped scatter points on a ternary composition frame.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 4 || isempty(compositions) || isempty(groups) || isempty(componentLabels)
    error('sft:InvalidData', 'Compositions, groups, and component labels are required.');
end
if ~isnumeric(compositions) || ~ismatrix(compositions) || size(compositions, 2) ~= 3
    error('sft:InvalidData', 'Compositions must be a numeric matrix with three columns.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [12 10]);
end

groups = categorical(groups(:));
componentLabels = string(componentLabels(:));
if size(compositions, 1) ~= numel(groups)
    error('sft:InvalidData', 'Each composition row must have one group label.');
end
if numel(componentLabels) ~= 3
    error('sft:InvalidLabels', 'Exactly three component labels are required.');
end
if isempty(compositions) || any(~isfinite(compositions), 'all') || any(compositions(:) < 0)
    error('sft:InvalidData', 'Compositions must be finite nonnegative values.');
end
rowTotals = sum(compositions, 2);
if any(rowTotals <= 0)
    error('sft:InvalidData', 'Each composition row must have a positive total.');
end
compositions = compositions ./ rowTotals;

groupNames = categories(groups);
colors = sftPalette('contrast', numel(groupNames));
triangleHeight = sqrt(3) / 2;

wasHold = ishold(ax);
hold(ax, 'on');
drawTernaryFrame(ax, theme);

pointHandles = gobjects(numel(groupNames), 1);
for k = 1:numel(groupNames)
    mask = groups == groupNames{k};
    [x, y] = ternaryToCartesian(compositions(mask, 1), ...
        compositions(mask, 2), compositions(mask, 3));
    pointHandles(k) = scatter(ax, x, y, theme.MarkerSize, colors(k, :), ...
        'filled', ...
        'MarkerFaceAlpha', 0.74, ...
        'MarkerEdgeColor', 'w', ...
        'LineWidth', 0.4);
end

labelHandles = gobjects(3, 1);
labelHandles(1) = text(ax, 0.12, -0.025, componentLabels(1), ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'top', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize + 1, ...
    'Color', theme.AxisColor);
labelHandles(2) = text(ax, 0.88, -0.025, componentLabels(2), ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'top', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize + 1, ...
    'Color', theme.AxisColor);
labelHandles(3) = text(ax, 0.5, triangleHeight + 0.045, componentLabels(3), ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'bottom', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize + 1, ...
    'Color', theme.AxisColor);
if ~wasHold
    hold(ax, 'off');
end

axis(ax, 'equal');
xlim(ax, [-0.13 1.13]);
ylim(ax, [-0.11 triangleHeight + 0.13]);
set(ax, 'XTick', [], 'YTick', []);
xlabel(ax, 'Three-part composition');
ylabel(ax, 'Component C share');
title(ax, 'Ternary Scatter');
legendHandle = legend(ax, pointHandles, groupNames, ...
    'Location', 'southoutside', ...
    'Orientation', 'horizontal');
sftStyleLegend(legendHandle, theme);
sftApplyTheme(ax, theme);
set(ax, 'XColor', [1 1 1], 'YColor', [1 1 1]);
set([ax.XLabel, ax.YLabel], 'Color', [1 1 1]);
end

function drawTernaryFrame(ax, theme)
triangleHeight = sqrt(3) / 2;
outlineX = [0 1 0.5 0];
outlineY = [0 0 triangleHeight 0];
plot(ax, outlineX, outlineY, '-', ...
    'Color', theme.AxisColor, ...
    'LineWidth', theme.LineWidth, ...
    'HandleVisibility', 'off');

for level = 0.2:0.2:0.8
    drawGridLine(ax, level, "A", theme.GridColor);
    drawGridLine(ax, level, "B", theme.GridColor);
    drawGridLine(ax, level, "C", theme.GridColor);
end
end

function drawGridLine(ax, level, component, color)
switch component
    case "A"
        a = [level level];
        b = [0 1 - level];
        c = [1 - level 0];
    case "B"
        a = [0 1 - level];
        b = [level level];
        c = [1 - level 0];
    otherwise
        a = [0 1 - level];
        b = [1 - level 0];
        c = [level level];
end
[x, y] = ternaryToCartesian(a, b, c);
plot(ax, x, y, '-', ...
    'Color', color, ...
    'LineWidth', 0.7, ...
    'HandleVisibility', 'off');
end

function [x, y] = ternaryToCartesian(a, b, c)
total = a + b + c;
b = b ./ total;
c = c ./ total;
x = b + 0.5 * c;
y = (sqrt(3) / 2) * c;
end
