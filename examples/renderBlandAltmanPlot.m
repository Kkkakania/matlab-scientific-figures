function [files, report] = renderBlandAltmanPlot(outputDir, formats)
data = sftExampleData('bland_altman_plot');
theme = sftTheme('FigureSize', [13.5 9]);
colors = sftPalette('contrast', 3);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
scatter(data.meanValues, data.differences, theme.MarkerSize + 8, colors(1, :), ...
    'filled', 'MarkerFaceAlpha', 0.72, 'MarkerEdgeColor', 'w', 'LineWidth', 0.5);

lineColor = [0.24 0.24 0.24];
limitColor = colors(3, :);
yline(data.bias, '-', 'Color', lineColor, 'LineWidth', theme.LineWidth + 0.2);
yline(data.upperLimit, '--', 'Color', limitColor, 'LineWidth', theme.LineWidth);
yline(data.lowerLimit, '--', 'Color', limitColor, 'LineWidth', theme.LineWidth);

xPadding = 0.04 * range(data.meanValues);
yValues = [data.differences; data.upperLimit; data.lowerLimit];
yPadding = 0.12 * range(yValues);
xlim([min(data.meanValues) - xPadding, max(data.meanValues) + xPadding]);
ylim([min(yValues) - yPadding, max(yValues) + yPadding]);
xText = max(data.meanValues) + xPadding * 0.55;
text(xText, data.bias, sprintf('Bias %.2f', data.bias), ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', ...
    'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
    'Color', lineColor, 'BackgroundColor', 'w', 'Margin', 1);
text(xText, data.upperLimit, '+1.96 SD', ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', ...
    'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
    'Color', limitColor, 'BackgroundColor', 'w', 'Margin', 1);
text(xText, data.lowerLimit, '-1.96 SD', ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', ...
    'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
    'Color', limitColor, 'BackgroundColor', 'w', 'Margin', 1);
grid on
xlabel('Mean of two methods');
ylabel('Method B - Method A');
title('Bland-Altman Agreement Plot');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'bland_altman_plot'), formats);
end
