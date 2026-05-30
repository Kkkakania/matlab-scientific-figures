function [files, report] = renderPairedSlopegraph(outputDir, formats)
data = sftExampleData('paired_slopegraph');
theme = sftTheme('FigureSize', [16 9.2], 'FontSize', 8);
colors = sftPalette('contrast', 2);

before = data.before(:);
after = data.after(:);
labels = data.labels(:);
[before, order] = sort(before, 'ascend');
after = after(order);
labels = labels(order);
delta = after - before;
yLimits = [min([before; after]) - 0.08, max([before; after]) + 0.09];
leftTextY = spreadTextPositions(before, 0.046, yLimits(1), yLimits(2));
rightTextY = spreadTextPositions(after, 0.046, yLimits(1), yLimits(2));

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
for k = 1:numel(labels)
    color = colors(1, :);
    if delta(k) < 0
        color = colors(2, :);
    end
    plot([1 2], [before(k) after(k)], '-', ...
        'Color', color, 'LineWidth', theme.LineWidth + 0.2);
    scatter([1 2], [before(k) after(k)], 46, color, 'filled', ...
        'MarkerEdgeColor', 'w', 'LineWidth', 0.8);
    text(0.86, leftTextY(k), sprintf('%s  %.2f', labels(k), before(k)), ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
    text(2.14, rightTextY(k), sprintf('%.2f', after(k)), ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, 'FontSize', theme.FontSize - 1, ...
        'Color', theme.AxisColor);
end

xlim([0.05 2.62]);
ylim(yLimits);
set(gca, 'XTick', [1 2], 'XTickLabel', [data.beforeLabel, data.afterLabel], ...
    'YTick', 0.4:0.1:0.9);
grid on
xlabel('Condition');
ylabel('Score');
title('Paired Slopegraph');
sftApplyTheme(gca, theme);

increaseHandle = plot(nan, nan, '-', 'Color', colors(1, :), ...
    'LineWidth', theme.LineWidth + 0.2);
decreaseHandle = plot(nan, nan, '-', 'Color', colors(2, :), ...
    'LineWidth', theme.LineWidth + 0.2);
sftStyleLegend(legend([increaseHandle, decreaseHandle], ...
    ["Increase", "Decrease"], 'Location', 'southoutside', ...
    'Orientation', 'horizontal'), theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'paired_slopegraph'), formats);
end

function adjusted = spreadTextPositions(values, minGap, lowerLimit, upperLimit)
[sortedValues, order] = sort(values(:), 'ascend');
adjustedSorted = sortedValues;

for k = 2:numel(adjustedSorted)
    if adjustedSorted(k) - adjustedSorted(k - 1) < minGap
        adjustedSorted(k) = adjustedSorted(k - 1) + minGap;
    end
end

overflow = adjustedSorted(end) - upperLimit;
if overflow > 0
    adjustedSorted = adjustedSorted - overflow;
end

for k = numel(adjustedSorted) - 1:-1:1
    if adjustedSorted(k + 1) - adjustedSorted(k) < minGap
        adjustedSorted(k) = adjustedSorted(k + 1) - minGap;
    end
end

underflow = lowerLimit - adjustedSorted(1);
if underflow > 0
    adjustedSorted = adjustedSorted + underflow;
end

adjusted = zeros(size(values(:)));
adjusted(order) = adjustedSorted;
end
