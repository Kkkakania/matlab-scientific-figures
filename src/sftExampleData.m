function data = sftExampleData(kind)
%SFTEXAMPLEDATA Generate deterministic synthetic data for examples.

if nargin < 1 || isempty(kind)
    kind = 'line';
end

kind = lower(string(kind));
rng(20260530, 'twister');

switch kind
    case "line"
        x = linspace(0, 12, 80);
        data.x = x;
        data.y = [
            sin(x) + 0.05 * randn(size(x))
            0.75 * cos(0.8 * x + 0.4) + 0.04 * randn(size(x))
            0.05 * x + 0.45 * sin(0.5 * x) + 0.04 * randn(size(x))
        ];
        data.labels = ["Sensor A", "Sensor B", "Sensor C"];

    case "confidence"
        x = linspace(0, 10, 100);
        center = [sin(x); cos(0.8 * x); 0.22 * x - 0.7];
        spread = [0.18 + 0.04 * cos(x); 0.16 + 0.03 * sin(x); 0.14 + 0.02 * cos(0.5 * x)];
        data.x = x;
        data.center = center;
        data.lower = center - abs(spread);
        data.upper = center + abs(spread);
        data.labels = ["Model A", "Model B", "Model C"];

    case "uncertainty_fan_chart"
        x = linspace(0, 24, 120);
        median = 0.045 * x + 0.42 * sin(0.28 * x + 0.4);
        innerSpread = 0.16 + 0.008 * x + 0.025 * sin(0.18 * x + 0.6);
        outerSpread = 0.34 + 0.018 * x + 0.030 * cos(0.16 * x);
        data.x = x;
        data.median = median;
        data.p25 = median - abs(innerSpread);
        data.p75 = median + abs(innerSpread);
        data.p10 = median - abs(outerSpread);
        data.p90 = median + abs(outerSpread);

    case "scatter"
        n = 180;
        data.x = randn(n, 1);
        data.y = 0.65 * data.x + 0.55 * randn(n, 1);
        data.group = categorical(repmat(["A"; "B"; "C"], n / 3, 1));

    case "ternary_scatter"
        groupNames = ["Balanced"; "A-rich"; "C-rich"];
        samplesPerGroup = 30;
        weights = [
            1.0 1.0 1.0
            2.3 0.8 0.9
            0.8 0.9 2.2
        ];
        values = zeros(numel(groupNames) * samplesPerGroup, 3);
        groups = strings(numel(groupNames) * samplesPerGroup, 1);
        for k = 1:numel(groupNames)
            rows = (1:samplesPerGroup) + (k - 1) * samplesPerGroup;
            raw = -log(max(rand(samplesPerGroup, 3), eps)) .* weights(k, :);
            values(rows, :) = raw ./ sum(raw, 2);
            groups(rows) = groupNames(k);
        end
        data.table = table(values(:, 1), values(:, 2), values(:, 3), ...
            categorical(groups), 'VariableNames', {'A', 'B', 'C', 'Group'});
        data.componentLabels = ["Component A", "Component B", "Component C"];

    case "density_scatter"
        n = 520;
        x1 = randn(round(n * 0.65), 1) * 0.65 - 0.4;
        y1 = 0.7 * x1 + randn(size(x1)) * 0.35;
        x2 = randn(n - numel(x1), 1) * 0.45 + 1.1;
        y2 = -0.5 * x2 + randn(size(x2)) * 0.28 + 1.2;
        data.x = [x1; x2];
        data.y = [y1; y2];

    case "contour_scatter"
        n = 640;
        firstCount = round(n * 0.58);
        x1 = randn(firstCount, 1) * 0.72 - 0.35;
        y1 = 0.52 * x1 + randn(firstCount, 1) * 0.34 + 0.10;
        x2 = randn(n - firstCount, 1) * 0.52 + 1.18;
        y2 = -0.38 * x2 + randn(n - firstCount, 1) * 0.30 + 1.18;
        data.x = [x1; x2];
        data.y = [y1; y2];

    case "bland_altman_plot"
        n = 96;
        baseline = linspace(24, 118, n).' + 5.5 * randn(n, 1);
        methodA = baseline + 1.8 * randn(n, 1);
        proportionalBias = 0.018 * (baseline - mean(baseline));
        difference = 1.15 + proportionalBias + 3.1 * randn(n, 1);
        methodB = methodA + difference;
        data.methodA = methodA;
        data.methodB = methodB;
        data.meanValues = (methodA + methodB) ./ 2;
        data.differences = methodB - methodA;
        data.bias = mean(data.differences);
        spread = 1.96 * std(data.differences, 0);
        data.upperLimit = data.bias + spread;
        data.lowerLimit = data.bias - spread;

    case "grouped_bar"
        data.values = [4.2 3.1 3.7; 5.0 4.1 4.4; 3.6 4.7 4.2; 4.8 3.9 5.1];
        data.groups = ["Baseline", "Method A", "Method B", "Method C"];
        data.series = ["Precision", "Recall", "Robustness"];

    case "grouped_error_bar"
        data.values = [4.4 3.8 4.1; 5.2 4.7 4.9; 3.9 4.3 4.0; 4.8 5.1 4.6];
        data.errors = [0.28 0.22 0.25; 0.31 0.26 0.29; 0.24 0.27 0.22; 0.30 0.25 0.28];
        data.groups = ["Baseline", "Method A", "Method B", "Method C"];
        data.series = ["Dataset 1", "Dataset 2", "Dataset 3"];

    case "forest_plot"
        data.labels = ["Baseline adjustment", "Sensor fusion", "Load control", ...
            "Thermal margin", "Forecast update", "Voltage support", "Safety filter"];
        data.estimate = [-0.18 0.12 0.28 -0.06 0.21 0.34 0.08];
        widths = [0.16 0.20 0.13 0.18 0.12 0.16 0.17];
        data.lower = data.estimate - widths;
        data.upper = data.estimate + widths;
        data.reference = 0;

    case "waterfall_chart"
        data.start = 100;
        data.labels = ["Efficiency", "Storage", "Curtailment", "Forecast", "Control"];
        data.steps = [18 12 -9 15 -6];
        data.final = data.start + sum(data.steps);

    case "waffle"
        data.labels = ["Completed", "In progress", "Queued", "Blocked"];
        data.counts = [42 27 19 12];
        data.colors = sftPalette('main', numel(data.counts));

    case "sankey_flow"
        data.nodes = table( ...
            ["Solar"; "Wind"; "Storage"; "Grid"; "Industry"; "Campus"; "Losses"], ...
            [1; 1; 2; 2; 3; 3; 3], ...
            'VariableNames', {'Name', 'Stage'});
        data.edges = table( ...
            ["Solar"; "Solar"; "Wind"; "Wind"; "Storage"; "Grid"; "Grid"; "Grid"], ...
            ["Storage"; "Grid"; "Storage"; "Grid"; "Grid"; "Industry"; "Campus"; "Losses"], ...
            [18; 42; 15; 35; 22; 54; 45; 15], ...
            'VariableNames', {'Source', 'Target', 'Weight'});

    case "butterfly"
        data.labels = ["North", "East", "South", "West", "Central", "Coastal"];
        data.left = [38 31 28 24 20 17];
        data.right = [34 36 30 29 25 21];
        data.leftLabel = "Scenario A";
        data.rightLabel = "Scenario B";

    case "ridgeline"
        groupCount = 5;
        sampleCount = 180;
        values = zeros(sampleCount, groupCount);
        centers = [-1.1 -0.35 0.25 0.85 1.25];
        spreads = [0.42 0.35 0.50 0.38 0.45];
        for k = 1:groupCount
            values(:, k) = centers(k) + spreads(k) * randn(sampleCount, 1) ...
                + 0.12 * sin(randn(sampleCount, 1) + k);
        end
        data.values = values;
        data.labels = ["Group A", "Group B", "Group C", "Group D", "Group E"];

    case "radar"
        data.metrics = ["Accuracy", "Speed", "Memory", "Stability", "Setup", "Cost"];
        data.series = ["Baseline", "Method A", "Method B"];
        data.values = [
            0.72 0.66 0.58 0.76 0.62 0.55
            0.84 0.73 0.64 0.82 0.70 0.61
            0.78 0.82 0.71 0.74 0.80 0.68
        ];

    case "parallel_coordinates"
        data.features = ["Accuracy", "Throughput", "Stability", ...
            "Efficiency", "Scalability", "Usability"];
        groupNames = ["Baseline", "Tuned", "Robust"];
        profiles = [
            0.64 0.58 0.66 0.62 0.56 0.70
            0.78 0.76 0.70 0.72 0.68 0.74
            0.72 0.64 0.82 0.78 0.76 0.68
        ];
        samplesPerGroup = 8;
        data.values = zeros(numel(groupNames) * samplesPerGroup, numel(data.features));
        data.groups = strings(numel(groupNames) * samplesPerGroup, 1);
        for k = 1:numel(groupNames)
            rows = (1:samplesPerGroup) + (k - 1) * samplesPerGroup;
            offsets = 0.045 * randn(samplesPerGroup, numel(data.features));
            data.values(rows, :) = profiles(k, :) + offsets;
            data.groups(rows) = groupNames(k);
        end
        data.values = max(0, min(1, data.values));

    case "positive_negative_area"
        x = linspace(0, 18, 160);
        y = 0.38 * sin(0.75 * x) + 0.18 * cos(1.65 * x + 0.4) ...
            + 0.035 * randn(size(x));
        data.x = x;
        data.y = y;
        data.baseline = zeros(size(x));

    case "zoomed_inset_line"
        x = linspace(0, 24, 260);
        slowTrend = 0.055 * x + 0.28 * sin(0.45 * x);
        event = 0.58 * exp(-0.5 * ((x - 12.4) / 0.55) .^ 2);
        recovery = -0.32 * exp(-0.5 * ((x - 14.0) / 0.75) .^ 2);
        y = slowTrend + event + recovery + 0.035 * randn(size(x));
        data.x = x;
        data.y = y;
        data.zoomRange = [10.9 14.8];

    case "calendar_heatmap"
        startDate = datetime(2026, 1, 5);
        dates = startDate + caldays(0:83);
        dayIndex = mod(0:83, 7).';
        weekIndex = floor((0:83) / 7).';
        weeklyCycle = 0.18 * cos(2 * pi * dayIndex / 7);
        slowDrift = 0.018 * weekIndex;
        event = 0.42 * exp(-0.5 * ((weekIndex - 7) / 1.15) .^ 2);
        values = 0.58 + slowDrift + weeklyCycle + event + 0.035 * randn(84, 1);
        data.table = table(dates(:), values, 'VariableNames', {'Date', 'Value'});
        data.weekLabels = "W" + string(1:12);
        data.dayLabels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    case "paired_slopegraph"
        data.labels = ["Efficiency", "Reliability", "Response time", ...
            "Coverage", "Safety", "Maintainability", "Setup effort"];
        data.before = [0.62 0.71 0.78 0.66 0.74 0.57 0.52];
        data.after = [0.78 0.83 0.64 0.72 0.82 0.69 0.46];
        data.beforeLabel = "Baseline";
        data.afterLabel = "Updated";

    case "heatmap"
        m = randn(10, 10);
        data.matrix = corr(m + linspace(-1, 1, 10));
        data.labels = "F" + string(1:10);

    case "correlation_bubble"
        n = 240;
        common = randn(n, 1);
        thermal = randn(n, 1);
        electrical = randn(n, 1);
        noise = 0.38 * randn(n, 9);
        x = [
            common + 0.45 * electrical, ...
            0.78 * common + 0.35 * electrical, ...
            0.62 * common - 0.30 * thermal, ...
            -0.55 * common + 0.72 * thermal, ...
            -0.48 * common + 0.58 * thermal, ...
            0.34 * common + 0.64 * electrical, ...
            -0.25 * common + 0.80 * randn(n, 1), ...
            0.42 * thermal + 0.38 * electrical, ...
            -0.40 * electrical + 0.45 * randn(n, 1)
        ] + noise;
        data.matrix = corrcoef(x);
        data.labels = ["Load", "Voltage", "Current", "Temp", "Loss", ...
            "Power", "Vibration", "Efficiency", "Delay"];

    case "double_triangle_heatmap"
        n = 220;
        common = randn(n, 1);
        thermal = randn(n, 1);
        control = randn(n, 1);
        noiseA = 0.42 * randn(n, 8);
        noiseB = 0.46 * randn(n, 8);
        conditionA = [
            common + 0.36 * control, ...
            0.72 * common + 0.30 * thermal, ...
            -0.54 * common + 0.70 * thermal, ...
            0.62 * control + 0.24 * common, ...
            -0.42 * thermal + 0.52 * control, ...
            0.45 * common - 0.35 * control, ...
            0.58 * thermal + 0.18 * common, ...
            -0.32 * common + 0.65 * randn(n, 1)
        ] + noiseA;
        conditionB = [
            0.84 * common + 0.42 * control, ...
            0.62 * common + 0.44 * thermal, ...
            -0.46 * common + 0.76 * thermal, ...
            0.54 * control + 0.36 * common, ...
            -0.34 * thermal + 0.58 * control, ...
            0.38 * common - 0.46 * control, ...
            0.64 * thermal + 0.12 * common, ...
            -0.26 * common + 0.72 * randn(n, 1)
        ] + noiseB;
        data.upper = corrcoef(conditionA);
        data.lower = corrcoef(conditionB);
        data.labels = ["Load", "Volt", "Temp", "Ctrl", "Loss", "Resp", "Heat", "Drift"];

    case "bubble_matrix"
        raw = abs(randn(8, 8));
        data.matrix = raw ./ max(raw(:));
        data.rows = "R" + string(1:8);
        data.cols = "C" + string(1:8);

    case "box_jitter"
        groups = repelem(1:4, 35).';
        offsets = [0.0 0.35 0.65 1.05];
        data.group = categorical(groups, 1:4, ["G1", "G2", "G3", "G4"]);
        data.value = randn(numel(groups), 1) * 0.36 + offsets(groups).';

    case "lollipop"
        data.labels = ["Grid", "Storage", "Sensing", "Forecast", "Control", "Safety", "Cost", "Latency"];
        data.values = [0.91 0.83 0.78 0.72 0.68 0.61 0.55 0.49];

    case "surface"
        [x, y] = meshgrid(linspace(-3, 3, 70), linspace(-3, 3, 70));
        z = peaks(x, y) / 8 + 0.12 * sin(2 * x) .* cos(1.2 * y);
        data.x = x;
        data.y = y;
        data.z = z;

    otherwise
        error('sftExampleData:UnknownKind', 'Unknown example data kind "%s".', kind);
end
end
