function result = sftRenderDataFile(filePath, outputDir, formats)
%SFTRENDERDATAFILE Render a first-pass figure and reports from CSV/Excel data.

if nargin < 2 || strlength(string(outputDir)) == 0
    outputDir = "figures/data-to-figure";
end
if nargin < 3 || isempty(formats)
    formats = ["png", "svg"];
end

outputDir = string(outputDir);
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

profile = sftInspectDataFile(filePath);
recommendations = sftRecommendFigure(profile);
selected = recommendations(1).Name;

fig = localRenderSelected(profile, selected);
[files, validation] = sftFinalizeFigure(fig, fullfile(outputDir, 'data_to_figure'), formats);

result = struct();
result.SelectedTemplate = selected;
result.Files = files;
result.Profile = rmfield(profile, 'Table');
result.Recommendations = recommendations;
result.Validation = validation;
result.MarkdownReport = fullfile(outputDir, 'figure_report.md');
result.JsonReport = fullfile(outputDir, 'figure_report.json');

writeMarkdownReport(result);
writeJsonReport(result);
end

function fig = localRenderSelected(profile, selected)
theme = sftTheme('FigureSize', [15 9]);
fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
tbl = profile.Table;
numericVariables = profile.NumericVariables;

switch selected
    case "line_plot"
        if numel(numericVariables) >= 2 && profile.HasMonotonicFirstNumeric
            x = tbl.(numericVariables(1));
            yVariables = numericVariables(2:end);
            y = zeros(numel(yVariables), numel(x));
            for k = 1:numel(yVariables)
                y(k, :) = tbl.(yVariables(k)).';
            end
            sftPlotLineSeries(ax, x, y, yVariables, theme);
            xlabel(ax, numericVariables(1));
            ylabel(ax, 'Value');
        else
            y = tbl.(numericVariables(1));
            sftPlotLineSeries(ax, 1:numel(y), y(:).', numericVariables(1), theme);
            xlabel(ax, 'Row');
            ylabel(ax, numericVariables(1));
        end
        title(ax, 'Data-To-Figure Line Plot');

    case "scatter_plot"
        x = tbl.(numericVariables(1));
        y = tbl.(numericVariables(2));
        scatter(ax, x, y, 34, sftPalette('main', 1), 'filled', ...
            'MarkerFaceAlpha', 0.78, 'MarkerEdgeColor', 'none');
        grid(ax, 'on');
        xlabel(ax, numericVariables(1));
        ylabel(ax, numericVariables(2));
        title(ax, 'Data-To-Figure Scatter Plot');
        sftApplyTheme(ax, theme);

    otherwise
        values = zeros(profile.RowCount, numel(numericVariables));
        for k = 1:numel(numericVariables)
            values(:, k) = tbl.(numericVariables(k));
        end
        matrix = corrcoef(values, 'Rows', 'pairwise');
        sftPlotHeatmap(ax, matrix, numericVariables, theme);
        title(ax, 'Data-To-Figure Numeric Matrix');
end
end

function writeMarkdownReport(result)
fid = fopen(result.MarkdownReport, 'w');
if fid < 0
    error('sftRenderDataFile:CannotWriteReport', 'Could not write figure report.');
end
cleanup = onCleanup(@() fclose(fid));

fprintf(fid, '# Figure Report\n\n');
fprintf(fid, '- Source file type: `%s`\n', result.Profile.FileType);
fprintf(fid, '- Rows: %d\n', result.Profile.RowCount);
fprintf(fid, '- Columns: %d\n', result.Profile.ColumnCount);
fprintf(fid, '- Numeric variables: `%s`\n', strjoin(cellstr(result.Profile.NumericVariables), '`, `'));
fprintf(fid, '- Selected template: `%s`\n\n', result.SelectedTemplate);
fprintf(fid, '## Recommended alternatives\n\n');
for k = 1:numel(result.Recommendations)
    item = result.Recommendations(k);
    fprintf(fid, '- `%s` (%d): %s\n', item.Name, item.Score, item.Reason);
end
fprintf(fid, '\n## Output files\n\n');
for k = 1:numel(result.Files)
    fprintf(fid, '- `%s`\n', result.Files(k));
end
end

function writeJsonReport(result)
payload = struct();
payload.selectedTemplate = result.SelectedTemplate;
payload.files = result.Files;
payload.profile = result.Profile;
payload.recommendations = result.Recommendations;
payload.validationPassed = result.Validation.Passed;

fid = fopen(result.JsonReport, 'w');
if fid < 0
    error('sftRenderDataFile:CannotWriteReport', 'Could not write JSON report.');
end
cleanup = onCleanup(@() fclose(fid));
fprintf(fid, '%s', jsonencode(payload));
end
