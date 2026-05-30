function [files, report] = renderWaffleChart(outputDir, formats)
data = sftExampleData('waffle');
theme = sftTheme('FigureSize', [12 9]);
gridSize = 10;
cellCount = gridSize * gridSize;
categoryIndex = repelem(1:numel(data.counts), data.counts);
if numel(categoryIndex) ~= cellCount
    error('renderWaffleChart:InvalidCounts', 'Waffle counts must sum to %d.', cellCount);
end

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
for idx = 1:cellCount
    row = ceil(idx / gridSize);
    col = mod(idx - 1, gridSize) + 1;
    color = data.colors(categoryIndex(idx), :);
    rectangle('Position', [col - 0.43, row - 0.43, 0.82, 0.82], ...
        'Curvature', 0.12, 'FaceColor', color, 'EdgeColor', [1 1 1], ...
        'LineWidth', 0.8);
end

legendHandles = gobjects(numel(data.labels), 1);
legendLabels = strings(numel(data.labels), 1);
for k = 1:numel(data.labels)
    legendHandles(k) = plot(nan, nan, 's', 'MarkerSize', 9, ...
        'MarkerFaceColor', data.colors(k, :), 'MarkerEdgeColor', 'none');
    legendLabels(k) = sprintf('%s (%d%%)', data.labels(k), data.counts(k));
end

axis equal
xlim([0.45 gridSize + 0.55]);
ylim([0.45 gridSize + 0.55]);
set(gca, 'YDir', 'reverse', 'XTick', [], 'YTick', []);
grid off
xlabel('100 cells');
ylabel('Composition');
title('Waffle Chart');
sftStyleLegend(legend(legendHandles, legendLabels, 'Location', 'eastoutside'), theme);
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'waffle_chart'), formats);
end
