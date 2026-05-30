function files = renderBoxJitter(outputDir, formats)
data = sftExampleData('box_jitter');
theme = sftTheme('FigureSize', [12 9]);
colors = sftPalette('main', 4);
groupIndex = double(data.group);
jitter = (rand(size(groupIndex)) - 0.5) * 0.22;

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
boxchart(data.group, data.value, 'BoxFaceColor', [0.82 0.86 0.90], ...
    'MarkerStyle', 'none', 'LineWidth', theme.LineWidth);
hold on
for k = 1:4
    mask = groupIndex == k;
    scatter(groupIndex(mask) + jitter(mask), data.value(mask), 26, colors(k, :), ...
        'filled', 'MarkerFaceAlpha', 0.60, 'MarkerEdgeColor', 'none');
end
grid on
xlabel('Group');
ylabel('Measurement');
title('Box Plot With Jittered Points');
sftApplyTheme(gca, theme);

files = sftExport(fig, fullfile(outputDir, 'box_jitter'), formats);
close(fig);
end
