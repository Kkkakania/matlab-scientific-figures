# Chart Selection Guide

Choose the figure by the communication task first, not by decoration.

| Task | Recommended Example | Use When |
|---|---|---|
| Show time trend | `line_plot` | One or more signals change over an ordered axis |
| Show uncertainty | `confidence_interval` | Estimates need confidence bands or prediction ranges |
| Show forecast uncertainty | `uncertainty_fan_chart` | Uncertainty widens over a forecast or scenario horizon |
| Show signed change | `positive_negative_area` | Positive and negative deviations from a baseline both matter |
| Show daily pattern | `calendar_heatmap` | Day-of-week and week-to-week changes both matter |
| Show group relationship | `scatter_plot` | Points belong to categories or operating states |
| Show three-part composition | `ternary_scatter` | Three components sum to a whole for each observation |
| Show dense relationship | `density_scatter` | Many points overlap and local density matters |
| Show local density structure | `contour_scatter` | Points matter, but clusters and ridges also matter |
| Check method agreement | `bland_altman_plot` | Two measurement methods or models should be compared by bias and agreement limits |
| Compare methods | `grouped_bar` | A few methods are compared across a few metrics |
| Compare methods with uncertainty | `grouped_error_bar` | Group means need visible uncertainty or variability |
| Compare estimates with intervals | `forest_plot` | Several point estimates need interval context and a reference line |
| Explain cumulative change | `waterfall_chart` | Positive and negative contributions build from a starting value to a final value |
| Compare two sides | `butterfly_comparison` | Two groups should be read from a shared zero baseline |
| Compare paired change | `paired_slopegraph` | The same items are measured before and after a change |
| Show composition | `waffle_chart` | Percent shares or progress counts should be compact and countable |
| Show flow structure | `sankey_flow` | Weighted movement across stages needs direct labels |
| Show matrix pattern | `heatmap` | Pairwise relations or sample-by-feature values matter |
| Show correlation strength | `correlation_bubble` | Positive and negative pairwise correlations both matter |
| Compare two matrices | `double_triangle_heatmap` | Two methods or conditions share the same pairwise layout |
| Show matrix magnitude | `bubble_matrix` | Matrix values need both position and magnitude cues |
| Show a local event | `zoomed_inset_line` | The full trend matters, but one interval needs detail |
| Compare distributions | `box_jitter` | Group spread and individual points both matter |
| Compare many distributions | `ridgeline_plot` | Several groups need compact distribution comparison |
| Compare metric profiles | `radar_chart` | A few normalized metrics need one compact shape per method |
| Compare multivariate samples | `parallel_coordinates` | Several normalized features need comparison across groups |
| Rank factors | `lollipop_ranking` | The ordering matters more than the filled area |
| Combine panels | `multi_panel_overview` | Several small plots belong in one paper or slide figure |
| Show 3D field | `surface_3d` | A smooth response varies over two numeric inputs |

## First-Release Boundary

The first release intentionally avoided specialized maps and domain-specific
templates. New chart families should still be added only when they improve a
real communication task and can ship with synthetic data, gallery outputs,
tests, and documentation.

## Waffle Charts Versus Pie Charts

Use `waffle_chart` when the audience needs to compare a small number of
percentage shares and the countable 10 x 10 grid adds clarity. A waffle chart is
often easier to scan than a pie chart when the parts are close in size, but it
is not a good fit for many tiny categories or values that do not naturally sum
to a meaningful whole.

## Sankey-Style Flows

Use `sankey_flow` when the main question is how weighted contributions move
from inputs through intermediate stages to outputs. Keep the number of nodes
small, label nodes directly, and avoid using it when a simple stacked bar would
answer the composition question with less visual load.

## Calendar Heatmaps

Use `calendar_heatmap` when the date pattern is as important as the value
itself. It works well for usage, quality, reliability, or activity measures
where weekday/week structure should be visible. Avoid it for sparse event logs
or when exact timestamps matter more than a compact daily overview.

## Uncertainty Fan Charts

Use `uncertainty_fan_chart` when the uncertainty range grows or changes across
a horizon. It is a better fit than a single confidence band when the reader
needs both a central trajectory and nested probability intervals.

## Ternary Scatter

Use `ternary_scatter` when each observation is a composition of three parts
that sum to one. It is useful for mixtures, portfolios, operating modes, or
energy shares. Do not use it when the three variables are independent; a
regular scatter or parallel-coordinates view will be easier to read.

## Bland-Altman Agreement Plots

Use `bland_altman_plot` when the question is whether two measurement methods,
models, or instruments agree closely enough for practical use. The x-axis shows
the pairwise mean, the y-axis shows the difference, and the horizontal lines
show bias plus limits of agreement. Use a normal scatter plot instead when the
main question is correlation rather than agreement.

## Forest Plots

Use `forest_plot` when the main comparison is a set of estimates with
intervals and a meaningful reference line. It is more compact than separate
error-bar panels and works well when labels are more important than categories
on an x-axis.

## Waterfall Charts

Use `waterfall_chart` when the story is how a starting value becomes a final
value through positive and negative contributions. It is useful for ablation
studies, efficiency budgets, error budgets, and stepwise performance changes.
Avoid it when the steps are independent categories that do not form a real
cumulative sequence.

## Butterfly Comparisons

Use `butterfly_comparison` when the contrast between two sides matters more
than their absolute positions in separate panels. Keep the left and right
values positive in the input data; the renderer mirrors the left side around
zero so the sign convention is visible without changing the underlying values.

## Paired Slopegraphs

Use `paired_slopegraph` when each item appears in both conditions and the
direction of change is the story. It is a better fit than grouped bars when the
pairing matters more than the absolute rank, but it should stay small enough
for direct labels to remain readable.

## Box Jitter Versus Ridgeline

Use `box_jitter` when individual observations matter and each group has a
moderate number of samples. It keeps outliers and sample density visible, which
is useful during exploratory analysis or when reviewers may ask how much data
supports each group.

Use `ridgeline_plot` when the main question is how several distributions shift,
overlap, or change shape. It is better for scanning many groups in one compact
panel, especially when individual points would clutter the figure.

## Radar Charts Versus Parallel Coordinates

Use `radar_chart` for a small number of methods and metrics when the goal is a
quick profile comparison. It works best when values are normalized and the
audience only needs the broad shape.

Use `parallel_coordinates` when each sample or scenario matters across several
features. It is better than a radar chart when there are multiple observations
per group, when group medians should be compared against sample spread, or when
the reader needs to see tradeoffs across dimensions.
