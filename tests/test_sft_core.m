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

function testApplyThemeUsesWhiteAxesBackground(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);
set(ax, 'Color', [0 0 0]);

sftApplyTheme(ax, sftTheme());

verifyEqual(testCase, get(ax, 'Color'), [1 1 1]);
end

function testTiledFigureCreatesCompactWhiteLayout(testCase)
[fig, layout] = sftTiledFigure(2, 2);
cleanup = onCleanup(@() close(fig));

verifyEqual(testCase, get(fig, 'Visible'), matlab.lang.OnOffSwitchState.off);
verifyEqual(testCase, get(fig, 'Color'), [1 1 1]);
verifyEqual(testCase, layout.GridSize, [2 2]);
verifyEqual(testCase, string(layout.TileSpacing), "compact");
verifyEqual(testCase, string(layout.Padding), "compact");
end

function testStyleLegendUsesReadableTextColor(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
plot(1:3, [1 3 2], 'DisplayName', 'Series A');
leg = legend('Location', 'best');

leg = sftStyleLegend(leg, sftTheme());

verifyEqual(testCase, leg.TextColor, [0.12 0.12 0.12]);
verifyEqual(testCase, string(leg.Box), "off");
end

function testPaletteReturnsRequestedNumberOfRgbRows(testCase)
colors = sftPalette('main', 7);
verifySize(testCase, colors, [7 3]);
verifyGreaterThanOrEqual(testCase, colors, 0);
verifyLessThanOrEqual(testCase, colors, 1);
end

function testDivergingPaletteReturnsRequestedNumberOfRgbRows(testCase)
colors = sftPalette('diverging', 11);
verifySize(testCase, colors, [11 3]);
verifyGreaterThanOrEqual(testCase, colors, 0);
verifyLessThanOrEqual(testCase, colors, 1);
end

function testExampleDataIsDeterministic(testCase)
a = sftExampleData('line');
b = sftExampleData('line');
verifyEqual(testCase, a.x, b.x);
verifyEqual(testCase, a.y, b.y);
end

function testCorrelationBubbleDataIsSymmetric(testCase)
data = sftExampleData('correlation_bubble');

verifyEqual(testCase, size(data.matrix), [9 9]);
verifyEqual(testCase, data.matrix, data.matrix.', 'AbsTol', 1e-12);
verifyEqual(testCase, diag(data.matrix), ones(9, 1), 'AbsTol', 1e-12);
verifyEqual(testCase, numel(data.labels), 9);
end

function testPositiveNegativeAreaDataCrossesZero(testCase)
data = sftExampleData('positive_negative_area');

verifyEqual(testCase, numel(data.x), numel(data.y));
verifyGreaterThan(testCase, max(data.y), 0);
verifyLessThan(testCase, min(data.y), 0);
end

function testGroupedErrorBarDataHasMatchingErrorShape(testCase)
data = sftExampleData('grouped_error_bar');

verifyEqual(testCase, size(data.values), size(data.errors));
verifyGreaterThan(testCase, min(data.errors(:)), 0);
verifyEqual(testCase, numel(data.groups), size(data.values, 1));
verifyEqual(testCase, numel(data.series), size(data.values, 2));
end

function testWaffleDataUsesHundredCells(testCase)
data = sftExampleData('waffle');

verifyEqual(testCase, sum(data.counts), 100);
verifyEqual(testCase, numel(data.labels), numel(data.counts));
verifyEqual(testCase, size(data.colors, 1), numel(data.counts));
verifyEqual(testCase, size(data.colors, 2), 3);
verifyTrue(testCase, all(data.counts > 0));
end

function testButterflyDataHasMatchedPositiveSides(testCase)
data = sftExampleData('butterfly');

verifyEqual(testCase, size(data.left), size(data.right));
verifyEqual(testCase, numel(data.labels), numel(data.left));
verifyTrue(testCase, all(data.left > 0));
verifyTrue(testCase, all(data.right > 0));
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
