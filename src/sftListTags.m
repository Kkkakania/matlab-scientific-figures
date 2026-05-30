function tags = sftListTags()
%SFTLISTTAGS Return public template tags with template counts.

registry = sftTemplateRegistry();
tagGroups = arrayfun(@(item) string(item.Tags(:)), registry, 'UniformOutput', false);
allTags = vertcat(tagGroups{:});

[tagNames, ~, tagIndex] = unique(allTags);
counts = accumarray(tagIndex, 1);
tags = table(tagNames, counts, 'VariableNames', {'Tag', 'Count'});
tags = sortrows(tags, 'Tag');
end
