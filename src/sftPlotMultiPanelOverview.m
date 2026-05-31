function [fig, layout, axesHandles, handles] = sftPlotMultiPanelOverview(lineData, scatterData, barData, rankingData, theme)
%SFTPLOTMULTIPANELOVERVIEW Draw a four-panel trend, relationship, comparison, and ranking figure.

if nargin < 4 || isempty(lineData) || isempty(scatterData) || isempty(barData) || isempty(rankingData)
    error('sft:InvalidData', 'Line, scatter, bar, and ranking data structures are required.');
end
if nargin < 5 || isempty(theme)
    theme = sftTheme('FigureSize', [16 11], 'FontSize', 8.5, 'MarkerSize', 32);
end

validateLineData(lineData);
validateScatterData(scatterData);
validateBarData(barData);
validateRankingData(rankingData);

colors = sftPalette('main', 4);
[fig, layout] = sftTiledFigure(2, 2, ...
    'Theme', theme, ...
    'FigureSize', theme.FigureSize);
title(layout, 'Multi-Panel Overview', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize + 2.5, ...
    'FontWeight', 'bold', ...
    'Color', theme.AxisColor);

axesHandles = gobjects(4, 1);
handles = struct();

axesHandles(1) = nexttile(layout);
handles.Trend = plot(axesHandles(1), lineData.x(:), lineData.y(:), ...
    'Color', colors(1, :), ...
    'LineWidth', theme.LineWidth);
grid(axesHandles(1), 'on');
title(axesHandles(1), 'Trend');
xlabel(axesHandles(1), 'Time');
ylabel(axesHandles(1), 'Response');
sftApplyTheme(axesHandles(1), theme);

axesHandles(2) = nexttile(layout);
handles.Relationship = scatter(axesHandles(2), scatterData.x(:), scatterData.y(:), ...
    theme.MarkerSize * 0.55, colors(2, :), ...
    'filled', ...
    'MarkerFaceAlpha', 0.65, ...
    'MarkerEdgeColor', 'none');
grid(axesHandles(2), 'on');
title(axesHandles(2), 'Relationship');
xlabel(axesHandles(2), 'Input');
ylabel(axesHandles(2), 'Output');
sftApplyTheme(axesHandles(2), theme);

axesHandles(3) = nexttile(layout);
handles.Comparison = bar(axesHandles(3), barData.values(:), ...
    'FaceColor', colors(3, :), ...
    'EdgeColor', 'none');
set(axesHandles(3), 'XTick', 1:numel(barData.labels), 'XTickLabel', string(barData.labels(:)));
xtickangle(axesHandles(3), 25);
grid(axesHandles(3), 'on');
title(axesHandles(3), 'Comparison');
xlabel(axesHandles(3), 'Method');
ylabel(axesHandles(3), 'Score');
sftApplyTheme(axesHandles(3), theme);

axesHandles(4) = nexttile(layout);
[values, idx] = sort(rankingData.values(:), 'ascend');
labels = string(rankingData.labels(:));
labels = labels(idx);
y = 1:numel(values);
handles.RankingLines = plot(axesHandles(4), [zeros(size(values)).'; values.'], [y; y], ...
    'Color', colors(4, :), ...
    'LineWidth', theme.LineWidth);
hold(axesHandles(4), 'on');
handles.RankingPoints = scatter(axesHandles(4), values, y, theme.MarkerSize, colors(4, :), 'filled');
hold(axesHandles(4), 'off');
set(axesHandles(4), 'YTick', y, 'YTickLabel', labels);
xlim(axesHandles(4), [min(0, min(values)) max(1, max(values))]);
grid(axesHandles(4), 'on');
title(axesHandles(4), 'Ranking');
xlabel(axesHandles(4), 'Importance');
ylabel(axesHandles(4), 'Factor');
sftApplyTheme(axesHandles(4), theme);
end

function validateLineData(data)
requiredFields = ["x", "y"];
if ~all(isfield(data, requiredFields))
    error('sft:InvalidData', 'Line data must contain x and y fields.');
end
if ~isnumeric(data.x) || ~isnumeric(data.y) || numel(data.x) ~= numel(data.y) || isempty(data.x)
    error('sft:InvalidData', 'Line x and y values must be nonempty numeric vectors with matching length.');
end
if any(~isfinite(data.x(:))) || any(~isfinite(data.y(:)))
    error('sft:InvalidData', 'Line x and y values must be finite.');
end
end

function validateScatterData(data)
requiredFields = ["x", "y"];
if ~all(isfield(data, requiredFields))
    error('sft:InvalidData', 'Scatter data must contain x and y fields.');
end
if ~isnumeric(data.x) || ~isnumeric(data.y) || numel(data.x) ~= numel(data.y) || isempty(data.x)
    error('sft:InvalidData', 'Scatter x and y values must be nonempty numeric vectors with matching length.');
end
if any(~isfinite(data.x(:))) || any(~isfinite(data.y(:)))
    error('sft:InvalidData', 'Scatter x and y values must be finite.');
end
end

function validateBarData(data)
requiredFields = ["values", "labels"];
if ~all(isfield(data, requiredFields))
    error('sft:InvalidData', 'Bar data must contain values and labels fields.');
end
if ~isnumeric(data.values) || isempty(data.values) || any(~isfinite(data.values(:)))
    error('sft:InvalidData', 'Bar values must be finite numeric values.');
end
if numel(data.values) ~= numel(data.labels)
    error('sft:InvalidLabels', 'Bar labels must match the number of values.');
end
end

function validateRankingData(data)
requiredFields = ["values", "labels"];
if ~all(isfield(data, requiredFields))
    error('sft:InvalidData', 'Ranking data must contain values and labels fields.');
end
if ~isnumeric(data.values) || isempty(data.values) || any(~isfinite(data.values(:)))
    error('sft:InvalidData', 'Ranking values must be finite numeric values.');
end
if numel(data.values) ~= numel(data.labels)
    error('sft:InvalidLabels', 'Ranking labels must match the number of values.');
end
end
