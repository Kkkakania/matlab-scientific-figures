# Template Review Checklist

Use this checklist before merging a new or changed figure template.

## Fit

- The template has a clear communication task.
- The task is not already covered by an existing template.
- The example name is short, lower-case, and stable.
- The chart is useful without relying on a specific research field.

## Data

- Example data is generated in code.
- Random data uses a fixed seed.
- No private, downloaded, copied, or paper-derived data is committed.
- The example does not read from local absolute paths.

## Rendering

- The renderer accepts `outputDir` and `formats`.
- The figure is hidden during batch rendering.
- Labels, title, legend, and units are readable at gallery size.
- Color is not the only way to read an important distinction.
- The renderer closes its figure after export.
- PNG and SVG outputs are regenerated and committed.

## Registry And Docs

- `src/sftTemplateRegistry.m` includes the template.
- `examples/README.md` includes the output name and task.
- `docs/template-reference.md` includes renderer, task, and tags.
- `docs/chart-selection-guide.md` explains when to use it.
- README gallery images are updated only when the new template belongs in the
  first-screen set.

## Checks

Run:

```bash
./scripts/check_release_ready.sh
```

If MATLAB is available:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab REQUIRE_MATLAB=1 ./scripts/check_release_ready.sh
```

Before merging, review the generated figure by eye. The scripts catch many
mechanical problems, but they cannot tell whether a chart is actually readable.
