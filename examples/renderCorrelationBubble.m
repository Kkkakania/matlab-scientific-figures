function [files, report] = renderCorrelationBubble(outputDir, formats)
data = sftExampleData('correlation_bubble');
theme = sftTheme('FigureSize', [13 11]);

values = data.matrix;
n = size(values, 1);
[xx, yy] = meshgrid(1:n, 1:n);
markerSizes = 60 + 620 * abs(values(:));

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);

scatter(xx(:), yy(:), markerSizes, values(:), 'filled', ...
    'MarkerFaceAlpha', 0.86, ...
    'MarkerEdgeColor', [0.98 0.98 0.98], ...
    'LineWidth', 0.5);

axis equal
xlim([0.4 n + 0.6]);
ylim([0.4 n + 0.6]);
set(gca, ...
    'YDir', 'reverse', ...
    'XTick', 1:n, ...
    'XTickLabel', data.labels, ...
    'YTick', 1:n, ...
    'YTickLabel', data.labels);
xtickangle(45);
grid on

colormap(sftPalette('diverging', 256));
set(gca, 'CLim', [-1 1]);
cb = colorbar;
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
cb.Label.String = 'Correlation';
cb.Label.FontName = theme.FontName;
cb.Label.Color = theme.AxisColor;

for k = 1:numel(values)
    if abs(values(k)) >= 0.65
        text(xx(k), yy(k), sprintf('%.2f', values(k)), ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle', ...
            'FontName', theme.FontName, ...
            'FontSize', theme.FontSize - 1, ...
            'Color', textColorForValue(values(k)));
    end
end

xlabel('Variable');
ylabel('Variable');
title('Correlation Bubble Heatmap');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'correlation_bubble'), formats);
end

function color = textColorForValue(value)
if abs(value) >= 0.82
    color = [1 1 1];
else
    color = [0.18 0.18 0.18];
end
end
