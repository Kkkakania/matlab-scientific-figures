function [files, report] = renderDoubleTriangleHeatmap(outputDir, formats)
data = sftExampleData('double_triangle_heatmap');
theme = sftTheme('FigureSize', [13 11]);

upperValues = data.upper;
lowerValues = data.lower;
labels = data.labels;
n = size(upperValues, 1);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
hold(ax, 'on');

for row = 1:n
    for col = 1:n
        drawCellTriangle(ax, row, col, upperValues(row, col), "upper");
        drawCellTriangle(ax, row, col, lowerValues(row, col), "lower");
    end
end

axis(ax, 'equal');
xlim(ax, [0.5 n + 0.5]);
ylim(ax, [0.5 n + 0.5]);
set(ax, ...
    'YDir', 'reverse', ...
    'XTick', 1:n, ...
    'XTickLabel', labels, ...
    'YTick', 1:n, ...
    'YTickLabel', labels, ...
    'Layer', 'top');
xtickangle(ax, 45);
box(ax, 'on');
grid(ax, 'off');

colormap(ax, sftPalette('diverging', 256));
set(ax, 'CLim', [-1 1]);
cb = colorbar(ax);
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
cb.Label.String = 'Correlation';
cb.Label.FontName = theme.FontName;
cb.Label.Color = theme.AxisColor;

xlabel(ax, 'Metric');
ylabel(ax, 'Metric');
title(ax, {'Double-Triangle Heatmap'; 'Upper: condition A | Lower: condition B'});
sftApplyTheme(ax, theme);
set(ax.Title, 'FontSize', theme.FontSize + 1);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'double_triangle_heatmap'), formats);
end

function drawCellTriangle(ax, row, col, value, half)
left = col - 0.5;
right = col + 0.5;
top = row - 0.5;
bottom = row + 0.5;

if half == "upper"
    x = [left right right];
    y = [top top bottom];
else
    x = [left left right];
    y = [top bottom bottom];
end

patch(ax, x, y, value, ...
    'FaceColor', 'flat', ...
    'EdgeColor', [1 1 1], ...
    'LineWidth', 0.35);
end
