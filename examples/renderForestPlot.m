function [files, report] = renderForestPlot(outputDir, formats)
data = sftExampleData('forest_plot');
theme = sftTheme('FigureSize', [13.5 8.5]);
colors = sftPalette('contrast', 2);

estimate = data.estimate(:);
lower = data.lower(:);
upper = data.upper(:);
labels = data.labels(:);
y = 1:numel(labels);
isAwayFromReference = lower > data.reference | upper < data.reference;

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
xline(data.reference, '-', 'Color', [0.42 0.42 0.42], ...
    'LineWidth', 1.0, 'HandleVisibility', 'off');
for k = 1:numel(labels)
    color = colors(1, :);
    if ~isAwayFromReference(k)
        color = colors(2, :);
    end
    plot([lower(k) upper(k)], [y(k) y(k)], '-', ...
        'Color', color, 'LineWidth', theme.LineWidth + 0.4);
    scatter(estimate(k), y(k), 64, color, 'filled', ...
        'MarkerEdgeColor', 'w', 'LineWidth', 0.8);
    text(upper(k) + 0.035, y(k), sprintf('%.2f', estimate(k)), ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end

xlim([min(lower) - 0.08, max(upper) + 0.18]);
ylim([0.45 numel(labels) + 0.55]);
set(gca, 'YTick', y, 'YTickLabel', labels, 'YDir', 'reverse');
grid on
xlabel('Effect estimate');
ylabel('Scenario');
title('Forest Plot');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'forest_plot'), formats);
end
