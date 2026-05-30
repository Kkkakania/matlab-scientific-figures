function [files, report] = renderGroupedErrorBar(outputDir, formats)
data = sftExampleData('grouped_error_bar');
theme = sftTheme('FigureSize', [13 8.5]);
colors = sftPalette('main', numel(data.series));

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);

b = bar(data.values, 'grouped', 'EdgeColor', 'none');
hold on
for k = 1:numel(b)
    b(k).FaceColor = colors(k, :);
    errorbar(b(k).XEndPoints, data.values(:, k), data.errors(:, k), ...
        'k', 'LineStyle', 'none', 'LineWidth', 0.9, 'CapSize', 7);
end

set(gca, 'XTick', 1:numel(data.groups), 'XTickLabel', data.groups);
xtickangle(15);
ylim([0 max(data.values(:) + data.errors(:)) * 1.16]);
grid on
xlabel('Method');
ylabel('Score');
title('Grouped Bar With Error Bars');
sftStyleLegend(legend(data.series, 'Location', 'northoutside', ...
    'Orientation', 'horizontal'), theme);
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'grouped_error_bar'), formats);
end
