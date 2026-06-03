function [files, report] = renderDirectionalRose(outputDir, formats)
%RENDERDIRECTIONALROSE Render a synthetic directional-frequency rose example.

data = sftExampleData('directional_rose');
theme = sftTheme('FigureSize', [12 12]);
colors = sftPalette('sequential', numel(data.frequency));

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
hold(ax, 'on');

maxFrequency = max(data.frequency);
maxRadius = 1;
ringRadii = [0.25 0.50 0.75 1.00];
thetaCircle = linspace(0, 2 * pi, 240);
for radius = ringRadii
    plot(ax, radius * cos(thetaCircle), radius * sin(thetaCircle), ...
        'Color', [0.86 0.88 0.90], 'LineWidth', 0.6);
end

directions = data.directionDegrees;
binWidth = median(diff([directions, directions(1) + 360])) * 0.84;
for k = 1:numel(directions)
    radius = sqrt(data.frequency(k) / maxFrequency) * maxRadius;
    angles = linspace(directions(k) - binWidth / 2, directions(k) + binWidth / 2, 18);
    theta = deg2rad(90 - angles);
    x = [0, radius * cos(theta), 0];
    y = [0, radius * sin(theta), 0];
    fill(ax, x, y, colors(k, :), ...
        'EdgeColor', [1 1 1], ...
        'LineWidth', 0.8, ...
        'FaceAlpha', 0.92);
end

cardinalDirections = 0:45:315;
for k = 1:numel(cardinalDirections)
    theta = deg2rad(90 - cardinalDirections(k));
    plot(ax, [0 1.06 * cos(theta)], [0 1.06 * sin(theta)], ...
        'Color', [0.90 0.91 0.93], 'LineWidth', 0.5);
    text(ax, 1.16 * cos(theta), 1.16 * sin(theta), data.directionLabels(k), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontName', theme.FontName, ...
        'FontSize', theme.FontSize, ...
        'Color', [0.20 0.22 0.24]);
end

peakLabel = sprintf('Peak %.1f%%', 100 * maxFrequency);
text(ax, 0, -1.24, peakLabel, ...
    'HorizontalAlignment', 'center', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize - 1, ...
    'Color', [0.30 0.32 0.34]);

axis(ax, 'equal');
xlim(ax, [-1.28 1.28]);
ylim(ax, [-1.32 1.28]);
set(ax, 'XTick', [], 'YTick', [], 'Box', 'off');
xlabel(ax, 'East-West component');
ylabel(ax, 'North-South component');
title(ax, 'Synthetic Directional Frequency Rose');
sftApplyTheme(ax, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'directional_rose'), formats);
end
