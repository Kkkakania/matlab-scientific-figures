function result = runAllExamples(outputDir, formats)
%RUNALLEXAMPLES Render the complete example gallery.

srcDir = fileparts(mfilename('fullpath'));
projectRoot = fileparts(srcDir);
examplesDir = fullfile(projectRoot, 'examples');
if exist(examplesDir, 'dir')
    addpath(examplesDir);
end

if nargin < 1 || isempty(outputDir)
    outputDir = fullfile(projectRoot, 'gallery');
end
if nargin < 2 || isempty(formats)
    formats = ["png", "svg"];
end

if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

previousVisibility = get(groot, 'defaultFigureVisible');
set(groot, 'defaultFigureVisible', 'off');
cleanup = onCleanup(@() set(groot, 'defaultFigureVisible', previousVisibility));

renderers = {
    'line_plot', @renderLinePlot
    'confidence_interval', @renderConfidenceInterval
    'scatter_plot', @renderScatterPlot
    'density_scatter', @renderDensityScatter
    'grouped_bar', @renderGroupedBar
    'heatmap', @renderHeatmap
    'bubble_matrix', @renderBubbleMatrix
    'box_jitter', @renderBoxJitter
    'lollipop_ranking', @renderLollipopRanking
    'surface_3d', @renderSurface3D
};

result = repmat(struct('name', "", 'files', strings(0, 1)), size(renderers, 1), 1);
for k = 1:size(renderers, 1)
    name = renderers{k, 1};
    fn = renderers{k, 2};
    files = fn(outputDir, formats);
    result(k).name = string(name);
    result(k).files = files;
end
end
