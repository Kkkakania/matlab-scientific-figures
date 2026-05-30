function files = renderLollipopRanking(outputDir, formats)
data = sftExampleData('lollipop');
theme = sftTheme('FigureSize', [13 9]);
colors = sftPalette('contrast', numel(data.values));
[values, order] = sort(data.values, 'ascend');
labels = data.labels(order);
colors = colors(order, :);
y = 1:numel(values);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
for k = 1:numel(values)
    plot([0 values(k)], [y(k) y(k)], '-', 'Color', [0.72 0.72 0.72], 'LineWidth', theme.LineWidth);
    scatter(values(k), y(k), 80, colors(k, :), 'filled', 'MarkerEdgeColor', 'none');
end
grid on
xlim([0 1]);
set(gca, 'YTick', y, 'YTickLabel', labels);
xlabel('Relative score');
title('Lollipop Ranking');
sftApplyTheme(gca, theme);

files = sftExport(fig, fullfile(outputDir, 'lollipop_ranking'), formats);
close(fig);
end
