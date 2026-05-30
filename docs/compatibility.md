# Compatibility

The public gallery is intended to run on base MATLAB plotting APIs. The project
does not intentionally require Statistics and Machine Learning Toolbox, Signal
Processing Toolbox, Mapping Toolbox, or third-party plotting packages.

## MATLAB Version

- MATLAB R2020b or newer is recommended.
- MATLAB R2025a is used for local verification and release-gate checks.
- Older versions may work, but they are not part of the current verification
  loop.

The R2020b recommendation is intentionally conservative. The current source
uses modern base MATLAB features including `exportgraphics`, `tiledlayout` /
`nexttile`, `jsonencode`, `datetime`, and string arrays. Do not lower the
documented version target without testing the full gallery on that version.

## Shell Tools

The helper scripts are Bash scripts. On Windows, use Git Bash, WSL, or call the
MATLAB commands directly from PowerShell as shown in the MATLAB CLI guide.

The non-MATLAB manifest schema check uses Node.js because GitHub-hosted runners
already provide it. The MATLAB gallery itself does not depend on Node.js.

## Data And Toolboxes

The committed examples use deterministic synthetic data. Tutorials may show
`readtable` for adapting local CSV or Excel data, but the public gallery does
not require external data files.

Run the dependency guard:

```bash
./scripts/check_toolbox_independence.sh
```

The guard scans public MATLAB source and examples for common toolbox-only
functions that would raise the entry barrier for new users.
