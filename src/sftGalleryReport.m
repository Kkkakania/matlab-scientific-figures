function report = sftGalleryReport(outputDir, formats)
%SFTGALLERYREPORT Render examples and summarize figure validation results.

if nargin < 1 || isempty(outputDir)
    outputDir = tempname;
end
if nargin < 2 || isempty(formats)
    formats = "png";
end

result = runAllExamples(outputDir, formats);
example = string({result.name}).';
passed = reshape(arrayfun(@(item) item.report.Passed, result), [], 1);
fileCount = reshape(arrayfun(@(item) numel(item.files), result), [], 1);
failedChecks = strings(numel(result), 1);

for k = 1:numel(result)
    checks = result(k).report.Checks;
    failed = checks(~[checks.Passed]);
    if isempty(failed)
        failedChecks(k) = "";
    else
        failedChecks(k) = strjoin(string({failed.Name}), ", ");
    end
end

report = table(example, passed, fileCount, failedChecks, ...
    'VariableNames', {'Example', 'Passed', 'FileCount', 'FailedChecks'});

if nargout == 0
    disp(report);
    if any(~passed)
        error('sftGalleryReport:ValidationFailed', 'One or more gallery examples failed validation.');
    end
end
end
