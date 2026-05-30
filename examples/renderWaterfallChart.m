function [files, report] = renderWaterfallChart(outputDir, formats)
data = sftExampleData('waterfall_chart');
theme = sftTheme('FigureSize', [13.5 8.5]);
colors = sftPalette('contrast', 3);

steps = data.steps(:).';
before = data.start + [0 cumsum(steps(1:end - 1))];
after = data.start + cumsum(steps);
labels = ["Start", data.labels, "Final"];
x = 1:numel(labels);
barWidth = 0.62;

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
drawFloatingBar(x(1), 0, data.start, barWidth, colors(1, :));
for k = 1:numel(steps)
    color = colors(2, :);
    if steps(k) < 0
        color = colors(3, :);
    end
    drawFloatingBar(x(k + 1), before(k), after(k), barWidth, color);
    plot([x(k) + barWidth / 2, x(k + 1) - barWidth / 2], ...
        [before(k), before(k)], '-', 'Color', [0.65 0.65 0.65], ...
        'LineWidth', 0.8, 'HandleVisibility', 'off');
end
drawFloatingBar(x(end), 0, data.final, barWidth, colors(1, :));

valuesForLabels = [data.start steps data.final];
labelY = [data.start max(before, after) data.final] + 3;
for k = 1:numel(x)
    if k == 1 || k == numel(x)
        labelText = sprintf('%g', valuesForLabels(k));
    else
        labelText = sprintf('%+g', valuesForLabels(k));
    end
    text(x(k), labelY(k), labelText, ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
        'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end

xlim([0.35 numel(labels) + 0.65]);
ylim([0 max([data.start after data.final]) + 18]);
set(gca, 'XTick', x, 'XTickLabel', labels);
xtickangle(30);
grid on
xlabel('Contribution step');
ylabel('Cumulative value');
title('Waterfall Chart');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'waterfall_chart'), formats);
end

function drawFloatingBar(x, y0, y1, width, color)
bottom = min(y0, y1);
height = abs(y1 - y0);
rectangle('Position', [x - width / 2, bottom, width, height], ...
    'FaceColor', color, 'EdgeColor', 'none');
end
