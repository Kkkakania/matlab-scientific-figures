function tests = test_run_all_examples
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(projectRoot, 'src')));
addpath(genpath(fullfile(projectRoot, 'examples')));
end

function testRunAllExamplesCreatesSeventeenPngFiles(testCase)
outDir = fullfile(tempdir, 'sft-gallery-test');
if exist(outDir, 'dir')
    rmdir(outDir, 's');
end

result = runAllExamples(outDir, ["png"]);
pngFiles = dir(fullfile(outDir, '*.png'));

verifyEqual(testCase, numel(result), 17);
verifyEqual(testCase, numel(pngFiles), 17);
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

verifyEqual(testCase, height(report), 17);
verifyTrue(testCase, all(report.Passed));
verifyTrue(testCase, any(report.Example == "waffle_chart"));
verifyTrue(testCase, any(report.Example == "double_triangle_heatmap"));
verifyTrue(testCase, any(report.Example == "zoomed_inset_line"));
verifyTrue(testCase, any(report.Example == "multi_panel_overview"));
verifyTrue(testCase, any(report.Example == "positive_negative_area"));
verifyTrue(testCase, any(report.Example == "grouped_error_bar"));
end
