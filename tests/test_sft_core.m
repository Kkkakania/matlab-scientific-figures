function tests = test_sft_core
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(projectRoot, 'src')));
end

function testThemeProvidesStableDefaults(testCase)
theme = sftTheme();
verifyEqual(testCase, theme.FontName, 'Arial');
verifyGreaterThan(testCase, theme.LineWidth, 0);
verifyEqual(testCase, numel(theme.FigureSize), 2);
end

function testPaletteReturnsRequestedNumberOfRgbRows(testCase)
colors = sftPalette('main', 7);
verifySize(testCase, colors, [7 3]);
verifyGreaterThanOrEqual(testCase, colors, 0);
verifyLessThanOrEqual(testCase, colors, 1);
end

function testExampleDataIsDeterministic(testCase)
a = sftExampleData('line');
b = sftExampleData('line');
verifyEqual(testCase, a.x, b.x);
verifyEqual(testCase, a.y, b.y);
end

function testExportCreatesRequestedFiles(testCase)
outDir = fullfile(tempdir, 'sft-core-test');
if exist(outDir, 'dir')
    rmdir(outDir, 's');
end
mkdir(outDir);

fig = figure('Visible', 'off');
plot(1:3, [1 4 2]);
files = sftExport(fig, fullfile(outDir, 'simple_plot'), ["png"]);
close(fig);

verifyEqual(testCase, numel(files), 1);
verifyTrue(testCase, isfile(files(1)));
end

function testValidateFigurePassesLabeledPublicationFigure(testCase)
fig = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 640 420]);
cleanup = onCleanup(@() close(fig));

plot(1:4, [1 3 2 5], 'LineWidth', 1.5);
title('Validation Example');
xlabel('Sample');
ylabel('Response');

report = sftValidateFigure(fig);
verifyTrue(testCase, report.Passed);
verifyTrue(testCase, any(string({report.Checks.Name}) == "HasAxes"));
end

function testValidateFigureFlagsMissingLabels(testCase)
fig = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 640 420]);
cleanup = onCleanup(@() close(fig));
plot(1:4, [1 3 2 5]);

report = sftValidateFigure(fig);
failedNames = string({report.Checks(~[report.Checks.Passed]).Name});

verifyFalse(testCase, report.Passed);
verifyTrue(testCase, any(failedNames == "HasTitle"));
verifyTrue(testCase, any(failedNames == "HasAxisLabels"));
end

function testValidateFigureHandlesCentimeterSizedFigures(testCase)
fig = figure('Visible', 'off', 'Color', 'w', ...
    'Units', 'centimeters', 'Position', [1 1 15 9]);
cleanup = onCleanup(@() close(fig));

plot(1:4, [1 3 2 5], 'LineWidth', 1.5);
title('Centimeter Figure');
xlabel('Sample');
ylabel('Response');

report = sftValidateFigure(fig);
failedNames = string({report.Checks(~[report.Checks.Passed]).Name});

verifyTrue(testCase, report.Passed);
verifyFalse(testCase, any(failedNames == "FigureSize"));
end
