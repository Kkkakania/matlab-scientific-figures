function recommendations = sftRecommendFigure(profile)
%SFTRECOMMENDFIGURE Recommend figure templates from an inspected data profile.

if nargin < 1 || ~isstruct(profile)
    error('sftRecommendFigure:InvalidProfile', 'A profile from sftInspectDataFile is required.');
end

numericCount = numel(profile.NumericVariables);
items = struct('Name', {}, 'Score', {}, 'Reason', {});

if numericCount >= 2 && profile.HasMonotonicFirstNumeric
    items(end + 1) = makeRecommendation("line_plot", 95, ...
        "First numeric column is monotonic and can be used as an ordered axis.");
end

if numericCount >= 2
    items(end + 1) = makeRecommendation("scatter_plot", 78, ...
        "At least two numeric columns can be compared as an x-y relationship.");
end

if numericCount >= 3
    items(end + 1) = makeRecommendation("heatmap", 68, ...
        "Several numeric columns can be summarized as a correlation-style matrix.");
end

if numericCount >= 2
    items(end + 1) = makeRecommendation("density_scatter", 62, ...
        "Dense numeric pairs may benefit from local-density coloring.");
end

if isempty(items)
    items(end + 1) = makeRecommendation("line_plot", 30, ...
        "No strong match was found; start with a simple ordered plot after cleaning the data.");
end

[~, order] = sort([items.Score], 'descend');
recommendations = items(order);
end

function item = makeRecommendation(name, score, reason)
item = struct();
item.Name = string(name);
item.Score = score;
item.Reason = string(reason);
end
