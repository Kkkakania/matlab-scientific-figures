function result = sftRenderTags(tags, outputDir, formats)
%SFTRENDERTAGS Render every template that has one or more exact tags.

if nargin < 1 || isempty(tags)
    tags = "all";
end

if nargin < 2 || isempty(outputDir)
    outputDir = [];
end

if nargin < 3 || isempty(formats)
    formats = ["png", "svg"];
end

if isscalar(string(tags)) && lower(string(tags)) == "all"
    result = sftRenderExamples("all", outputDir, formats);
    return
end

matches = sftFindTemplatesByTag(tags);
if isempty(matches)
    message = "No templates matched tag(s): " + strjoin(string(tags), ", ") + ...
        ". Run sftListTags() to list available tags.";
    error('sftRenderTags:NoMatches', '%s', message);
end

result = sftRenderExamples(matches.Name, outputDir, formats);
end
