function info = sftTemplateInfo(name)
%SFTTEMPLATEINFO Return metadata for one public template.

if nargin < 1 || isempty(name)
    error('sft:MissingTemplateName', 'Provide one template name.');
end

name = string(name);
name = strtrim(name(:));
name(name == "") = [];

if numel(name) ~= 1
    error('sft:InvalidTemplateName', 'Provide exactly one template name.');
end

manifest = sftTemplateManifest();
names = string({manifest.Name});
match = manifest(names == name);

if isempty(match)
    message = "Unknown template: " + name + ". Run sftListTemplates() to list available templates.";
    error('sft:UnknownTemplate', '%s', message);
end

info = match;
end
