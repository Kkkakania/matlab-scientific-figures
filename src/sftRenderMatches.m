function result = sftRenderMatches(query, outputDir, formats)
%SFTRENDERMATCHES Render templates that match a search query.

if nargin < 1 || isempty(query)
    query = "all";
end

if nargin < 2 || isempty(outputDir)
    outputDir = [];
end

if nargin < 3 || isempty(formats)
    formats = ["png", "svg"];
end

if isscalar(string(query)) && lower(string(query)) == "all"
    result = sftRenderExamples("all", outputDir, formats);
    return
end

matches = sftFindTemplates(query);
if isempty(matches)
    message = "No templates matched: " + strjoin(string(query), ", ") + ...
        ". Run sftListTemplates() to list available templates.";
    error('sftRenderMatches:NoMatches', '%s', message);
end

result = sftRenderExamples(matches.Name, outputDir, formats);
end
