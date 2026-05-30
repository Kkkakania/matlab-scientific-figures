# Security Policy

This project is a MATLAB plotting toolkit and does not process secrets by
design. Please report issues if a contribution accidentally includes private
paths, personal information, raw scraped content, or unclear provenance.

## Supported Branch

Security, privacy, and provenance fixes are handled on the default branch. The
latest public release is the supported release line; older tags are historical
snapshots.

## Reporting

Use a GitHub issue for non-sensitive provenance, dependency, or documentation
problems. If a report contains private data, local paths, personal identifiers,
or unreleased source material, do not paste the material into a public issue.
Describe the failure mode and use synthetic examples whenever possible.

## What To Avoid

- Personal email, phone numbers, addresses, or school identity details.
- Raw downloaded articles or OCR dumps.
- Third-party code with unclear license status.
- Binary MATLAB files such as `.p`, `.fig`, and `.mat`.

## Maintainer Response

For a confirmed issue, maintainers should remove or replace the risky material,
add a regression check when practical, and document the provenance boundary in
the relevant guide or checklist.
