# JSON Envelope Compatibility

The MATLAB figure ecosystem currently has more than one JSON shape:

- `matlab-scientific-figures` publishes `docs/template-manifest.json` as a flat
  array of template records.
- `matlab-scientific-figures` writes `figure_report.json` from
  `sftRenderDataFile`.
- `matlab-figure-ci` exposes `mfigci doctor --format json` as a flat diagnostic
  payload with schema and tool-version fields.

This page is a compatibility note, not a migration plan. Existing JSON
consumers should not break just to make the repositories look uniform.

## Candidate Shapes

Flat payloads are easiest for current scripts:

```json
{
  "schema_version": "1.0",
  "tool_version": "2.4.5",
  "summary": {
    "passed": true
  }
}
```

A wrapper envelope is easier for cross-tool routing:

```json
{
  "tool": "matlab-figure-ci",
  "schema": "doctor-report/v1",
  "generated_at": "2026-06-10T00:00:00Z",
  "data": {
    "summary": {
      "passed": true
    }
  }
}
```

## Compatibility Reader

Downstream tools can accept both shapes by normalizing them at the boundary:

```javascript
function normalizeFigureJson(payload) {
  if (payload && payload.data && payload.schema) {
    return {
      schema: payload.schema,
      tool: payload.tool || "unknown",
      data: payload.data,
    };
  }

  return {
    schema: payload.schema_version || "flat/unknown",
    tool: payload.tool_name || "unknown",
    data: payload,
  };
}
```

## Current Decision

For now, keep existing payloads stable and document field meanings near the
producer:

- `docs/template-manifest-schema.md` describes the main gallery manifest.
- `sftRenderDataFile` owns the first-pass figure report payload.
- `matlab-figure-ci` owns its doctor/preflight payloads.

The ecosystem should adopt a shared wrapper only after at least two tools need
the same downstream router. Until then, add schema/version fields to producers
without wrapping existing payloads.
