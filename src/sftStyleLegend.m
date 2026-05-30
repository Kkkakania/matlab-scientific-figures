function leg = sftStyleLegend(leg, theme)
%SFTSTYLELEGEND Apply the shared text style to a legend.

if nargin < 1 || isempty(leg)
    leg = legend();
end
if nargin < 2 || isempty(theme)
    theme = sftTheme();
end

set(leg, ...
    'Box', 'off', ...
    'FontName', theme.FontName, ...
    'FontSize', theme.FontSize, ...
    'TextColor', theme.AxisColor, ...
    'Color', 'none');
end
