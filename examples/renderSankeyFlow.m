function [files, report] = renderSankeyFlow(outputDir, formats)
data = sftExampleData('sankey_flow');
theme = sftTheme('FigureSize', [14 8.5]);

fig = figure('Visible', 'off', 'Units', 'centimeters', ...
    'Position', [1 1 theme.FigureSize]);
ax = axes(fig);
sftPlotSankeyFlow(ax, data.nodes, data.edges, theme);

[files, report] = sftFinalizeFigure(fig, fullfile(outputDir, 'sankey_flow'), formats);
end
