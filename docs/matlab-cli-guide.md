# MATLAB CLI Guide

The examples can run from a terminal. That is useful when you need to rebuild a
gallery, render figures for a paper, or check a pull request without opening the
MATLAB desktop.

## macOS R2025a

Use the full MATLAB path if `matlab` is not on `PATH`:

```bash
/Applications/MATLAB_R2025a.app/bin/matlab -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('gallery')"
```

Or run:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh
```

Render only selected templates:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh heatmap radar_chart
```

## Working Notes

- Prefer `-batch` for automation.
- Keep examples deterministic.
- Use hidden figures for batch rendering.
- Export vector formats for papers and slides.
- Avoid local fonts that make the project fail on other machines.
- Do not rely on local absolute paths.
- Run `scripts/validate_gallery.sh` before committing regenerated figures.

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| `matlab: command not found` | MATLAB is not on `PATH` | Set `MATLAB_BIN` to the full executable path |
| `MATLAB executable not found` | `MATLAB_BIN` points to the wrong file | Check the installed MATLAB version under `/Applications` |
| Missing output files | Rendering failed before export | Run MATLAB tests and inspect command output |
| Font mismatch | Machine lacks the chosen font | Use `Arial` or another common font |
| Empty figure | Example did not draw into the active axes | Check the example renderer and call `drawnow` if needed |
