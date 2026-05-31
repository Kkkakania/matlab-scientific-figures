function [ax, fillHandles, lineHandles] = sftPlotRidgeline(ax, values, labels, theme)
%SFTPLOTRIDGELINE Draw compact stacked density profiles for groups.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(values) || isempty(labels)
    error('sft:InvalidData', 'Values and labels are required.');
end
if ~isnumeric(values) || ~ismatrix(values)
    error('sft:InvalidData', 'Values must be a numeric matrix.');
end
if nargin < 4 || isempty(theme)
    theme = sftTheme('FigureSize', [13 8.5]);
end

labels = string(labels(:));
if numel(labels) ~= size(values, 2)
    error('sft:InvalidLabels', 'Labels must match the value columns.');
end
if any(~isfinite(values(:)))
    error('sft:InvalidData', 'Values must be finite.');
end

colors = sftPalette('main', numel(labels));
xEdges = linspace(min(values(:)) - 0.4, max(values(:)) + 0.4, 46);
x = (xEdges(1:end - 1) + xEdges(2:end)) / 2;

wasHold = ishold(ax);
hold(ax, 'on');
fillHandles = gobjects(numel(labels), 1);
lineHandles = gobjects(numel(labels), 1);
for k = 1:numel(labels)
    density = histcounts(values(:, k), xEdges, 'Normalization', 'pdf');
    density = smoothRidgelineDensity(density);
    maxDensity = max(density);
    if maxDensity > 0
        density = density ./ maxDensity * 0.72;
    end
    baseline = k;
    fillHandles(k) = fill(ax, [x fliplr(x)], ...
        [baseline + density, baseline * ones(size(density))], ...
        colors(k, :), ...
        'FaceAlpha', 0.76, ...
        'EdgeColor', 'none');
    lineHandles(k) = plot(ax, x, baseline + density, ...
        'Color', colors(k, :) * 0.75, ...
        'LineWidth', theme.LineWidth);
end
if ~wasHold
    hold(ax, 'off');
end

set(ax, ...
    'YTick', 1:numel(labels), ...
    'YTickLabel', labels);
ylim(ax, [0.55 numel(labels) + 0.95]);
xlim(ax, [min(xEdges) max(xEdges)]);
grid(ax, 'on');
xlabel(ax, 'Value');
ylabel(ax, 'Group');
title(ax, 'Ridgeline Plot');
sftApplyTheme(ax, theme);
end

function density = smoothRidgelineDensity(density)
kernel = [1 2 3 2 1] / 9;
density = conv(density, kernel, 'same');
end
