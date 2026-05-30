# MATLAB CLI Guide

This project is designed to render figures without opening an interactive
desktop session.

## macOS R2025a

Use the full MATLAB path if `matlab` is not on `PATH`:

```bash
/Applications/MATLAB_R2025a.app/bin/matlab -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('gallery')"
```

Or run:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh
```

## Notes

- Prefer `-batch` for automation.
- Keep examples deterministic and data-free.
- Use `Visible`, `off` or `defaultFigureVisible`, `off` for batch rendering.
- Export vector formats for papers and slides.
- Avoid local fonts that make the project fail on other machines.
- Do not rely on local absolute paths.

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| `matlab: command not found` | MATLAB is not on `PATH` | Set `MATLAB_BIN` to the full executable path |
| Missing output files | Rendering failed before export | Run MATLAB tests and inspect command output |
| Font mismatch | Machine lacks the chosen font | Use `Arial` or another common font |
| Empty figure | Example did not draw into the active axes | Check the example renderer and call `drawnow` if needed |
