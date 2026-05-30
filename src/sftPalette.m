function colors = sftPalette(name, n)
%SFTPALETTE Return clean-room color palettes for scientific figures.

if nargin < 1 || isempty(name)
    name = 'main';
end
if nargin < 2 || isempty(n)
    n = 6;
end

name = lower(string(name));
validateattributes(n, {'numeric'}, {'scalar', 'integer', 'positive'}, mfilename, 'n');

switch name
    case "main"
        base = [
            0.05 0.32 0.54
            0.89 0.42 0.18
            0.10 0.52 0.44
            0.72 0.18 0.28
            0.35 0.28 0.62
            0.34 0.34 0.34
            0.94 0.70 0.20
            0.18 0.56 0.78
            0.62 0.39 0.23
            0.48 0.62 0.30
        ];
    case "muted"
        base = [
            0.27 0.45 0.57
            0.74 0.55 0.37
            0.39 0.60 0.53
            0.68 0.42 0.47
            0.52 0.48 0.65
            0.48 0.48 0.48
        ];
    case "contrast"
        base = [
            0.02 0.18 0.33
            0.95 0.62 0.12
            0.00 0.50 0.42
            0.78 0.12 0.20
            0.30 0.24 0.65
        ];
    case "sequential"
        anchors = [
            0.93 0.96 0.98
            0.65 0.80 0.89
            0.30 0.58 0.75
            0.08 0.34 0.52
        ];
        colors = interpolatePalette(anchors, n);
        return
    otherwise
        error('sftPalette:UnknownPalette', 'Unknown palette "%s".', name);
end

colors = interpolatePalette(base, n);
end

function colors = interpolatePalette(base, n)
base = max(0, min(1, base));
if n <= size(base, 1)
    colors = base(1:n, :);
    return
end

x = linspace(0, 1, size(base, 1));
xq = linspace(0, 1, n);
colors = interp1(x, base, xq, 'linear');
colors = max(0, min(1, colors));
end
