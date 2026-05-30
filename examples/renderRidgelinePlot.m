function [files, report] = renderRidgelinePlot(outputDir, formats)
data = sftExampleData('ridgeline');
theme = sftTheme('FigureSize', [13 8.5]);
colors = sftPalette('main', numel(data.labels));

values = data.values;
labels = data.labels;
xEdges = linspace(min(values(:)) - 0.4, max(values(:)) + 0.4, 46);
x = (xEdges(1:end - 1) + xEdges(2:end)) / 2;

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
for k = 1:numel(labels)
    density = histcounts(values(:, k), xEdges, 'Normalization', 'pdf');
    density = smoothDensity(density);
    density = density ./ max(density) * 0.72;
    baseline = k;
    fill([x fliplr(x)], [baseline + density, baseline * ones(size(density))], ...
        colors(k, :), ...
        'FaceAlpha', 0.76, ...
        'EdgeColor', 'none');
    plot(x, baseline + density, 'Color', colors(k, :) * 0.75, ...
        'LineWidth', theme.LineWidth);
end

set(gca, ...
    'YTick', 1:numel(labels), ...
    'YTickLabel', labels);
ylim([0.55 numel(labels) + 0.95]);
xlim([min(xEdges) max(xEdges)]);
grid on
xlabel('Value');
ylabel('Group');
title('Ridgeline Plot');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'ridgeline_plot'), formats);
end

function density = smoothDensity(density)
kernel = [1 2 3 2 1] / 9;
density = conv(density, kernel, 'same');
end
