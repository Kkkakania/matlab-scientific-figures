function [files, report] = renderCalendarHeatmap(outputDir, formats)
data = sftExampleData('calendar_heatmap');
theme = sftTheme('FigureSize', [13.5 7.5], 'FontSize', 9);

values = data.table.Value;
dayCount = numel(data.dayLabels);
weekCount = numel(data.weekLabels);
gridValues = reshape(values, dayCount, weekCount);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
imagesc(gridValues);
axis equal tight
colormap(sftPalette('sequential', 128));
clim([min(values) max(values)]);
cb = colorbar;
cb.Label.String = 'Daily value';
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
cb.Label.Color = theme.AxisColor;
set(gca, ...
    'XTick', 1:weekCount, ...
    'XTickLabel', data.weekLabels, ...
    'YTick', 1:dayCount, ...
    'YTickLabel', data.dayLabels, ...
    'YDir', 'reverse', ...
    'TickLength', [0 0]);
grid on
xlabel('Week');
ylabel('Day');
title('Calendar Heatmap');
sftApplyTheme(gca, theme);
set(gca, 'GridColor', [1 1 1], 'GridAlpha', 0.72, 'Layer', 'top');

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'calendar_heatmap'), formats);
end
