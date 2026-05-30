function [files, report] = renderDensityScatter(outputDir, formats)
data = sftExampleData('density_scatter');
theme = sftTheme('FigureSize', [12 10]);

[counts, xedges, yedges] = histcounts2(data.x, data.y, 36);
xb = discretize(data.x, xedges);
yb = discretize(data.y, yedges);
valid = ~isnan(xb) & ~isnan(yb);
density = zeros(size(data.x));
density(valid) = counts(sub2ind(size(counts), xb(valid), yb(valid)));

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
scatter(data.x, data.y, 22, density, 'filled', 'MarkerFaceAlpha', 0.78, 'MarkerEdgeColor', 'none');
colormap(sftPalette('sequential', 128));
cb = colorbar;
cb.Label.String = 'Local density';
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
cb.Label.Color = theme.AxisColor;
grid on
xlabel('Variable X');
ylabel('Variable Y');
title('Density Scatter Plot');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'density_scatter'), formats);
end
