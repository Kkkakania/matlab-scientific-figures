function [ax, boxHandle, pointHandles] = sftPlotBoxJitter(ax, group, value, theme)
%SFTPLOTBOXJITTER Draw a box plot with jittered observations.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(group) || isempty(value)
    error('sft:InvalidData', 'Group and value inputs are required.');
end
if ~isnumeric(value)
    error('sft:InvalidData', 'Value must be numeric.');
end
if nargin < 4 || isempty(theme)
    theme = sftTheme();
end

group = categorical(group(:));
value = value(:);
if numel(group) ~= numel(value)
    error('sft:InvalidData', 'Group and value must have the same number of elements.');
end

groupNames = categories(group);
groupIndex = double(group);
colors = sftPalette('main', numel(groupNames));
jitter = localDeterministicJitter(groupIndex);

boxHandle = boxchart(ax, group, value, ...
    'BoxFaceColor', [0.82 0.86 0.90], ...
    'MarkerStyle', 'none', ...
    'LineWidth', theme.LineWidth);
hold(ax, 'on');
pointHandles = gobjects(numel(groupNames), 1);
for k = 1:numel(groupNames)
    mask = groupIndex == k;
    pointHandles(k) = scatter(ax, groupIndex(mask) + jitter(mask), value(mask), ...
        26, colors(k, :), ...
        'filled', ...
        'MarkerFaceAlpha', 0.60, ...
        'MarkerEdgeColor', 'none');
end
hold(ax, 'off');

grid(ax, 'on');
xlabel(ax, 'Group');
ylabel(ax, 'Measurement');
title(ax, 'Box Plot With Jittered Points');
sftApplyTheme(ax, theme);
end

function jitter = localDeterministicJitter(groupIndex)
phase = (1:numel(groupIndex)).';
jitter = (mod(phase * 37, 101) ./ 100 - 0.5) * 0.22;
end
