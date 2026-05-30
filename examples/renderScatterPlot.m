function files = renderScatterPlot(outputDir, formats)
data = sftExampleData('scatter');
theme = sftTheme('FigureSize', [12 10]);
colors = sftPalette('main', 3);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
groups = categories(data.group);
for k = 1:numel(groups)
    mask = data.group == groups{k};
    scatter(data.x(mask), data.y(mask), theme.MarkerSize, colors(k, :), ...
        'filled', 'MarkerFaceAlpha', 0.72, 'MarkerEdgeColor', 'none');
end
grid on
xlabel('Observed feature');
ylabel('Predicted response');
title('Grouped Scatter Plot');
legend(groups, 'Location', 'best', 'Box', 'off');
sftApplyTheme(gca, theme);

files = sftExport(fig, fullfile(outputDir, 'scatter_plot'), formats);
close(fig);
end
