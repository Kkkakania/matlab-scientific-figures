function [files, report] = sftFinalizeFigure(fig, outputBase, formats)
%SFTFINALIZEFIGURE Validate, export, and close an example figure.

if nargin < 1 || isempty(fig)
    fig = gcf;
end
if nargin < 2 || isempty(outputBase)
    outputBase = fullfile(pwd, 'figure');
end
if nargin < 3 || isempty(formats)
    formats = ["png", "svg"];
end

set(fig, 'Color', [1 1 1]);
report = sftValidateFigure(fig);
files = sftExport(fig, outputBase, formats);
close(fig);
end
