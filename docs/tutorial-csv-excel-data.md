# Tutorial: Use CSV Or Excel Data

Most examples in this repo start with synthetic data from `sftExampleData`.
When you adapt a template, replace that one line with `readtable` and map your
columns to the variables used by the example.

## CSV Input

Suppose `data/experiment.csv` has these columns:

| time | signal | group |
|---:|---:|---|
| 0.0 | 1.12 | baseline |
| 0.5 | 1.25 | baseline |
| 1.0 | 1.41 | baseline |

Use it in a line-style example:

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
