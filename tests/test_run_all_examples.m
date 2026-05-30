function tests = test_run_all_examples
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(projectRoot, 'src')));
addpath(genpath(fullfile(projectRoot, 'examples')));
end

function testRunAllExamplesCreatesTwentySevenPngFiles(testCase)
outDir = fullfile(tempdir, 'sft-gallery-test');
if exist(outDir, 'dir')
    rmdir(outDir, 's');
end

result = runAllExamples(outDir, ["png"]);
pngFiles = dir(fullfile(outDir, '*.png'));

verifyEqual(testCase, numel(result), 27);
verifyEqual(testCase, numel(pngFiles), 27);
verifyTrue(testCase, isfile(fullfile(outDir, 'contour_scatter.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'parallel_coordinates.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'sankey_flow.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'calendar_heatmap.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'paired_slopegraph.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'uncertainty_fan_chart.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'ternary_scatter.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'radar_chart.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'ridgeline_plot.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'butterfly_comparison.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'waffle_chart.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'correlation_bubble.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'double_triangle_heatmap.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'zoomed_inset_line.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'multi_panel_overview.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'positive_negative_area.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'grouped_error_bar.png')));
verifyTrue(testCase, all(arrayfun(@(item) item.report.Passed, result)));
end

function testGalleryReportMarksAllExamplesPassed(testCase)
outDir = fullfile(tempdir, 'sft-gallery-report-test');
if exist(outDir, 'dir')
    rmdir(outDir, 's');
end

report = sftGalleryReport(outDir, ["png"]);

verifyEqual(testCase, height(report), 27);
verifyTrue(testCase, all(report.Passed));
verifyTrue(testCase, any(report.Example == "contour_scatter"));
verifyTrue(testCase, any(report.Example == "parallel_coordinates"));
verifyTrue(testCase, any(report.Example == "sankey_flow"));
verifyTrue(testCase, any(report.Example == "calendar_heatmap"));
verifyTrue(testCase, any(report.Example == "paired_slopegraph"));
verifyTrue(testCase, any(report.Example == "uncertainty_fan_chart"));
verifyTrue(testCase, any(report.Example == "ternary_scatter"));
verifyTrue(testCase, any(report.Example == "radar_chart"));
verifyTrue(testCase, any(report.Example == "ridgeline_plot"));
verifyTrue(testCase, any(report.Example == "butterfly_comparison"));
verifyTrue(testCase, any(report.Example == "waffle_chart"));
verifyTrue(testCase, any(report.Example == "double_triangle_heatmap"));
verifyTrue(testCase, any(report.Example == "zoomed_inset_line"));
verifyTrue(testCase, any(report.Example == "multi_panel_overview"));
verifyTrue(testCase, any(report.Example == "positive_negative_area"));
verifyTrue(testCase, any(report.Example == "grouped_error_bar"));
end

function testRenderExamplesCreatesOnlySelectedOutputs(testCase)
outDir = fullfile(tempdir, 'sft-selected-gallery-test');
if exist(outDir, 'dir')
    rmdir(outDir, 's');
end

result = sftRenderExamples(["heatmap", "radar_chart"], outDir, ["png"]);
pngFiles = dir(fullfile(outDir, '*.png'));

verifyEqual(testCase, numel(result), 2);
verifyEqual(testCase, numel(pngFiles), 2);
verifyTrue(testCase, isfile(fullfile(outDir, 'heatmap.png')));
verifyTrue(testCase, isfile(fullfile(outDir, 'radar_chart.png')));
verifyFalse(testCase, isfile(fullfile(outDir, 'line_plot.png')));
verifyTrue(testCase, all(arrayfun(@(item) item.report.Passed, result)));
end

function testRenderExamplesRejectsUnknownNames(testCase)
outDir = fullfile(tempdir, 'sft-selected-gallery-error-test');
verifyError(testCase, @() sftRenderExamples("not_a_template", outDir, ["png"]), ...
    'sftRenderExamples:UnknownTemplate');
end

function testRenderMatchesCreatesOutputsFromSearchQuery(testCase)
outDir = fullfile(tempdir, 'sft-matched-gallery-test');
if exist(outDir, 'dir')
    rmdir(outDir, 's');
end

result = sftRenderMatches("inset", outDir, ["png"]);
pngFiles = dir(fullfile(outDir, '*.png'));

verifyEqual(testCase, numel(result), 1);
verifyEqual(testCase, result.name, "zoomed_inset_line");
verifyEqual(testCase, numel(pngFiles), 1);
verifyTrue(testCase, isfile(fullfile(outDir, 'zoomed_inset_line.png')));
verifyTrue(testCase, result.report.Passed);
end

function testRenderMatchesRejectsEmptyResult(testCase)
outDir = fullfile(tempdir, 'sft-matched-gallery-error-test');
verifyError(testCase, @() sftRenderMatches("notarealquery", outDir, ["png"]), ...
    'sftRenderMatches:NoMatches');
end
