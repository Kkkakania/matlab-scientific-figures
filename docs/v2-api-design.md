# v2 API Design

v0.5.0 proved that the gallery can be maintained. The weak spot is discovery:
users still need to read `runAllExamples.m` or `examples/README.md` to know what
can be rendered.

v2.0.0 should make templates discoverable from MATLAB.

## Problems To Fix

- Template metadata lives in several places.
- `runAllExamples` owns the renderer list, so selected rendering is awkward.
- A shell user can render everything, but not one named template.
- Documentation can drift from the actual renderer list.

## API Boundary

Add three public MATLAB entry points:

- `sftTemplateRegistry()` returns template metadata.
- `sftRenderExamples(names, outputDir, formats)` renders selected templates.
- `runAllExamples(outputDir, formats)` stays as a compatibility wrapper that
  renders every registry entry.

Direct renderer functions in `examples/` remain usable.

## Registry Fields

Each template should expose:

- `Name`: stable template name, such as `contour_scatter`
- `Renderer`: function handle
- `OutputName`: committed gallery output stem
- `Task`: short chart-selection task
- `Tags`: small string array for discovery

The registry is the source of truth for MATLAB rendering. The README and
examples index can still be hand-written, but consistency checks should compare
them to the registry.

## Breaking Change Justification

The version jumps to v2.0.0 because the public API changes from "call
individual renderer files or run the whole gallery" to "discover and render
templates through a registry." That is a real boundary, not just a larger
gallery.

## Migration

Existing direct calls still work:

```matlab
renderHeatmap('gallery', ["png", "svg"]);
```

The preferred v2 call is:

```matlab
sftRenderExamples("heatmap", "gallery", ["png", "svg"]);
```

To render everything:

```matlab
runAllExamples('gallery', ["png", "svg"]);
```
