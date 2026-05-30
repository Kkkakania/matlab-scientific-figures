# Provenance Policy

This repository uses a clean-room approach.

## Allowed

- Original MATLAB code written for this repository.
- Deterministic synthetic data generated in code.
- Project documentation written specifically for this repository.
- Ideas described at the level of chart families or communication tasks.

## Not Allowed

- Private template archives.
- Encrypted MATLAB files.
- Raw article packages, OCR dumps, or screenshot collections.
- Journal figure image collections.
- Code copied from third-party repositories or unclear source packs.
- Watermarked source material.
- Files that contain personal identity details or local absolute paths.
- SVG exports with vendor or workstation metadata in the `<desc>` field.

## Review Rule

When provenance is uncertain, exclude the file and reimplement the behavior from
the desired input-output behavior. Do not remove source markers to make a file
look original.

Generated gallery SVG files should keep only neutral project metadata. This is
not a claim about ownership of the rendering tool; it keeps committed examples
free of machine-specific or vendor-generated description text.
