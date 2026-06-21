# MATLAB CLI Guide

The examples can run from a terminal. That is useful when you need to rebuild a
gallery, render figures for a paper, or check a pull request without opening the
MATLAB desktop.

## MATLAB Executable Paths

Use the full MATLAB path if `matlab` is not on `PATH`:

```bash
/Applications/MATLAB_R2025a.app/bin/matlab -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('gallery')"
```

Common executable locations:

| Platform | Example `MATLAB_BIN` |
|---|---|
| macOS | `/Applications/MATLAB_R2025a.app/bin/matlab` |
| Linux | `/usr/local/MATLAB/R2025a/bin/matlab` |
| Windows PowerShell | `C:\Program Files\MATLAB\R2025a\bin\matlab.exe` |

On Windows, run the helper scripts from Git Bash, WSL, or another Bash-compatible
shell. From PowerShell, call MATLAB directly with `-batch`.

Git Bash example:

```bash
MATLAB_BIN="/c/Program Files/MATLAB/R2025a/bin/matlab.exe" ./scripts/render_all.sh list
MATLAB_BIN="/c/Program Files/MATLAB/R2025a/bin/matlab.exe" ./scripts/render_all.sh search matrix
MATLAB_BIN="/c/Program Files/MATLAB/R2025a/bin/matlab.exe" ./scripts/render_all.sh tag matrix
MATLAB_BIN="/c/Program Files/MATLAB/R2025a/bin/matlab.exe" ./scripts/render_all.sh csv-example
```

Keep the quotes around `MATLAB_BIN` when the path contains `Program Files`, and
include the `.exe` suffix. `cmd.exe` is not a target shell for
`scripts/render_all.sh`; use Git Bash/WSL for the shell wrapper or call MATLAB
directly from PowerShell.

PowerShell example:

```powershell
& "C:\Program Files\MATLAB\R2025a\bin\matlab.exe" -batch "addpath(genpath('src')); addpath(genpath('examples')); runAllExamples('gallery')"
```

Or run:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh
```

Print the helper script options without starting MATLAB:

```bash
./scripts/render_all.sh help
```

List available templates:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh list
```

List available tags and how many templates use each one:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh tags
```

Search for templates by chart task, name, or tag:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh search matrix
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh search density contour
```

Inspect one template before rendering it:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh info heatmap
```

Render every template that uses an exact tag:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh tag matrix
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh tag agreement
```

Render only selected templates:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh heatmap radar_chart
```

The command prints the rendered template names and writes the requested formats
to the output directory.

Render every template matching a search query:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh match matrix
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh match density contour
```

Write output to a scratch directory instead of `gallery/`:

```bash
SFT_OUTPUT_DIR=/tmp/sft-gallery MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh match inset
```

Choose export formats with `SFT_FORMATS`, using a comma-separated list
containing `png`, `svg`, and `pdf`:

```bash
SFT_FORMATS=png,svg,pdf MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh heatmap
SFT_OUTPUT_DIR=/tmp/sft-pdf SFT_FORMATS=pdf MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh tag matrix
```

Template names are lower-case identifiers such as `heatmap`,
`double_triangle_heatmap`, and `zoomed_inset_line`. Use `list` when you forget
the exact name, and use `tags` when you know the type of task but not the
right keyword yet.

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
| `MATLAB executable not found` | `MATLAB_BIN` points to the wrong file | Check the installed MATLAB version and platform-specific install path |
| Bash script does not run on Windows | PowerShell is not a Bash shell | Use Git Bash/WSL for `scripts/*.sh`, or call MATLAB directly with `-batch` |
| `Unknown template(s)` | The name passed to `render_all.sh` is not in the registry | Run `./scripts/render_all.sh list` and copy from the `Name` column |
| `Invalid search keyword` | A shell search term contains unsupported punctuation | Use plain words such as `matrix`, `density`, or `inset` |
| `No templates matched` | The `match` query did not find a name, task, or tag | Run `./scripts/render_all.sh search <keyword>` first |
| `No templates matched tag(s)` | The `tag` query did not match an exact tag | Run `./scripts/render_all.sh tags` first |
| Missing output files | Rendering failed before export | Run MATLAB tests and inspect command output |
| Font mismatch | Machine lacks the chosen font | Use `sftTheme("FontFallbacks", [...])` or `sftTheme("TextScript", "cjk")` for CJK labels |
| Empty figure | Example did not draw into the active axes | Check the example renderer and call `drawnow` if needed |
