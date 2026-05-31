function [files, report] = renderCsvExperiment(outputDir, formats)
%RENDERCSVEXPERIMENT Render a bundled CSV as a publication-style figure.

if nargin < 1 || isempty(outputDir)
    outputDir = 'gallery';
end
if nargin < 2 || isempty(formats)
    formats = ["png", "svg"];
end

exampleDir = fileparts(mfilename('fullpath'));
csvPath = fullfile(exampleDir, 'data', 'experiment_signal.csv');
tbl = readtable(csvPath);

theme = sftTheme('FigureSize', [13.5 7.5]);
colors = sftPalette('main', 2);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
plot(tbl.time, tbl.baseline, '-o', ...
    'Color', colors(1, :), ...
    'MarkerFaceColor', colors(1, :), ...
    'MarkerSize', 4.5, ...
    'LineWidth', theme.LineWidth, ...
    'DisplayName', 'Baseline');
plot(tbl.time, tbl.treatment, '-s', ...
    'Color', colors(2, :), ...
    'MarkerFaceColor', colors(2, :), ...
    'MarkerSize', 4.5, ...
    'LineWidth', theme.LineWidth, ...
    'DisplayName', 'Treatment');
hold off

grid on
xlabel('Time (h)');
ylabel('Response');
title('CSV Experiment Signal');
sftApplyTheme(gca, theme);
sftStyleLegend(legend('Location', 'northwest'), theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'csv_experiment_signal'), formats);
end
