function [ax, pointHandle, biasHandle, limitHandles, labelHandles, stats] = sftPlotBlandAltman(ax, methodA, methodB, theme)
%SFTPLOTBLANDALTMAN Draw a Bland-Altman agreement plot for two methods.

if nargin < 1 || isempty(ax) || ~ishandle(ax)
    error('sft:InvalidAxes', 'A valid axes handle is required.');
end
if nargin < 3 || isempty(methodA) || isempty(methodB)
    error('sft:InvalidData', 'Two method vectors are required.');
end
if ~isnumeric(methodA) || ~isnumeric(methodB)
    error('sft:InvalidData', 'Method values must be numeric.');
end
if nargin < 4 || isempty(theme)
    theme = sftTheme('FigureSize', [13.5 9]);
end

methodA = methodA(:);
methodB = methodB(:);
if numel(methodA) ~= numel(methodB) || isempty(methodA)
    error('sft:InvalidData', 'Method vectors must be nonempty and have the same length.');
end
if any(~isfinite(methodA)) || any(~isfinite(methodB))
    error('sft:InvalidData', 'Method values must be finite.');
end

meanValues = (methodA + methodB) ./ 2;
differences = methodB - methodA;
stats = struct();
stats.Mean = meanValues;
stats.Difference = differences;
stats.Bias = mean(differences);
spread = 1.96 * std(differences, 0);
stats.UpperLimit = stats.Bias + spread;
stats.LowerLimit = stats.Bias - spread;

colors = sftPalette('contrast', 3);
wasHold = ishold(ax);
hold(ax, 'on');
pointHandle = scatter(ax, meanValues, differences, theme.MarkerSize + 8, colors(1, :), ...
    'filled', ...
    'MarkerFaceAlpha', 0.72, ...
    'MarkerEdgeColor', 'w', ...
    'LineWidth', 0.5);

lineColor = [0.24 0.24 0.24];
limitColor = colors(3, :);
biasHandle = yline(ax, stats.Bias, '-', ...
    'Color', lineColor, ...
    'LineWidth', theme.LineWidth + 0.2);
limitHandles = gobjects(2, 1);
limitHandles(1) = yline(ax, stats.UpperLimit, '--', ...
    'Color', limitColor, ...
    'LineWidth', theme.LineWidth);
limitHandles(2) = yline(ax, stats.LowerLimit, '--', ...
    'Color', limitColor, ...
    'LineWidth', theme.LineWidth);

xPadding = robustPadding(meanValues, 0.04);
yValues = [differences; stats.UpperLimit; stats.LowerLimit];
yPadding = robustPadding(yValues, 0.12);
xlim(ax, [min(meanValues) - xPadding, max(meanValues) + xPadding]);
ylim(ax, [min(yValues) - yPadding, max(yValues) + yPadding]);

xText = max(meanValues) + xPadding * 0.55;
labelHandles = gobjects(3, 1);
labelHandles(1) = text(ax, xText, stats.Bias, sprintf('Bias %.2f', stats.Bias), ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'bottom', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize - 1, ...
    'Color', lineColor, ...
    'BackgroundColor', 'w', ...
    'Margin', 1);
labelHandles(2) = text(ax, xText, stats.UpperLimit, '+1.96 SD', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'bottom', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize - 1, ...
    'Color', limitColor, ...
    'BackgroundColor', 'w', ...
    'Margin', 1);
labelHandles(3) = text(ax, xText, stats.LowerLimit, '-1.96 SD', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'top', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize - 1, ...
    'Color', limitColor, ...
    'BackgroundColor', 'w', ...
    'Margin', 1);
if ~wasHold
    hold(ax, 'off');
end

grid(ax, 'on');
xlabel(ax, 'Mean of two methods');
ylabel(ax, 'Method B - Method A');
title(ax, 'Bland-Altman Agreement Plot');
sftApplyTheme(ax, theme);
end

function padding = robustPadding(values, fraction)
valueRange = range(values);
if valueRange == 0
    valueRange = max(abs(values(1)), 1);
end
padding = fraction * valueRange;
end
