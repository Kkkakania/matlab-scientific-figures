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

verifyEqual(testCase, numel(registry), 24);
verifyEqual(testCase, numel(unique(names)), numel(names));
verifyTrue(testCase, any(names == "contour_scatter"));
verifyTrue(testCase, any(names == "parallel_coordinates"));
verifyTrue(testCase, any(names == "sankey_flow"));
verifyTrue(testCase, any(names == "calendar_heatmap"));
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

function testTemplateManifestIncludesFilesAndTags(testCase)
manifest = sftTemplateManifest();

verifyEqual(testCase, numel(manifest), 24);
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
