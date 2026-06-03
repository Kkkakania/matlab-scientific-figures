function [files, report] = renderRaincloudDistribution(outputDir, formats)
%RENDERRAINCLOUDDISTRIBUTION Render clean-room raincloud-style distributions.

if nargin < 2 || isempty(formats)
    formats = ["png", "svg"];
end

data = sftExampleData('raincloud_distribution');
theme = sftTheme('FigureSize', [14 9]);
colors = sftPalette('main', numel(data.labels));

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
hold(ax, 'on');

for k = 1:numel(data.labels)
    values = data.values(:, k);
    [counts, edges] = histcounts(values, 28, 'Normalization', 'pdf');
    centers = edges(1:end-1) + diff(edges) / 2;
    width = counts ./ max(counts) * 0.34;
    base = k;
    fill(ax, [base * ones(size(width)), base + fliplr(width)], ...
        [centers, fliplr(centers)], colors(k, :), ...
        'FaceAlpha', 0.28, 'EdgeColor', 'none');
    jitter = 0.035 * randn(size(values));
    scatter(ax, base - 0.16 + jitter, values, 12, colors(k, :), ...
        'filled', 'MarkerFaceAlpha', 0.42, 'MarkerEdgeColor', 'none');
    q = localPercentiles(values, [0.25 0.50 0.75]);
    plot(ax, [base - 0.28 base + 0.28], [q(2) q(2)], ...
        'Color', [0.16 0.18 0.20], 'LineWidth', theme.LineWidth + 0.4);
    plot(ax, [base base], [q(1) q(3)], ...
        'Color', [0.16 0.18 0.20], 'LineWidth', theme.LineWidth);
end

xlim(ax, [0.45 numel(data.labels) + 0.55]);
set(ax, 'XTick', 1:numel(data.labels), 'XTickLabel', cellstr(data.labels));
xlabel(ax, 'Group');
ylabel(ax, 'Response');
title(ax, 'Synthetic Raincloud Distribution');
grid(ax, 'on');
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'raincloud_distribution'), formats);
end

function q = localPercentiles(values, probabilities)
values = sort(values(:));
positions = 1 + (numel(values) - 1) * probabilities;
lower = floor(positions);
upper = ceil(positions);
weight = positions - lower;
q = values(lower).' .* (1 - weight) + values(upper).' .* weight;
end
