function profile = sftInspectDataFile(filePath)
%SFTINSPECTDATAFILE Summarize a CSV or Excel table for figure selection.

if nargin < 1 || strlength(string(filePath)) == 0
    error('sftInspectDataFile:MissingFile', 'A CSV or Excel file path is required.');
end

filePath = string(filePath);
if ~isfile(filePath)
    error('sftInspectDataFile:FileNotFound', 'Data file does not exist: %s', filePath);
end

[~, ~, ext] = fileparts(filePath);
ext = lower(string(ext));
switch ext
    case ".csv"
        fileType = "csv";
    case {".xls", ".xlsx"}
        fileType = "excel";
    otherwise
        error('sftInspectDataFile:UnsupportedFile', ...
            'Supported data files are CSV, XLS, and XLSX.');
end

tbl = readtable(filePath);
variableNames = string(tbl.Properties.VariableNames);
numericMask = false(1, numel(variableNames));
for k = 1:numel(variableNames)
    numericMask(k) = isnumeric(tbl.(variableNames(k)));
end
numericVariables = variableNames(numericMask);

hasMonotonicFirstNumeric = false;
if ~isempty(numericVariables)
    firstValues = tbl.(numericVariables(1));
    firstValues = firstValues(:);
    firstValues = firstValues(isfinite(firstValues));
    hasMonotonicFirstNumeric = numel(firstValues) > 1 && all(diff(firstValues) > 0);
end

profile = struct();
profile.FilePath = filePath;
profile.FileType = fileType;
profile.RowCount = height(tbl);
profile.ColumnCount = width(tbl);
profile.VariableNames = variableNames;
profile.NumericVariables = numericVariables;
profile.NonNumericVariables = variableNames(~numericMask);
profile.HasMonotonicFirstNumeric = hasMonotonicFirstNumeric;
profile.Table = tbl;
end
