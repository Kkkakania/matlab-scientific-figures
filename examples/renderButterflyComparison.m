function [files, report] = renderButterflyComparison(outputDir, formats)
data = sftExampleData('butterfly');
theme = sftTheme('FigureSize', [13 9.5]);
colors = sftPalette('contrast', 2);

y = 1:numel(data.labels);
leftValues = -data.left(:);
rightValues = data.right(:);
limit = max([data.left(:); data.right(:)]) * 1.18;

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);

hold on
leftBars = barh(y, leftValues, 0.72, 'FaceColor', colors(1, :), ...
    'EdgeColor', 'none');
rightBars = barh(y, rightValues, 0.72, 'FaceColor', colors(2, :), ...
    'EdgeColor', 'none');
xline(0, '-', 'Color', [0.28 0.28 0.28], 'LineWidth', 1.0);

for k = 1:numel(y)
    text(leftValues(k) - limit * 0.035, y(k), sprintf('%g', data.left(k)), ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
    text(rightValues(k) + limit * 0.035, y(k), sprintf('%g', data.right(k)), ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end

xlim([-limit limit]);
ylim([0.35 numel(y) + 0.65]);
set(gca, 'YTick', y, 'YTickLabel', data.labels, 'YDir', 'reverse', ...
    'XTick', -40:20:40, 'XTickLabel', string(abs(-40:20:40)));
grid on
xlabel('Magnitude from shared baseline');
ylabel('Group');
title('Butterfly Comparison');
sftStyleLegend(legend([leftBars, rightBars], [data.leftLabel, data.rightLabel], ...
    'Location', 'southoutside', 'Orientation', 'horizontal'), theme);
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'butterfly_comparison'), formats);
end
