# Figure Quality Checklist

Use this before adding or changing a template. It is short on purpose; if the
figure fails one of these checks, fix the figure before adding more style.

## Data And Purpose

- The chart has a clear communication task.
- Synthetic data resembles a realistic structure without exposing private data.
- Axis labels are meaningful but generic.

## Visual Quality

- Text is legible at journal-column scale.
- Line widths and marker sizes are consistent.
- Legends do not cover important data.
- Color is used to encode information, not decoration.
- Important distinctions do not rely on hue alone.
- Figure size is stable and export-friendly.

## Automated Preflight

For a single figure, run:

```matlab
report = sftValidateFigure(gcf);
disp(report.Passed)
```

The validator checks for plot axes, a clean canvas, readable fonts, and basic
label completeness. It will not judge whether the chart is the right chart. That
part is still on you.

## Export Quality

- PNG export is high resolution.
- PDF or SVG export preserves vector content when possible.
- Output filenames are stable and script-friendly.
- Changed gallery images pass the color-accessibility review in
  `docs/color-accessibility.md`.

## Maintenance Quality

- The example can run headlessly.
- The template does not depend on local files.
- Privacy and provenance checks pass.
- The docs say when the figure is useful.
