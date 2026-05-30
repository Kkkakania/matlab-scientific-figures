function [files, report] = renderPositiveNegativeArea(outputDir, formats)
data = sftExampleData('positive_negative_area');
theme = sftTheme('FigureSize', [14 8]);
colors = sftPalette('contrast', 2);

x = data.x(:).';
y = data.y(:).';
positive = max(y, data.baseline);
negative = min(y, data.baseline);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);

hold on
area(x, positive, 0, ...
    'FaceColor', colors(2, :), ...
    'FaceAlpha', 0.78, ...
    'EdgeColor', 'none');
area(x, negative, 0, ...
    'FaceColor', colors(1, :), ...
    'FaceAlpha', 0.78, ...
    'EdgeColor', 'none');
plot(x, y, 'Color', theme.AxisColor, 'LineWidth', theme.LineWidth);
yline(0, '-', 'Color', [0.35 0.35 0.35], 'LineWidth', 0.8);

grid on
xlabel('Time');
ylabel('Change from baseline');
title('Positive-Negative Area');
sftStyleLegend(legend(["Positive", "Negative", "Signal"], 'Location', 'northeast'), theme);
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'positive_negative_area'), formats);
end
