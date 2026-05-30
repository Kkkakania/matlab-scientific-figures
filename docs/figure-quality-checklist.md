# Figure Quality Checklist

Use this checklist before adding or changing a template.

## Data And Purpose

- The chart has a clear communication task.
- Synthetic data resembles a realistic structure without exposing private data.
- Axis labels are meaningful but generic.

## Visual Quality

- Text is legible at journal-column scale.
- Line widths and marker sizes are consistent.
- Legends do not cover important data.
- Color is used to encode information, not decoration.
- Figure size is stable and export-friendly.

## Automated Preflight

For a single figure, run:

```matlab
report = sftValidateFigure(gcf);
disp(report.Passed)
```

The validator checks for plot axes, a clean canvas, readable fonts, and basic
label completeness. It is intentionally lightweight, so a passing report is a
starting point rather than a substitute for human review.

## Export Quality

- PNG export is high resolution.
- PDF or SVG export preserves vector content when possible.
- Output filenames are stable and script-friendly.

## Maintenance Quality

- The example can run headlessly.
- The template does not depend on local files.
- Privacy and provenance checks pass.
- The README or docs explain when to use the figure.
