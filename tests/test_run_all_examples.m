function tests = test_run_all_examples
tests = functiontests(localfunctions);
end

function setupOnce(testCase)
projectRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(fullfile(projectRoot, 'src')));
addpath(genpath(fullfile(projectRoot, 'examples')));
end

function testRunAllExamplesCreatesTenPngFiles(testCase)
outDir = fullfile(tempdir, 'sft-gallery-test');
if exist(outDir, 'dir')
    rmdir(outDir, 's');
end

result = runAllExamples(outDir, ["png"]);
pngFiles = dir(fullfile(outDir, '*.png'));

verifyEqual(testCase, numel(result), 10);
verifyEqual(testCase, numel(pngFiles), 10);
end
