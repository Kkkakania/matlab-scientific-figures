# Template Manifest Schema

`docs/template-manifest.json` is the machine-readable index for the public
gallery. Use it when a script, website, notebook, or downstream tool needs
template metadata without starting MATLAB.

The manifest is generated from `sftTemplateRegistry()` and checked in so it can
be consumed from any language.

## Fields

| Field | Type | Meaning |
|---|---|---|
| `Name` | string | Stable template identifier accepted by `sftRenderExamples` |
| `OutputName` | string | Gallery output base name; currently matches `Name` |
| `RendererName` | string | MATLAB renderer function in `examples/` |
| `Task` | string | Short user-facing chart task |
| `Tags` | string array | Exact tags accepted by `sftFindTemplatesByTag` and `render_all.sh tag` |
| `SyntheticDataKind` | string | `sftExampleData` input used by the renderer, or a `+`-joined list for composite examples |
| `SyntheticDataSeed` | integer | Deterministic MATLAB RNG seed used for synthetic example data |
| `SyntheticDataRng` | string | MATLAB RNG algorithm used with `rng`; currently `twister` |
| `ExampleFile` | string | Renderer source path |
| `PngFile` | string | Committed PNG gallery output |
| `SvgFile` | string | Committed SVG gallery output |

## Contract

- `Name` uses lower-case letters, numbers, and underscores.
- `RendererName` starts with `render` and points to `examples/<RendererName>.m`.
- `PngFile` and `SvgFile` point to committed, non-empty gallery outputs.
- `Tags` are lower-case identifiers and each template has at least one tag.
- `SyntheticDataSeed` and `SyntheticDataRng` must match
  `sftExampleDataSeed()`, so downstream tools can explain how gallery data is
  reproduced.
- Template and output names are unique.

Run the schema check:

```bash
./scripts/check_template_manifest_schema.sh
```

Regenerate the manifest after registry changes:

```matlab
addpath(genpath('src'));
sftWriteTemplateManifest()
```

The MATLAB-enabled release gate also compares the committed JSON against a
freshly generated manifest.
