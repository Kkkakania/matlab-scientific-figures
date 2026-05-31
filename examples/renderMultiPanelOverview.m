function [files, report] = renderMultiPanelOverview(outputDir, formats)
theme = sftTheme('FigureSize', [16 11], 'FontSize', 8.5, 'MarkerSize', 32);

lineExample = sftExampleData('line');
lineData = struct('x', lineExample.x, 'y', lineExample.y(1, :));

scatterExample = sftExampleData('scatter');
scatterData = struct('x', scatterExample.x, 'y', scatterExample.y);

barExample = sftExampleData('grouped_bar');
barData = struct('values', barExample.values(:, 1), 'labels', barExample.groups);

rankingExample = sftExampleData('lollipop');
rankingData = struct('values', rankingExample.values, 'labels', rankingExample.labels);

fig = sftPlotMultiPanelOverview(lineData, scatterData, barData, rankingData, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'multi_panel_overview'), formats);
end
