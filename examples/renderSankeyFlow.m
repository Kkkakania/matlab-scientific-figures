function [files, report] = renderSankeyFlow(outputDir, formats)
data = sftExampleData('sankey_flow');
theme = sftTheme('FigureSize', [14 8.5]);

nodes = data.nodes;
edges = data.edges;
nodeNames = string(nodes.Name);
colors = sftPalette('main', height(nodes)) * 0.72 + 0.28;

layout = computeNodeLayout(nodes, edges);
sourceCursor = layout.Bottom;
targetCursor = layout.Bottom;
nodeWidth = 0.055;

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
hold on

for k = 1:height(edges)
    sourceIndex = find(nodeNames == string(edges.Source(k)), 1);
    targetIndex = find(nodeNames == string(edges.Target(k)), 1);
    weight = edges.Weight(k);

    sourceHeight = weight * layout.Scale(sourceIndex);
    targetHeight = weight * layout.Scale(targetIndex);
    sourceBottom = sourceCursor(sourceIndex);
    sourceTop = sourceBottom + sourceHeight;
    targetBottom = targetCursor(targetIndex);
    targetTop = targetBottom + targetHeight;
    sourceCursor(sourceIndex) = sourceTop;
    targetCursor(targetIndex) = targetTop;

    drawFlowBand( ...
        layout.X(sourceIndex) + nodeWidth / 2, sourceBottom, sourceTop, ...
        layout.X(targetIndex) - nodeWidth / 2, targetBottom, targetTop, ...
        colors(sourceIndex, :));
end

for k = 1:height(nodes)
    rectangle('Position', [layout.X(k) - nodeWidth / 2, layout.Bottom(k), ...
        nodeWidth, layout.Height(k)], ...
        'Curvature', 0.08, ...
        'FaceColor', colors(k, :), ...
        'EdgeColor', [1 1 1], ...
        'LineWidth', 1.0);
    text(layout.X(k), layout.Bottom(k) + layout.Height(k) / 2, nodeNames(k), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, ...
        'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end

xlim([0.02 0.98]);
ylim([0 1]);
set(gca, 'XTick', unique(layout.X), ...
    'XTickLabel', "Stage " + string(unique(nodes.Stage).'), ...
    'YTick', [], ...
    'Box', 'off');
grid off
xlabel('Stage');
ylabel('Flow magnitude');
title('Sankey-Style Flow');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'sankey_flow'), formats);
end

function layout = computeNodeLayout(nodes, edges)
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

function drawFlowBand(x0, y0Bottom, y0Top, x1, y1Bottom, y1Top, color)
t = linspace(0, 1, 32);
ease = t .* t .* (3 - 2 * t);
x = x0 + (x1 - x0) * t;
top = y0Top + (y1Top - y0Top) * ease;
bottom = y0Bottom + (y1Bottom - y0Bottom) * ease;

patch([x fliplr(x)], [top fliplr(bottom)], color, ...
    'FaceAlpha', 0.38, ...
    'EdgeColor', 'none');
end
