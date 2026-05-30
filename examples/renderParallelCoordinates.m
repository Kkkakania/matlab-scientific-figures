function [files, report] = renderParallelCoordinates(outputDir, formats)
data = sftExampleData('parallel_coordinates');
theme = sftTheme('FigureSize', [14 8]);

values = data.values;
features = data.features;
groups = data.groups;
groupNames = unique(groups, 'stable');
colors = sftPalette('contrast', numel(groupNames));
x = 1:numel(features);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
for k = 1:numel(features)
    plot([x(k) x(k)], [0 1], 'Color', theme.GridColor, ...
        'LineWidth', 0.8, 'HandleVisibility', 'off');
end

medianHandles = gobjects(numel(groupNames), 1);
for groupIndex = 1:numel(groupNames)
    groupMask = groups == groupNames(groupIndex);
    lineColor = colors(groupIndex, :) * 0.72 + 0.28;
    for row = find(groupMask).'
        plot(x, values(row, :), '-', ...
            'Color', lineColor, ...
            'LineWidth', 0.7, ...
            'HandleVisibility', 'off');
    end

    medianValues = median(values(groupMask, :), 1);
    medianHandles(groupIndex) = plot(x, medianValues, '-o', ...
        'Color', colors(groupIndex, :), ...
        'MarkerFaceColor', colors(groupIndex, :), ...
        'MarkerSize', 4.5, ...
        'LineWidth', theme.LineWidth + 0.6);
end

xlim([0.75 numel(features) + 0.25]);
ylim([0 1]);
set(gca, ...
    'XTick', x, ...
    'XTickLabel', features, ...
    'YTick', 0:0.25:1);
grid on
xlabel('Feature');
ylabel('Normalized value');
title('Parallel Coordinates');
sftStyleLegend(legend(medianHandles, groupNames, 'Location', 'southoutside', ...
    'Orientation', 'horizontal'), theme);
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'parallel_coordinates'), formats);
end
