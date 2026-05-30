function [files, report] = renderMultiPanelOverview(outputDir, formats)
theme = sftTheme('FigureSize', [16 11], 'FontSize', 8.5, 'MarkerSize', 32);
colors = sftPalette('main', 4);

[fig, layout] = sftTiledFigure(2, 2, ...
    'Theme', theme, ...
    'FigureSize', theme.FigureSize);
title(layout, 'Multi-Panel Overview', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize + 2.5, ...
    'FontWeight', 'bold', ...
    'Color', theme.AxisColor);

lineData = sftExampleData('line');
ax = nexttile(layout);
plot(lineData.x, lineData.y(1, :), 'Color', colors(1, :), 'LineWidth', theme.LineWidth);
grid on
title('Trend');
xlabel('Time');
ylabel('Response');
sftApplyTheme(ax, theme);

scatterData = sftExampleData('scatter');
ax = nexttile(layout);
scatter(scatterData.x, scatterData.y, theme.MarkerSize * 0.55, colors(2, :), ...
    'filled', 'MarkerFaceAlpha', 0.65, 'MarkerEdgeColor', 'none');
grid on
title('Relationship');
xlabel('Input');
ylabel('Output');
sftApplyTheme(ax, theme);

barData = sftExampleData('grouped_bar');
ax = nexttile(layout);
bar(barData.values(:, 1), 'FaceColor', colors(3, :), 'EdgeColor', 'none');
set(ax, 'XTick', 1:numel(barData.groups), 'XTickLabel', barData.groups);
xtickangle(25);
grid on
title('Comparison');
xlabel('Method');
ylabel('Score');
sftApplyTheme(ax, theme);

rankData = sftExampleData('lollipop');
ax = nexttile(layout);
[values, idx] = sort(rankData.values, 'ascend');
labels = rankData.labels(idx);
y = 1:numel(values);
plot([zeros(size(values)); values], [y; y], 'Color', colors(4, :), ...
    'LineWidth', theme.LineWidth);
hold on
scatter(values, y, theme.MarkerSize, colors(4, :), 'filled');
set(ax, 'YTick', y, 'YTickLabel', labels);
xlim([0 1]);
grid on
title('Ranking');
xlabel('Importance');
ylabel('Factor');
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'multi_panel_overview'), formats);
end
