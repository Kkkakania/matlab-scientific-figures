function [files, report] = renderTernaryScatter(outputDir, formats)
data = sftExampleData('ternary_scatter');
theme = sftTheme('FigureSize', [12 10]);
groupNames = categories(data.table.Group);
colors = sftPalette('contrast', numel(groupNames));
triangleHeight = sqrt(3) / 2;

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [1 1 theme.FigureSize]);
hold on
drawTernaryFrame(theme);

handles = gobjects(numel(groupNames), 1);
for k = 1:numel(groupNames)
    mask = data.table.Group == groupNames{k};
    [x, y] = ternaryToCartesian(data.table.A(mask), data.table.B(mask), data.table.C(mask));
    handles(k) = scatter(x, y, theme.MarkerSize, colors(k, :), ...
        'filled', 'MarkerFaceAlpha', 0.74, 'MarkerEdgeColor', 'w', ...
        'LineWidth', 0.4);
end

text(0.12, -0.025, data.componentLabels(1), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', ...
    'FontName', theme.FontName, 'FontSize', theme.FontSize + 1, ...
    'Color', theme.AxisColor);
text(0.88, -0.025, data.componentLabels(2), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', ...
    'FontName', theme.FontName, 'FontSize', theme.FontSize + 1, ...
    'Color', theme.AxisColor);
text(0.5, triangleHeight + 0.045, data.componentLabels(3), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', ...
    'FontName', theme.FontName, 'FontSize', theme.FontSize + 1, ...
    'Color', theme.AxisColor);

axis equal
xlim([-0.13 1.13]);
ylim([-0.11 triangleHeight + 0.13]);
set(gca, 'XTick', [], 'YTick', []);
xlabel('Three-part composition');
ylabel('Component C share');
title('Ternary Scatter');
sftStyleLegend(legend(handles, groupNames, 'Location', 'southoutside', ...
    'Orientation', 'horizontal'), theme);
sftApplyTheme(gca, theme);
ax = gca;
set(ax, 'XColor', [1 1 1], 'YColor', [1 1 1]);
set([ax.XLabel, ax.YLabel], 'Color', [1 1 1]);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'ternary_scatter'), formats);
end

function drawTernaryFrame(theme)
triangleHeight = sqrt(3) / 2;
outlineX = [0 1 0.5 0];
outlineY = [0 0 triangleHeight 0];
plot(outlineX, outlineY, '-', 'Color', theme.AxisColor, ...
    'LineWidth', theme.LineWidth, 'HandleVisibility', 'off');

for level = 0.2:0.2:0.8
    drawGridLine(level, "A", theme.GridColor);
    drawGridLine(level, "B", theme.GridColor);
    drawGridLine(level, "C", theme.GridColor);
end
end

function drawGridLine(level, component, color)
switch component
    case "A"
        a = [level level];
        b = [0 1 - level];
        c = [1 - level 0];
    case "B"
        a = [0 1 - level];
        b = [level level];
        c = [1 - level 0];
    otherwise
        a = [0 1 - level];
        b = [1 - level 0];
        c = [level level];
end
[x, y] = ternaryToCartesian(a, b, c);
plot(x, y, '-', 'Color', color, 'LineWidth', 0.7, ...
    'HandleVisibility', 'off');
end

function [x, y] = ternaryToCartesian(a, b, c)
total = a + b + c;
a = a ./ total;
b = b ./ total;
c = c ./ total;
x = b + 0.5 * c;
y = (sqrt(3) / 2) * c;
end
