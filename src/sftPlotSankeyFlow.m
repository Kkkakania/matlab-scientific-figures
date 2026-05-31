function [ax, flowHandles, nodeHandles, labelHandles, layout] = sftPlotSankeyFlow(ax, nodes, edges, theme)
%SFTPLOTSANKEYFLOW Draw weighted flow bands across staged nodes.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(nodes) || isempty(edges)
    error('sft:InvalidData', 'Nodes and edges are required.');
end
if ~istable(nodes) || ~istable(edges)
    error('sft:InvalidData', 'Nodes and edges must be tables.');
end
if nargin < 4 || isempty(theme)
    theme = sftTheme('FigureSize', [14 8.5]);
end

requiredNodeVars = ["Name", "Stage"];
requiredEdgeVars = ["Source", "Target", "Weight"];
if ~all(ismember(requiredNodeVars, string(nodes.Properties.VariableNames)))
    error('sft:InvalidData', 'Nodes table must contain Name and Stage variables.');
end
if ~all(ismember(requiredEdgeVars, string(edges.Properties.VariableNames)))
    error('sft:InvalidData', 'Edges table must contain Source, Target, and Weight variables.');
end

nodeNames = string(nodes.Name);
stages = nodes.Stage;
sources = string(edges.Source);
targets = string(edges.Target);
weights = edges.Weight;
if any(strlength(nodeNames) == 0) || numel(unique(nodeNames)) ~= numel(nodeNames)
    error('sft:InvalidData', 'Node names must be nonempty and unique.');
end
if ~isnumeric(stages) || any(~isfinite(stages))
    error('sft:InvalidData', 'Node stages must be finite numeric values.');
end
if ~isnumeric(weights) || any(~isfinite(weights)) || any(weights <= 0)
    error('sft:InvalidData', 'Edge weights must be finite positive values.');
end
if any(~ismember(sources, nodeNames)) || any(~ismember(targets, nodeNames))
    error('sft:InvalidData', 'Every edge source and target must exist in nodes.');
end

colors = sftPalette('main', height(nodes)) * 0.72 + 0.28;
layout = computeSankeyNodeLayout(nodes, edges);
sourceCursor = layout.Bottom;
targetCursor = layout.Bottom;
nodeWidth = 0.055;

wasHold = ishold(ax);
hold(ax, 'on');
flowHandles = gobjects(height(edges), 1);
for k = 1:height(edges)
    sourceIndex = find(nodeNames == sources(k), 1);
    targetIndex = find(nodeNames == targets(k), 1);
    weight = weights(k);

    sourceHeight = weight * layout.Scale(sourceIndex);
    targetHeight = weight * layout.Scale(targetIndex);
    sourceBottom = sourceCursor(sourceIndex);
    sourceTop = sourceBottom + sourceHeight;
    targetBottom = targetCursor(targetIndex);
    targetTop = targetBottom + targetHeight;
    sourceCursor(sourceIndex) = sourceTop;
    targetCursor(targetIndex) = targetTop;

    flowHandles(k) = drawSankeyFlowBand(ax, ...
        layout.X(sourceIndex) + nodeWidth / 2, sourceBottom, sourceTop, ...
        layout.X(targetIndex) - nodeWidth / 2, targetBottom, targetTop, ...
        colors(sourceIndex, :));
end

nodeHandles = gobjects(height(nodes), 1);
labelHandles = gobjects(height(nodes), 1);
for k = 1:height(nodes)
    nodeHandles(k) = rectangle(ax, 'Position', [layout.X(k) - nodeWidth / 2, layout.Bottom(k), ...
        nodeWidth, layout.Height(k)], ...
        'Curvature', 0.08, ...
        'FaceColor', colors(k, :), ...
        'EdgeColor', [1 1 1], ...
        'LineWidth', 1.0);
    labelHandles(k) = text(ax, layout.X(k), layout.Bottom(k) + layout.Height(k) / 2, nodeNames(k), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, ...
        'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end
if ~wasHold
    hold(ax, 'off');
end

xlim(ax, [0.02 0.98]);
ylim(ax, [0 1]);
uniqueStages = unique(stages, 'stable');
set(ax, 'XTick', unique(layout.X), ...
    'XTickLabel', "Stage " + string(uniqueStages(:).'), ...
    'YTick', [], ...
    'Box', 'off');
grid(ax, 'off');
xlabel(ax, 'Stage');
ylabel(ax, 'Flow magnitude');
title(ax, 'Sankey-Style Flow');
sftApplyTheme(ax, theme);
end

function layout = computeSankeyNodeLayout(nodes, edges)
nodeNames = string(nodes.Name);
stages = nodes.Stage;
totals = zeros(height(nodes), 1);

for k = 1:height(nodes)
    inbound = sum(edges.Weight(string(edges.Target) == nodeNames(k)));
    outbound = sum(edges.Weight(string(edges.Source) == nodeNames(k)));
    totals(k) = max([inbound, outbound, 1]);
end

uniqueStages = unique(stages, 'stable');
xPositions = linspace(0.14, 0.86, numel(uniqueStages));
bottom = zeros(height(nodes), 1);
heightValues = zeros(height(nodes), 1);
x = zeros(height(nodes), 1);

for stageIndex = 1:numel(uniqueStages)
    nodeIndex = find(stages == uniqueStages(stageIndex));
    stageTotal = sum(totals(nodeIndex));
    gap = 0.045;
    availableHeight = 0.80 - gap * (numel(nodeIndex) - 1);
    scale = availableHeight / stageTotal;
    heightValues(nodeIndex) = totals(nodeIndex) * scale;
    stageHeight = sum(heightValues(nodeIndex)) + gap * (numel(nodeIndex) - 1);
    cursor = 0.5 - stageHeight / 2;
    for k = 1:numel(nodeIndex)
        idx = nodeIndex(k);
        bottom(idx) = cursor;
        x(idx) = xPositions(stageIndex);
        cursor = cursor + heightValues(idx) + gap;
    end
end

layout = table(x, bottom, heightValues, heightValues ./ totals, ...
    'VariableNames', {'X', 'Bottom', 'Height', 'Scale'});
end

function flowHandle = drawSankeyFlowBand(ax, x0, y0Bottom, y0Top, x1, y1Bottom, y1Top, color)
t = linspace(0, 1, 32);
ease = t .* t .* (3 - 2 * t);
x = x0 + (x1 - x0) * t;
top = y0Top + (y1Top - y0Top) * ease;
bottom = y0Bottom + (y1Bottom - y0Bottom) * ease;

flowHandle = patch(ax, [x fliplr(x)], [top fliplr(bottom)], color, ...
    'FaceAlpha', 0.38, ...
    'EdgeColor', 'none');
end
