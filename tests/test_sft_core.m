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
