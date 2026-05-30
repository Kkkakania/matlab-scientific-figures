function [files, report] = renderSurface3D(outputDir, formats)
data = sftExampleData('surface');
theme = sftTheme('FigureSize', [13 10]);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
surf(data.x, data.y, data.z, 'EdgeColor', 'none');
shading interp
colormap(sftPalette('sequential', 128));
cb = colorbar;
cb.Color = theme.AxisColor;
cb.FontName = theme.FontName;
cb.FontSize = theme.FontSize;
view(42, 28);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Surface');
sftApplyTheme(gca, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'surface_3d'), formats);
end
