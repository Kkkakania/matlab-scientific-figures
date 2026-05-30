# v2 Migration Notes

v2.0.0 adds a template registry and selected-rendering API. Existing example
renderers still work, but new code should use the registry when possible.

## What Still Works

Direct renderer calls still work:

```matlab
addpath(genpath('src'));
addpath(genpath('examples'));
renderHeatmap('gallery', ["png", "svg"]);
```

Rendering the whole gallery still works:

```matlab
runAllExamples('gallery', ["png", "svg"]);
```

## Preferred v2 Calls

List available templates:

```matlab
registry = sftTemplateRegistry();
disp(string({registry.Name})')
```

Render selected templates:

```matlab
sftRenderExamples(["heatmap", "radar_chart"], "gallery", ["png", "svg"]);
```

Render selected templates from a shell:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh heatmap radar_chart
```

## Why This Changed

The renderer list used to live inside `runAllExamples.m`. That worked for a
small gallery, but it made discovery awkward and pushed users toward reading
source code.

In v2, `sftTemplateRegistry()` is the source of truth for MATLAB. It exposes
template names, renderer functions, output names, chart-selection tasks, and
tags.

## Practical Update

If your script currently calls one renderer directly, you do not have to change
it. If your script lets users choose templates, use `sftRenderExamples` instead
of hard-coding renderer function names.
