function sftResetTheme()
%SFTRESETTHEME Clear root graphics defaults written by sftTheme.
%
%   SFTRESETTHEME() removes only the root defaults that
%   SFTTHEME('ApplyDefaults', true) writes. It leaves unrelated MATLAB root
%   graphics defaults untouched.

properties = { ...
    'defaultFigureColor', ...
    'defaultAxesFontName', ...
    'defaultAxesFontSize', ...
    'defaultAxesLineWidth', ...
    'defaultLineLineWidth'};

for index = 1:numel(properties)
    set(groot, properties{index}, 'remove');
end
end
