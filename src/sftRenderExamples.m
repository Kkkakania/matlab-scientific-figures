function result = sftRenderExamples(names, outputDir, formats)
%SFTRENDEREXAMPLES Render selected gallery templates by name.

srcDir = fileparts(mfilename('fullpath'));
projectRoot = fileparts(srcDir);

if nargin < 1 || isempty(names)
    names = "all";
end
if nargin < 2 || isempty(outputDir)
    outputDir = fullfile(projectRoot, 'gallery');
end
if nargin < 3 || isempty(formats)
    formats = ["png", "svg"];
end

if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

registry = sftTemplateRegistry();
requestedNames = normalizeNames(names, registry);

previousVisibility = get(groot, 'defaultFigureVisible');
set(groot, 'defaultFigureVisible', 'off');
cleanup = onCleanup(@() set(groot, 'defaultFigureVisible', previousVisibility));

emptyReport = struct('Passed', false, 'Checks', struct('Name', {}, 'Passed', {}, 'Message', {}));
result = repmat(struct('name', "", 'files', strings(0, 1), 'report', emptyReport), ...
    numel(requestedNames), 1);

registryNames = string({registry.Name});
for k = 1:numel(requestedNames)
    name = requestedNames(k);
    template = registry(registryNames == name);
    [files, report] = template.Renderer(outputDir, formats);
    result(k).name = string(template.Name);
    result(k).files = files;
    result(k).report = report;
end
end

function requestedNames = normalizeNames(names, registry)
registryNames = string({registry.Name});
if ischar(names) || iscellstr(names) || isstring(names)
    names = string(names);
end
requestedNames = string(names);
requestedNames = requestedNames(:).';

if isscalar(requestedNames) && lower(requestedNames) == "all"
    requestedNames = registryNames;
    return
end

missing = setdiff(requestedNames, registryNames, 'stable');
if ~isempty(missing)
    message = "Unknown template(s): " + strjoin(missing, ", ") + ...
        ". Run sftTemplateRegistry() to list available templates.";
    error('sftRenderExamples:UnknownTemplate', '%s', message);
end
end
