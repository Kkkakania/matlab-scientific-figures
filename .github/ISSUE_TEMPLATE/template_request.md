---
name: Figure template request
about: Ask for a new MATLAB figure example
title: "[Template]: "
labels: template, enhancement, provenance
assignees: ""
---

## What Are You Trying To Show?

Example: compare four methods, show a correlation matrix, plot a time series
with uncertainty, or combine several panels for a paper.

## Closest Existing Template

Run `sftListTemplates()` or check `docs/gallery-reference.md`. Which existing
template is closest, and what is missing?

## What Data Shape Do You Have?

Example: one vector, two vectors, a table, a matrix, grouped observations, or a
time-by-feature array.

## Where Will The Figure Go?

- [ ] Paper
- [ ] Thesis
- [ ] Slide deck
- [ ] Report
- [ ] Notebook or web page

## Any Constraints?

Mention long labels, many groups, grayscale printing, journal size limits, or
anything else that changes the design.

## Example Input Sketch

Describe the inputs without attaching private data. Small synthetic examples are
welcome.

```matlab
% Example only:
x = 1:10;
y = rand(1, 10);
```

## Provenance Note

Please do not attach copied template code or private data. A rough sketch or a
short description is enough.
