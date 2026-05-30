# Tutorial: Batch Render Experiment Figures

Batch rendering is useful when one experiment produces many datasets, methods,
or ablation runs. The pattern is simple: read one input, render one figure,
export it with a stable name, then repeat.

## Folder Layout

```text
project/
  data/
    run_001.csv
    run_002.csv
    run_003.csv
  gallery/
  src/
  examples/
```

Keep private `data/` files local unless they are meant to be public.

## Batch Script

Create a local script such as `scripts/render_my_experiment.m`:

```matlab
addpath(genpath('src'));

inputFiles = dir(fullfile('data', 'run_*.csv'));
outputDir = 'gallery';
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

for k = 1:numel(inputFiles)
    inputPath = fullfile(inputFiles(k).folder, inputFiles(k).name);
    tbl = readtable(inputPath);

    fig = figure('Visible', 'off', 'Color', 'w', ...
        'Units', 'centimeters', 'Position', [1 1 14 8]);
    plot(tbl.time, tbl.signal, 'LineWidth', 1.5);
    grid on
    xlabel('Time');
    ylabel('Signal');
    title(sprintf('Experiment %03d', k));

    [~, stem] = fileparts(inputFiles(k).name);
    report = sftValidateFigure(fig);
    if ~report.Passed
        close(fig);
        error('Figure failed validation: %s', stem);
    end

    sftExport(fig, fullfile(outputDir, stem), ["png", "svg"]);
    close(fig);
end
```

Run it from MATLAB:

```matlab
run('scripts/render_my_experiment.m')
```

Or from a shell:

```bash
matlab -batch "run('scripts/render_my_experiment.m')"
```

## Naming Rules

Use stable file names, not timestamps:

```text
good:  method_a_noise_010.svg
bad:   final_final_2_2026_05_30.svg
```

Stable names make diffs, release notes, and paper revisions much easier.

## When To Use `runAllExamples`

Use `runAllExamples` for the public template gallery. Use a local batch script
for your own project data. That keeps this repository clean while still giving
you a repeatable workflow.
