function [files, report] = renderLinePlot(outputDir, formats)
data = sftExampleData('line');
theme = sftTheme();
colors = sftPalette('main', 3);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
for k = 1:size(data.y, 1)
    plot(data.x, data.y(k, :), 'Color', colors(k, :), 'LineWidth', theme.LineWidth);
end
grid on
xlabel('Time');
ylabel('Response');
title('Line Plot');
sftStyleLegend(legend(data.labels, 'Location', 'best'), theme);
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'line_plot'), formats);
end
