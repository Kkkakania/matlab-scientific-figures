# First 5 Minutes

Use this path on a fresh clone before reading the full gallery or wiring in
private data.

## 1. Inspect Templates

List templates and inspect one known entry without rendering a figure:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh list
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh info heatmap
```

This confirms that the repository, MATLAB path, registry, and shell wrapper are
visible.

## 2. Render One Scratch Figure

Render a single known template outside the committed gallery:

```bash
SFT_OUTPUT_DIR=/tmp/sft-first-render MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh heatmap
```

Inspect the PNG/SVG outputs in `/tmp/sft-first-render`. Do not commit scratch
outputs unless they are intentionally replacing gallery artifacts.

## 3. Try The Bundled CSV Example

Run the included CSV-to-figure example before adapting your own table:

```bash
SFT_OUTPUT_DIR=/tmp/sft-csv-example MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh csv-example
```

Move to private or project-specific data only after the template list, scratch
render, and CSV example all work.

## If Something Fails

- If `list` fails, check the MATLAB executable path first.
- If `info heatmap` fails, check the repository checkout and MATLAB path setup.
- If rendering fails, rerun with a scratch output directory and inspect the
  MATLAB error before changing source files.
- If the CSV example fails, keep the bundled data unchanged and report the
  command, MATLAB version, operating system, and redacted error output.
