function [files, report] = renderSurface3D(outputDir, formats)
data = sftExampleData('surface');
theme = sftTheme('FigureSize', [13 10]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotSurface3D(ax, data.x, data.y, data.z, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'surface_3d'), formats);
end
