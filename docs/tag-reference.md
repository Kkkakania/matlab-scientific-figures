# Tag Reference

Use tags when you know the figure task but not the exact template name.

From MATLAB:

```matlab
sftListTags()
sftFindTemplatesByTag("matrix")
sftRenderTags("matrix", "gallery")
```

From a shell:

```bash
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh tags
MATLAB_BIN=/Applications/MATLAB_R2025a.app/bin/matlab ./scripts/render_all.sh tag matrix
```

## Common Tags

| Tag | Count | Good Starting Templates |
|---|---:|---|
| `comparison` | 6 | `grouped_bar`, `forest_plot`, `paired_slopegraph` |
| `matrix` | 4 | `heatmap`, `correlation_bubble`, `double_triangle_heatmap` |
| `scatter` | 4 | `scatter_plot`, `ternary_scatter`, `contour_scatter` |
| `bar` | 3 | `grouped_bar`, `grouped_error_bar`, `butterfly_comparison` |
| `composition` | 3 | `ternary_scatter`, `waffle_chart`, `sankey_flow` |
| `density` | 3 | `density_scatter`, `contour_scatter`, `ridgeline_plot` |
| `uncertainty` | 3 | `confidence_interval`, `uncertainty_fan_chart`, `grouped_error_bar` |
| `change` | 2 | `positive_negative_area`, `waterfall_chart` |
| `distribution` | 2 | `box_jitter`, `ridgeline_plot` |
| `profile` | 2 | `radar_chart`, `parallel_coordinates` |
| `trend` | 2 | `line_plot`, `zoomed_inset_line` |

## Specific Tags

Use these when a task is narrow:

| Tag | Template |
|---|---|
| `agreement` | `bland_altman_plot` |
| `flow` | `sankey_flow` |
| `forecast` | `uncertainty_fan_chart` |
| `inset` | `zoomed_inset_line` |
| `interval` | `forest_plot` |
| `paired` | `paired_slopegraph` |
| `ranking` | `lollipop_ranking` |
| `time` | `calendar_heatmap` |
| `waterfall` | `waterfall_chart` |

## Tag Or Search

Use `sftFindTemplatesByTag` or `render_all.sh tag` when you want exact tags
such as `matrix` or `agreement`. Use `sftFindTemplates` or `render_all.sh
search` when you want a looser text search across names, tasks, and tags.
