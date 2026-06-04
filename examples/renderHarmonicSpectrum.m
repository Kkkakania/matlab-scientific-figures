function [files, report] = renderHarmonicSpectrum(outputDir, formats)
%RENDERHARMONICSPECTRUM Render a synthetic power-quality harmonic example.

data = sftExampleData('harmonic_spectrum');
theme = sftTheme('FigureSize', [15 8.5]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotGroupedBar(ax, data.values, data.groups, data.series, theme);
xlabel(ax, 'Harmonic order');
ylabel(ax, 'Relative magnitude (%)');
title(ax, 'Synthetic Harmonic Spectrum Comparison');
ylim(ax, [0 max(data.values(:)) * 1.18]);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'harmonic_spectrum'), formats);
end
