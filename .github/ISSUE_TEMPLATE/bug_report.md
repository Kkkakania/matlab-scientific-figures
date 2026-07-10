---
name: Bug report
about: Report a rendering, export, or documentation issue
title: "[Bug]: "
labels: bug
assignees: ""
---

## Problem

Describe what failed and which example or function is affected.

## Environment

- MATLAB version:
- Operating system:
- Command used:
- Template or function:
- Output format: PNG / SVG / PDF

## Expected Behavior

What should have happened?

## Minimal Reproduction

Paste the smallest command or script that triggers the problem.

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
% command here
```

## Evidence

Attach a minimal command, error message, or generated figure if possible.
- [ ] I am not attaching private data, local project files, or private paths.

## Checks Tried

- [ ] `./scripts/check_release_ready.sh`
- [ ] `MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/validate_gallery.sh`
- [ ] I can reproduce this from a clean clone
