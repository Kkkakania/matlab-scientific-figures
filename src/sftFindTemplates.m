function matches = sftFindTemplates(query)
%SFTFINDTEMPLATES Search figure templates by name, task, output, or tags.

if nargin < 1 || isempty(query)
    matches = sftListTemplates();
    return
end

query = string(query);
query = lower(strtrim(query(:)));
query(query == "") = [];

templates = sftListTemplates();
if isempty(query)
    matches = templates;
    return
end

haystack = lower(templates.Name + " " + templates.OutputName + " " + ...
    templates.Task + " " + templates.Tags);

keep = false(height(templates), 1);
for k = 1:numel(query)
    keep = keep | contains(haystack, query(k));
end

matches = templates(keep, :);
end
