function [files, report] = renderThreePhaseWaveform(outputDir, formats)
%RENDERTHREEPHASEWAVEFORM Render a synthetic three-phase voltage example.

data = sftExampleData('three_phase_waveform');
theme = sftTheme('FigureSize', [15 8.5]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotLineSeries(ax, data.timeMs, data.values, data.labels, theme);
xlabel(ax, 'Time (ms)');
ylabel(ax, "Voltage (" + data.unit + ")");
title(ax, 'Synthetic Three-Phase Voltage Waveform');
ylim(ax, [-1.15 1.15]);
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'three_phase_waveform'), formats);
end
