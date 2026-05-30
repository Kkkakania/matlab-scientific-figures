function result = runAllExamples(outputDir, formats)
%RUNALLEXAMPLES Render the complete example gallery.

srcDir = fileparts(mfilename('fullpath'));
projectRoot = fileparts(srcDir);

if nargin < 1 || isempty(outputDir)
    outputDir = fullfile(projectRoot, 'gallery');
end
if nargin < 2 || isempty(formats)
    formats = ["png", "svg"];
end

result = sftRenderExamples("all", outputDir, formats);
end
