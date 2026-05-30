function [files, report] = renderBubbleMatrix(outputDir, formats)
data = sftExampleData('bubble_matrix');
theme = sftTheme('FigureSize', [12 10]);
[r, c] = size(data.matrix);
[xx, yy] = meshgrid(1:c, 1:r);
values = data.matrix(:);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
scatter(xx(:), yy(:), 50 + 520 * values, values, 'filled', ...
    'MarkerFaceAlpha', 0.82, 'MarkerEdgeColor', [1 1 1] * 0.98);
axis equal
xlim([0 c + 1]);
ylim([0 r + 1]);
set(gca, 'YDir', 'reverse', 'XTick', 1:c, 'XTickLabel', data.cols, ...
    'YTick', 1:r, 'YTickLabel', data.rows);
colormap(sftPalette('sequential', 128));
cb = colorbar;
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
grid on
xlabel('Column');
ylabel('Row');
title('Bubble Matrix');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'bubble_matrix'), formats);
end
