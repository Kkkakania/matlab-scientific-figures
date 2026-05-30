function files = renderGroupedBar(outputDir, formats)
data = sftExampleData('grouped_bar');
theme = sftTheme('FigureSize', [14 9]);
colors = sftPalette('main', size(data.values, 2));

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
b = bar(data.values, 'grouped');
for k = 1:numel(b)
    b(k).FaceColor = colors(k, :);
    b(k).EdgeColor = 'none';
end
grid on
set(gca, 'XTickLabel', data.groups);
xlabel('Scenario');
ylabel('Score');
title('Grouped Bar Chart');
legend(data.series, 'Location', 'northoutside', 'Orientation', 'horizontal', 'Box', 'off');
sftApplyTheme(gca, theme);

files = sftExport(fig, fullfile(outputDir, 'grouped_bar'), formats);
close(fig);
end
