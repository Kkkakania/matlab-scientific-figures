function [files, report] = renderUncertaintyFanChart(outputDir, formats)
data = sftExampleData('uncertainty_fan_chart');
theme = sftTheme('FigureSize', [14 8.5]);
colors = sftPalette('main', 1);
bandColor = colors(1, :);

x = data.x(:).';

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
outerBand = fill([x fliplr(x)], [data.p10 fliplr(data.p90)], bandColor, ...
    'FaceAlpha', 0.16, 'EdgeColor', 'none');
innerBand = fill([x fliplr(x)], [data.p25 fliplr(data.p75)], bandColor, ...
    'FaceAlpha', 0.32, 'EdgeColor', 'none');
medianLine = plot(x, data.median, 'Color', bandColor * 0.72, ...
    'LineWidth', theme.LineWidth + 0.4);

grid on
xlabel('Forecast horizon');
ylabel('Response');
title('Uncertainty Fan Chart');
sftStyleLegend(legend([outerBand, innerBand, medianLine], ...
    ["10-90% band", "25-75% band", "Median"], ...
    'Location', 'northwest'), theme);
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'uncertainty_fan_chart'), formats);
end
