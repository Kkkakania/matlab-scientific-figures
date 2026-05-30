function files = renderConfidenceInterval(outputDir, formats)
data = sftExampleData('confidence');
theme = sftTheme('FigureSize', [15 9]);
colors = sftPalette('main', 3);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
for k = 1:size(data.center, 1)
    xPatch = [data.x, fliplr(data.x)];
    yPatch = [data.lower(k, :), fliplr(data.upper(k, :))];
    fill(xPatch, yPatch, colors(k, :), 'FaceAlpha', 0.18, 'EdgeColor', 'none');
    plot(data.x, data.center(k, :), 'Color', colors(k, :), 'LineWidth', theme.LineWidth + 0.3);
end
grid on
xlabel('Input');
ylabel('Estimate');
title('Line Chart With Confidence Interval');
legend(data.labels, 'Location', 'best', 'Box', 'off');
sftApplyTheme(gca, theme);

files = sftExport(fig, fullfile(outputDir, 'confidence_interval'), formats);
close(fig);
end
