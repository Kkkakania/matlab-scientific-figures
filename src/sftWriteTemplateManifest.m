function outputFile = sftWriteTemplateManifest(outputFile)
%SFTWRITETEMPLATEMANIFEST Write template manifest JSON to disk.

if nargin < 1 || isempty(outputFile)
    srcDir = fileparts(mfilename('fullpath'));
    projectRoot = fileparts(srcDir);
    outputFile = fullfile(projectRoot, 'docs', 'template-manifest.json');
end

manifest = sftTemplateManifest();
text = jsonencode(manifest);

outputDir = fileparts(outputFile);
if ~isempty(outputDir) && ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

fid = fopen(outputFile, 'w');
if fid < 0
    error('sftWriteTemplateManifest:CannotOpenFile', ...
        'Unable to open manifest file for writing: %s', outputFile);
end

cleanup = onCleanup(@() fclose(fid));
fprintf(fid, '%s\n', text);
end
