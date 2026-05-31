function tests = test_sft_core
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(projectRoot, 'src')));
addpath(genpath(fullfile(projectRoot, 'examples')));
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

function testMainPaletteKeepsEightCategoriesSeparated(testCase)
colors = sftPalette('main', 8);
minDistance = inf;
for row = 1:size(colors, 1)
    for other = row + 1:size(colors, 1)
        distance = sqrt(sum((colors(row, :) - colors(other, :)) .^ 2));
        minDistance = min(minDistance, distance);
    end
end

verifyGreaterThan(testCase, minDistance, 0.25);
end

function testMainPaletteAvoidsEarlyNeutralGray(testCase)
colors = sftPalette('main', 8);
channelRange = max(colors(1:7, :), [], 2) - min(colors(1:7, :), [], 2);

verifyGreaterThan(testCase, channelRange, 0.2);
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

function testRidgelineDataHasOneColumnPerLabel(testCase)
data = sftExampleData('ridgeline');

verifyEqual(testCase, size(data.values, 2), numel(data.labels));
verifyGreaterThan(testCase, size(data.values, 1), 50);
verifyTrue(testCase, all(isfinite(data.values(:))));
end

function testRadarDataIsNormalized(testCase)
data = sftExampleData('radar');

verifyEqual(testCase, size(data.values, 1), numel(data.series));
verifyEqual(testCase, size(data.values, 2), numel(data.metrics));
verifyGreaterThanOrEqual(testCase, data.values, 0);
verifyLessThanOrEqual(testCase, data.values, 1);
end

function testParallelCoordinatesDataHasNamedFeaturesAndClasses(testCase)
data = sftExampleData('parallel_coordinates');

verifyEqual(testCase, size(data.values, 2), numel(data.features));
verifyEqual(testCase, size(data.values, 1), numel(data.groups));
verifyGreaterThan(testCase, numel(unique(data.groups)), 1);
verifyGreaterThanOrEqual(testCase, data.values, 0);
verifyLessThanOrEqual(testCase, data.values, 1);
end

function testSankeyFlowDataUsesPositiveEdgeTable(testCase)
data = sftExampleData('sankey_flow');

verifyEqual(testCase, data.edges.Properties.VariableNames, {'Source', 'Target', 'Weight'});
verifyGreaterThan(testCase, height(data.edges), 5);
verifyTrue(testCase, all(strlength(data.edges.Source) > 0));
verifyTrue(testCase, all(strlength(data.edges.Target) > 0));
verifyTrue(testCase, all(data.edges.Weight > 0));
verifyGreaterThan(testCase, numel(unique([data.edges.Source; data.edges.Target])), 5);
end

function testCalendarHeatmapDataUsesDailyValues(testCase)
data = sftExampleData('calendar_heatmap');

verifyEqual(testCase, height(data.table), 84);
verifyEqual(testCase, data.table.Properties.VariableNames, {'Date', 'Value'});
verifyTrue(testCase, isdatetime(data.table.Date));
verifyTrue(testCase, all(isfinite(data.table.Value)));
verifyEqual(testCase, days(diff(data.table.Date(1:2))), 1);
verifyGreaterThan(testCase, max(data.table.Value), min(data.table.Value));
end

function testPairedSlopegraphDataHasMatchedBeforeAfterValues(testCase)
data = sftExampleData('paired_slopegraph');

verifyEqual(testCase, numel(data.labels), numel(data.before));
verifyEqual(testCase, numel(data.labels), numel(data.after));
verifyTrue(testCase, all(isfinite(data.before)));
verifyTrue(testCase, all(isfinite(data.after)));
verifyGreaterThan(testCase, max(abs(data.after - data.before)), 0);
verifyGreaterThan(testCase, strlength(data.beforeLabel), 0);
verifyGreaterThan(testCase, strlength(data.afterLabel), 0);
end

function testUncertaintyFanDataHasOrderedBands(testCase)
data = sftExampleData('uncertainty_fan_chart');

verifyEqual(testCase, numel(data.x), numel(data.median));
verifyEqual(testCase, numel(data.x), numel(data.p10));
verifyEqual(testCase, numel(data.x), numel(data.p90));
verifyTrue(testCase, all(data.p10 <= data.p25));
verifyTrue(testCase, all(data.p25 <= data.median));
verifyTrue(testCase, all(data.median <= data.p75));
verifyTrue(testCase, all(data.p75 <= data.p90));
end

function testTernaryScatterDataUsesClosedCompositions(testCase)
data = sftExampleData('ternary_scatter');

verifyEqual(testCase, data.table.Properties.VariableNames, {'A', 'B', 'C', 'Group'});
verifyGreaterThan(testCase, height(data.table), 30);
totals = data.table.A + data.table.B + data.table.C;
verifyEqual(testCase, totals, ones(size(totals)), 'AbsTol', 1e-12);
verifyGreaterThanOrEqual(testCase, data.table{:, {'A', 'B', 'C'}}, 0);
verifyEqual(testCase, numel(data.componentLabels), 3);
verifyGreaterThan(testCase, numel(categories(data.table.Group)), 1);
end

function testForestPlotDataHasOrderedIntervals(testCase)
data = sftExampleData('forest_plot');

verifyEqual(testCase, numel(data.labels), numel(data.estimate));
verifyEqual(testCase, numel(data.labels), numel(data.lower));
verifyEqual(testCase, numel(data.labels), numel(data.upper));
verifyTrue(testCase, all(data.lower <= data.estimate));
verifyTrue(testCase, all(data.estimate <= data.upper));
verifyTrue(testCase, any(data.lower < data.reference & data.upper > data.reference));
end

function testWaterfallDataHasStartStepsAndFinalValue(testCase)
data = sftExampleData('waterfall_chart');

verifyEqual(testCase, numel(data.labels), numel(data.steps));
verifyTrue(testCase, all(isfinite(data.steps)));
verifyEqual(testCase, data.final, data.start + sum(data.steps), 'AbsTol', 1e-12);
verifyGreaterThan(testCase, data.final, 0);
end

function testPlotHeatmapDrawsIntoProvidedAxes(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

returnedAx = sftPlotHeatmap(ax, [1 0.2; 0.2 1], ["A", "B"], sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyEqual(testCase, numel(findobj(ax, 'Type', 'Image')), 1);
verifyEqual(testCase, string(ax.XTickLabel(:)), ["A"; "B"]);
verifyEqual(testCase, string(ax.YTickLabel(:)), ["A"; "B"]);
verifyEqual(testCase, char(ax.Title.String), 'Matrix Heatmap');
end

function testPlotHeatmapRejectsMismatchedLabels(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotHeatmap(ax, eye(2), "A", sftTheme()), ...
    'sft:InvalidLabels');
end

function testPlotLineSeriesDrawsOneLinePerRow(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

[returnedAx, lineHandles] = sftPlotLineSeries(ax, 1:3, [1 2 3; 3 2 1], ...
    ["Up", "Down"], sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyEqual(testCase, numel(lineHandles), 2);
verifyTrue(testCase, all(isgraphics(lineHandles, 'line')));
verifyEqual(testCase, numel(findobj(ax, 'Type', 'Line')), 2);
verifyEqual(testCase, string(legend(ax).String(:)), ["Up"; "Down"]);
end

function testPlotLineSeriesRejectsMismatchedShape(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotLineSeries(ax, 1:3, [1 2; 2 3], ...
    ["A", "B"], sftTheme()), 'sft:InvalidData');
end

function testPlotConfidenceBandDrawsLinesAndBands(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);
x = 1:3;
center = [1 2 3; 2 3 4];
lower = center - 0.2;
upper = center + 0.2;

[returnedAx, lineHandles, bandHandles] = sftPlotConfidenceBand(ax, x, center, ...
    lower, upper, ["A", "B"], sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyEqual(testCase, numel(lineHandles), 2);
verifyEqual(testCase, numel(bandHandles), 2);
verifyTrue(testCase, all(isgraphics(lineHandles, 'line')));
verifyTrue(testCase, all(isgraphics(bandHandles, 'patch')));
verifyEqual(testCase, string(legend(ax).String(:)), ["A"; "B"]);
end

function testPlotConfidenceBandRejectsInvertedBounds(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotConfidenceBand(ax, 1:2, [1 2], [2 3], ...
    [1 2], "A", sftTheme()), 'sft:InvalidData');
end

function testPlotGroupedScatterDrawsOneHandlePerGroup(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

[returnedAx, pointHandles] = sftPlotGroupedScatter(ax, [1 2 3 4], [4 3 2 1], ...
    ["A", "A", "B", "B"], sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyEqual(testCase, numel(pointHandles), 2);
verifyTrue(testCase, all(isgraphics(pointHandles, 'scatter')));
verifyEqual(testCase, string(legend(ax).String(:)), ["A"; "B"]);
end

function testPlotGroupedScatterRejectsLengthMismatch(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotGroupedScatter(ax, [1 2], [1 2], "A", ...
    sftTheme()), 'sft:InvalidData');
end

function testPlotDensityScatterReturnsDensityForEachPoint(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

[returnedAx, pointHandle, density] = sftPlotDensityScatter(ax, [1 1 2 3], ...
    [1 1 2 3], 3, sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyTrue(testCase, isgraphics(pointHandle, 'scatter'));
verifyEqual(testCase, numel(density), 4);
verifyGreaterThan(testCase, max(density), min(density));
verifyEqual(testCase, numel(findall(fig, 'Type', 'ColorBar')), 1);
end

function testPlotDensityScatterRejectsInvalidBins(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotDensityScatter(ax, [1 2], [1 2], 1, ...
    sftTheme()), 'sft:InvalidBins');
end

function testPlotCorrelationBubbleDrawsMatrixBubbles(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);
matrix = [1 0.72; 0.72 1];

[returnedAx, pointHandle, textHandles] = sftPlotCorrelationBubble(ax, matrix, ...
    ["A", "B"], sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyTrue(testCase, isgraphics(pointHandle, 'scatter'));
verifyEqual(testCase, numel(pointHandle.SizeData), 4);
verifyEqual(testCase, numel(textHandles), 4);
verifyEqual(testCase, string(ax.XTickLabel(:)), ["A"; "B"]);
verifyEqual(testCase, string(ax.YTickLabel(:)), ["A"; "B"]);
verifyEqual(testCase, ax.CLim, [-1 1]);
end

function testPlotCorrelationBubbleRejectsOutOfRangeValues(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotCorrelationBubble(ax, [1 1.2; 1.2 1], ...
    ["A", "B"], sftTheme()), 'sft:InvalidMatrix');
end

function testPlotForestDrawsIntervalsPointsAndLabels(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

[returnedAx, pointHandles, intervalHandles, labelHandles] = sftPlotForest(ax, ...
    [-0.1 0.2], [-0.3 0.1], [0.05 0.35], ["A", "B"], 0, sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyEqual(testCase, numel(pointHandles), 2);
verifyEqual(testCase, numel(intervalHandles), 2);
verifyEqual(testCase, numel(labelHandles), 2);
verifyTrue(testCase, all(isgraphics(pointHandles, 'scatter')));
verifyTrue(testCase, all(isgraphics(intervalHandles, 'line')));
verifyTrue(testCase, all(isgraphics(labelHandles, 'text')));
verifyEqual(testCase, string(ax.YTickLabel(:)), ["A"; "B"]);
verifyEqual(testCase, string(ax.YDir), "reverse");
end

function testPlotForestRejectsInvalidIntervals(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotForest(ax, 0.2, 0.3, 0.4, "A", 0, ...
    sftTheme()), 'sft:InvalidData');
end

function testPlotGroupedErrorBarDrawsBarsAndErrors(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

[returnedAx, barHandles, errorHandles] = sftPlotGroupedErrorBar(ax, ...
    [1 2; 3 4], [0.1 0.2; 0.3 0.4], ["A", "B"], ["S1", "S2"], sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyEqual(testCase, numel(barHandles), 2);
verifyEqual(testCase, numel(errorHandles), 2);
verifyTrue(testCase, all(isgraphics(barHandles, 'bar')));
verifyTrue(testCase, all(isgraphics(errorHandles, 'errorbar')));
verifyEqual(testCase, string(ax.XTickLabel(:)), ["A"; "B"]);
verifyEqual(testCase, string(legend(ax).String(:)), ["S1"; "S2"]);
end

function testPlotGroupedErrorBarRejectsMismatchedErrors(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotGroupedErrorBar(ax, [1 2], [0.1; 0.2], ...
    "A", ["S1", "S2"], sftTheme()), 'sft:InvalidData');
end

function testPlotBoxJitterDrawsBoxAndPointGroups(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

[returnedAx, boxHandle, pointHandles] = sftPlotBoxJitter(ax, ...
    ["A", "A", "B", "B"], [1 2 3 4], sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyTrue(testCase, isgraphics(boxHandle));
verifyEqual(testCase, numel(pointHandles), 2);
verifyTrue(testCase, all(isgraphics(pointHandles, 'scatter')));
verifyEqual(testCase, string(ax.XLabel.String), "Group");
verifyEqual(testCase, string(ax.YLabel.String), "Measurement");
end

function testPlotBoxJitterRejectsLengthMismatch(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotBoxJitter(ax, ["A", "B"], 1, sftTheme()), ...
    'sft:InvalidData');
end

function testPlotLollipopRankingSortsValuesAscending(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

[returnedAx, lineHandles, pointHandles, order] = sftPlotLollipopRanking(ax, ...
    ["High", "Low", "Mid"], [0.9 0.2 0.5], sftTheme());

verifyEqual(testCase, returnedAx, ax);
verifyEqual(testCase, order, [2; 3; 1]);
verifyEqual(testCase, numel(lineHandles), 3);
verifyEqual(testCase, numel(pointHandles), 3);
verifyTrue(testCase, all(isgraphics(lineHandles, 'line')));
verifyTrue(testCase, all(isgraphics(pointHandles, 'scatter')));
verifyEqual(testCase, string(ax.YTickLabel(:)), ["Low"; "Mid"; "High"]);
end

function testPlotLollipopRankingRejectsMismatchedInputs(testCase)
fig = figure('Visible', 'off', 'Color', 'w');
cleanup = onCleanup(@() close(fig));
ax = axes(fig);

verifyError(testCase, @() sftPlotLollipopRanking(ax, ["A", "B"], 1, ...
    sftTheme()), 'sft:InvalidData');
end

function testBundledCsvExampleHasExpectedColumns(testCase)
projectRoot = fileparts(fileparts(mfilename('fullpath')));
csvPath = fullfile(projectRoot, 'examples', 'data', 'experiment_signal.csv');

verifyTrue(testCase, isfile(csvPath));
tbl = readtable(csvPath);

verifyEqual(testCase, tbl.Properties.VariableNames, {'time', 'baseline', 'treatment'});
verifyGreaterThan(testCase, height(tbl), 10);
verifyTrue(testCase, all(isfinite(tbl.time)));
verifyTrue(testCase, all(isfinite(tbl.baseline)));
verifyTrue(testCase, all(isfinite(tbl.treatment)));
end

function testCsvExperimentRendererExportsPng(testCase)
outputDir = tempname;
mkdir(outputDir);
cleanup = onCleanup(@() rmdir(outputDir, 's'));

files = renderCsvExperiment(outputDir, "png");

verifyEqual(testCase, numel(files), 1);
verifyTrue(testCase, isfile(fullfile(outputDir, 'csv_experiment_signal.png')));
end

function testBlandAltmanDataHasAgreementStatistics(testCase)
data = sftExampleData('bland_altman_plot');

verifyEqual(testCase, numel(data.methodA), numel(data.methodB));
verifyGreaterThan(testCase, numel(data.methodA), 50);
verifyEqual(testCase, data.meanValues, (data.methodA + data.methodB) ./ 2, 'AbsTol', 1e-12);
verifyEqual(testCase, data.differences, data.methodB - data.methodA, 'AbsTol', 1e-12);
verifyEqual(testCase, data.bias, mean(data.differences), 'AbsTol', 1e-12);
verifyGreaterThan(testCase, data.upperLimit, data.bias);
verifyLessThan(testCase, data.lowerLimit, data.bias);
end

function testContourScatterDataHasDensePairedCoordinates(testCase)
data = sftExampleData('contour_scatter');

verifyEqual(testCase, numel(data.x), numel(data.y));
verifyGreaterThan(testCase, numel(data.x), 300);
verifyTrue(testCase, all(isfinite(data.x)));
verifyTrue(testCase, all(isfinite(data.y)));
end

function testTemplateRegistryDefinesGalleryExamples(testCase)
registry = sftTemplateRegistry();
names = string({registry.Name}).';

verifyEqual(testCase, numel(registry), 30);
verifyEqual(testCase, numel(unique(names)), numel(names));
verifyTrue(testCase, any(names == "contour_scatter"));
verifyTrue(testCase, any(names == "parallel_coordinates"));
verifyTrue(testCase, any(names == "sankey_flow"));
verifyTrue(testCase, any(names == "calendar_heatmap"));
verifyTrue(testCase, any(names == "paired_slopegraph"));
verifyTrue(testCase, any(names == "uncertainty_fan_chart"));
verifyTrue(testCase, any(names == "ternary_scatter"));
verifyTrue(testCase, any(names == "forest_plot"));
verifyTrue(testCase, any(names == "waterfall_chart"));
verifyTrue(testCase, any(names == "bland_altman_plot"));
verifyTrue(testCase, all(arrayfun(@(item) isa(item.Renderer, 'function_handle'), registry)));
verifyTrue(testCase, all(arrayfun(@(item) strlength(item.Task) > 0, registry)));
verifyTrue(testCase, all(arrayfun(@(item) ~isempty(item.Tags), registry)));
end

function testListTemplatesReturnsUserFacingTable(testCase)
registry = sftTemplateRegistry();

templates = sftListTemplates();

verifyEqual(testCase, height(templates), numel(registry));
verifyEqual(testCase, templates.Properties.VariableNames, ...
    {'Name', 'OutputName', 'Task', 'Tags'});
verifyTrue(testCase, all(strlength(templates.Name) > 0));
verifyTrue(testCase, all(strlength(templates.Task) > 0));
verifyTrue(testCase, any(templates.Name == "double_triangle_heatmap"));
verifyTrue(testCase, any(contains(templates.Tags, "matrix")));
end

function testListTagsReturnsTagCounts(testCase)
tags = sftListTags();

verifyEqual(testCase, tags.Properties.VariableNames, {'Tag', 'Count'});
verifyTrue(testCase, all(strlength(tags.Tag) > 0));
verifyTrue(testCase, all(tags.Count > 0));
verifyTrue(testCase, any(tags.Tag == "matrix"));
verifyTrue(testCase, any(tags.Tag == "comparison"));
verifyGreaterThanOrEqual(testCase, tags.Count(tags.Tag == "matrix"), 4);
end

function testFindTemplatesSearchesNamesTasksAndTags(testCase)
matrixTemplates = sftFindTemplates("matrix");
denseTemplates = sftFindTemplates(["density", "contour"]);
insetTemplates = sftFindTemplates("inset");

verifyTrue(testCase, all(contains(lower(matrixTemplates.Tags), "matrix") | ...
    contains(lower(matrixTemplates.Task), "matrix") | ...
    contains(lower(matrixTemplates.Name), "matrix")));
verifyTrue(testCase, any(matrixTemplates.Name == "double_triangle_heatmap"));
verifyTrue(testCase, any(denseTemplates.Name == "density_scatter"));
verifyTrue(testCase, any(denseTemplates.Name == "contour_scatter"));
verifyEqual(testCase, insetTemplates.Name, "zoomed_inset_line");
end

function testFindTemplatesByTagMatchesExactTags(testCase)
matrixTemplates = sftFindTemplatesByTag("matrix");
agreementTemplates = sftFindTemplatesByTag("agreement");
combinedTemplates = sftFindTemplatesByTag(["waterfall", "agreement"]);

verifyTrue(testCase, any(matrixTemplates.Name == "heatmap"));
verifyTrue(testCase, any(matrixTemplates.Name == "double_triangle_heatmap"));
verifyFalse(testCase, any(matrixTemplates.Name == "bland_altman_plot"));
verifyEqual(testCase, agreementTemplates.Name, "bland_altman_plot");
verifyTrue(testCase, any(combinedTemplates.Name == "waterfall_chart"));
verifyTrue(testCase, any(combinedTemplates.Name == "bland_altman_plot"));
end

function testTemplateInfoReturnsSingleTemplateMetadata(testCase)
info = sftTemplateInfo("heatmap");

verifyEqual(testCase, info.Name, "heatmap");
verifyEqual(testCase, info.RendererName, "renderHeatmap");
verifyEqual(testCase, info.ExampleFile, "examples/renderHeatmap.m");
verifyEqual(testCase, info.PngFile, "gallery/heatmap.png");
verifyTrue(testCase, any(info.Tags == "matrix"));
end

function testTemplateInfoRejectsUnknownTemplate(testCase)
verifyError(testCase, @() sftTemplateInfo("not_a_template"), ...
    'sft:UnknownTemplate');
end

function testTemplateManifestIncludesFilesAndTags(testCase)
manifest = sftTemplateManifest();

verifyEqual(testCase, numel(manifest), 30);
verifyTrue(testCase, isfield(manifest, 'Name'));
verifyTrue(testCase, isfield(manifest, 'RendererName'));
verifyTrue(testCase, isfield(manifest, 'ExampleFile'));
verifyTrue(testCase, isfield(manifest, 'PngFile'));
verifyTrue(testCase, isfield(manifest, 'SvgFile'));

names = string({manifest.Name});
linePlot = manifest(names == "line_plot");

verifyEqual(testCase, string(linePlot.RendererName), "renderLinePlot");
verifyEqual(testCase, string(linePlot.ExampleFile), "examples/renderLinePlot.m");
verifyEqual(testCase, string(linePlot.PngFile), "gallery/line_plot.png");
verifyEqual(testCase, string(linePlot.SvgFile), "gallery/line_plot.svg");
verifyTrue(testCase, any(string(linePlot.Tags) == "trend"));
end

function testWriteTemplateManifestCreatesJsonFile(testCase)
outFile = fullfile(tempdir, 'sft-template-manifest-test.json');
if isfile(outFile)
    delete(outFile);
end

writtenFile = sftWriteTemplateManifest(outFile);
text = fileread(writtenFile);

verifyTrue(testCase, isfile(outFile));
verifyTrue(testCase, contains(text, '"Name":"line_plot"'));
verifyTrue(testCase, contains(text, '"PngFile":"gallery/line_plot.png"'));
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

function testExportSanitizesSvgMetadata(testCase)
outDir = fullfile(tempdir, 'sft-svg-export-test');
if exist(outDir, 'dir')
    rmdir(outDir, 's');
end
mkdir(outDir);

fig = figure('Visible', 'off');
plot(1:3, [1 4 2]);
title('SVG Metadata Example');
xlabel('Sample');
ylabel('Value');
files = sftExport(fig, fullfile(outDir, 'metadata_example'), ["svg"]);
close(fig);

svgText = fileread(files(1));
verifyTrue(testCase, contains(svgText, '<desc>Clean-room gallery output</desc>'));
vendorName = ['Math' 'Works'];
verifyFalse(testCase, contains(svgText, vendorName));
verifyEmpty(testCase, regexp(svgText, '[ \t]+\n', 'once'));
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
