function [files, report] = renderContourScatter(outputDir, formats)
data = sftExampleData('contour_scatter');
theme = sftTheme('FigureSize', [12 8]);

xEdges = linspace(min(data.x) - 0.25, max(data.x) + 0.25, 34);
yEdges = linspace(min(data.y) - 0.25, max(data.y) + 0.25, 34);
density = histcounts2(data.x, data.y, xEdges, yEdges);
density = smoothDensity(density);
xCenters = binCenters(xEdges);
yCenters = binCenters(yEdges);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
contourf(xCenters, yCenters, density.', 8, 'LineColor', 'none');
hold on
scatter(data.x, data.y, 13, [0.08 0.18 0.28], 'filled', ...
    'MarkerFaceAlpha', 0.24, ...
    'MarkerEdgeAlpha', 0.10);
contour(xCenters, yCenters, density.', 6, ...
    'LineColor', [0.08 0.18 0.28], ...
    'LineWidth', 0.7);

colormap(sftPalette('sequential', 64));
cb = colorbar;
cb.Label.String = 'Local density';
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;

xlabel('Feature X');
ylabel('Feature Y');
title('Contour Scatter');
grid on
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'contour_scatter'), formats);
end

function centers = binCenters(edges)
centers = (edges(1:end - 1) + edges(2:end)) / 2;
end

function density = smoothDensity(density)
kernel = [1 2 1; 2 4 2; 1 2 1] / 16;
density = conv2(density, kernel, 'same');
end
