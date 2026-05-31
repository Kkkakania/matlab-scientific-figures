# First-Use Test

Use this checklist when trying `matlab-scientific-figures` from a fresh clone.
It is meant for quick, reproducible feedback rather than a full release review.

## Environment

Record:

- OS and version:
- MATLAB version:
- Shell used for helper scripts:
- Fresh clone commit:

Do not paste private paths, local usernames, private datasets, copied journal
figures, or third-party plotting files.

## 1. Clone And Open MATLAB

```bash
git clone https://github.com/Kkkakania/matlab-scientific-figures.git
cd matlab-scientific-figures
```

If MATLAB is available from the shell, run the scripted smoke test first:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/check_first_use.sh
```

It lists templates, inspects `heatmap`, renders `heatmap` and `radar_chart` to
a temporary directory, and checks the expected PNG/SVG files. It does not touch
the committed gallery.

In MATLAB:

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
```

Expected result: no missing-file errors.

## 2. Discover Templates

```matlab
templates = sftListTemplates()
matrixTemplates = sftFindTemplates("matrix")
```

Record:

- Did the output make it clear what templates exist?
- Which template would you try first?
- Was any name confusing?

## 3. Render A Small Selection

Render a small subset instead of the full gallery:

```matlab
sftRenderExamples(["heatmap", "radar_chart"], "gallery", ["png", "svg"]);
```

Expected result:

- `gallery/heatmap.png`
- `gallery/heatmap.svg`
- `gallery/radar_chart.png`
- `gallery/radar_chart.svg`

Record:

- Did the command finish without editing source files?
- Did the PNG and SVG outputs look readable?
- Did labels, legends, or fonts look awkward on your screen?

## 4. Try Shell Helpers

Use the full MATLAB executable path when `matlab` is not on `PATH`.

macOS example:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh list
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh search matrix
```

Linux example:

```bash
MATLAB_BIN=/usr/local/MATLAB/R2025a/bin/matlab ./scripts/render_all.sh list
```

Windows users can run the MATLAB commands directly, or use Git Bash/WSL for the
helper scripts.

Record:

- Did your MATLAB executable path work?
- Was the failure message useful if the path was wrong?
- Did any command appear to hang?

## 5. Check A Figure Before Export

```matlab
fig = figure('Color', 'w');
plot(1:4, [1 3 2 5], 'LineWidth', 1.5);
title('Validation Example');
xlabel('Sample');
ylabel('Response');
report = sftValidateFigure(gcf);
disp(report)
```

Record:

- Was the validation report understandable?
- Which extra quality check would be useful?

## Feedback Template

Paste a short report into issue #9:

```text
OS:
MATLAB:
Commit:
Command sequence:
Template subset rendered:
Output formats:
Quick start result:
Template discovery result:
First template I would use:
Rendering result:
CLI/helper script result:
Expected result:
Actual result:
Most confusing part:
Most useful missing template:
Private details redacted: yes/no
```

Keep feedback specific. A failing command, unclear output, or awkward label is
more useful than general praise.
