# Tutorials

Start with the task you have, not with the chart name.

| I need to... | Read this |
|---|---|
| Pick a suitable figure type | [Chart selection guide](chart-selection-guide.md) |
| Replace synthetic data with my own table | [Use with your data](use-with-your-data.md) |
| Load CSV or Excel files | [CSV and Excel tutorial](tutorial-csv-excel-data.md) |
| Export figures for a paper | [Paper export tutorial](tutorial-paper-export.md) |
| Render a whole experiment folder | [Batch rendering tutorial](tutorial-batch-rendering.md) |
| Make a quick local edit | [Recipes](recipes.md) |
| Check whether a figure is ready to publish | [Figure quality checklist](figure-quality-checklist.md) |

## A Practical First Run

1. Run `runAllExamples('gallery', ["png", "svg"])`.
2. Open `examples/README.md` and pick the closest output name.
3. Copy that renderer into your own project folder.
4. Replace the `sftExampleData(...)` call with your data loading code.
5. Export PNG for quick review and SVG or PDF for paper editing.

The examples are intentionally small. They are meant to be copied, edited, and
checked, not treated as a locked framework.

## When To Add A New Template

Add a new template when an existing one cannot communicate the data without
awkward changes. Before opening a request, write down:

- the shape of the input data
- the comparison or pattern the figure should reveal
- where the figure will be used
- whether grayscale printing or long labels matter

Then use the [template author guide](template-author-guide.md) and
[template backlog](template-backlog.md) to keep the contribution small and
reviewable.
