# Tutorial: Use CSV Or Excel Data

Most examples in this repo start with synthetic data from `sftExampleData`.
When you adapt a template, replace that one line with `readtable` and map your
columns to the variables used by the example.

## CSV Input

The repository includes a small public CSV at
`examples/data/experiment_signal.csv`. It is synthetic, but it uses the same
`readtable` path you would use for lab or simulation data.

Run the complete example from MATLAB:

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
renderCsvExperiment('gallery', ["png", "svg"]);
```

Or from a shell:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh csv-example
```

The bundled CSV has these columns:

| time | baseline | treatment |
|---:|---:|---:|
| 0.0 | 1.02 | 1.03 |
| 0.5 | 1.08 | 1.15 |
| 1.0 | 1.13 | 1.28 |

If your own file uses one value column and one group column, reshape or filter
it into the columns needed by the figure. For a simple line-style example:

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));

tbl = readtable('data/experiment.csv');

fig = figure('Color', 'w', 'Units', 'centimeters', 'Position', [1 1 14 8]);
plot(tbl.time, tbl.signal, 'LineWidth', 1.5);
grid on
xlabel('Time');
ylabel('Signal');
title('Experiment Signal');

report = sftValidateFigure(fig);
disp(report.Passed)
sftExport(fig, 'gallery/my_experiment_signal', ["png", "svg"]);
```

## Excel Input

For Excel files, keep the first row as variable names. MATLAB will preserve
usable column names and make invalid names safe.

```matlab
opts = detectImportOptions('data/results.xlsx', 'Sheet', 'summary');
tbl = readtable('data/results.xlsx', opts);
```

Then map columns into the shape expected by the template. For a grouped bar:

```matlab
groups = string(tbl.method);
values = [tbl.precision, tbl.recall, tbl.robustness];

fig = figure('Color', 'w', 'Units', 'centimeters', 'Position', [1 1 14 8]);
bar(values);
set(gca, 'XTickLabel', groups);
xlabel('Method');
ylabel('Score');
title('Method Comparison');
legend(["Precision", "Recall", "Robustness"], 'Location', 'northoutside');

sftExport(fig, 'gallery/my_grouped_bar', ["png", "svg"]);
```

## Keep Data Files Out Of The Public Repo

If the data is private, add a local `data/` folder and keep it untracked. The
public examples should stay synthetic and repeatable.

```bash
mkdir -p data
echo "data/" >> .git/info/exclude
```

## Practical Checks

- Check units before plotting. A beautiful plot with mixed units is still wrong.
- Rename long categories before export. Long labels are the fastest way to break a figure.
- Run `sftValidateFigure` before `sftExport`.
- Commit only the template code and synthetic examples unless the dataset is meant to be public.
