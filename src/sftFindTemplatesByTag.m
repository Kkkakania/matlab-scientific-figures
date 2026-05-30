function matches = sftFindTemplatesByTag(tags)
%SFTFINDTEMPLATESBYTAG Return templates that use one or more exact tags.

if nargin < 1 || isempty(tags)
    matches = sftListTemplates();
    return
end

query = lower(strtrim(string(tags(:))));
query(query == "") = [];
if isempty(query)
    matches = sftListTemplates();
    return
end

registry = sftTemplateRegistry();
keep = false(numel(registry), 1);

for k = 1:numel(registry)
    itemTags = lower(string(registry(k).Tags(:)));
    keep(k) = any(ismember(query, itemTags));
end

templates = sftListTemplates();
matches = templates(keep, :);
end
