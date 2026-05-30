function [files, report] = renderHeatmap(outputDir, formats)
data = sftExampleData('heatmap');
theme = sftTheme('FigureSize', [12 10]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
imagesc(data.matrix);
axis equal tight
colormap(sftPalette('sequential', 128));
cb = colorbar;
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
set(gca, 'XTick', 1:numel(data.labels), 'XTickLabel', data.labels, ...
    'YTick', 1:numel(data.labels), 'YTickLabel', data.labels);
xtickangle(45);
xlabel('Feature');
ylabel('Feature');
title('Matrix Heatmap');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'heatmap'), formats);
end
