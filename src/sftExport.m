function files = sftExport(fig, outputBase, formats)
%SFTEXPORT Export a figure to one or more publication-friendly formats.

if nargin < 1 || isempty(fig)
    fig = gcf;
end
if nargin < 2 || isempty(outputBase)
    outputBase = fullfile(pwd, 'figure');
end
if nargin < 3 || isempty(formats)
    formats = ["png", "pdf", "svg"];
end

formats = string(formats);
outputBase = char(outputBase);
[outDir, ~, ~] = fileparts(outputBase);
if ~isempty(outDir) && ~exist(outDir, 'dir')
    mkdir(outDir);
end

files = strings(numel(formats), 1);
set(fig, 'Color', [1 1 1]);
warningState = warning('query', 'MATLAB:print:ContentTypeImageSuggested');
warning('off', 'MATLAB:print:ContentTypeImageSuggested');
cleanup = onCleanup(@() warning(warningState.state, 'MATLAB:print:ContentTypeImageSuggested'));

for k = 1:numel(formats)
    fmt = lower(strtrim(formats(k)));
    filePath = string(outputBase) + "." + fmt;

    switch fmt
        case "png"
            exportgraphics(fig, filePath, 'Resolution', 300);
        case {"pdf", "svg"}
            exportgraphics(fig, filePath, 'ContentType', 'vector');
        otherwise
            error('sftExport:UnsupportedFormat', 'Unsupported export format "%s".', fmt);
    end

    if fmt == "svg"
        sanitizeSvgMetadata(filePath);
    end
    files(k) = filePath;
end
end

function sanitizeSvgMetadata(filePath)
svgText = fileread(filePath);
vendorDescription = ['<desc>MATLAB, The Math' ...
    'Works, Inc\. Version [^<]+</desc>'];
svgText = regexprep(svgText, vendorDescription, '<desc>Clean-room gallery output</desc>');
svgText = regexprep(svgText, '[ \t]+(\r?\n)', '$1');
svgText = regexprep(svgText, '[ \t]+\Z', '');

fid = fopen(filePath, 'w');
if fid < 0
    error('sftExport:CannotWriteSvg', 'Could not write SVG file "%s".', filePath);
end
cleanup = onCleanup(@() fclose(fid));
fprintf(fid, '%s', svgText);
end
