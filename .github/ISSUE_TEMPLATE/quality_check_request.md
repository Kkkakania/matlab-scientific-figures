---
name: Quality or compatibility check
about: Suggest a CI, provenance, privacy, compatibility, or release-gate improvement
title: "[Check]: "
labels: ci, provenance, compatibility
assignees: ""
---

## What Should Be Checked?

Describe the failure mode, compatibility risk, or maintenance rule this check
should catch.

## Why It Matters

Who is affected if this is not checked?

- [ ] New users
- [ ] Template contributors
- [ ] Maintainers
- [ ] Downstream tooling
- [ ] Release workflow

## Where It Belongs

- [ ] GitHub Actions only
- [ ] Local static check
- [ ] MATLAB-enabled release gate
- [ ] Documentation checklist

## Example Failure

If possible, provide a small synthetic example or command output. Do not attach
private datasets, copied figures, or third-party source bundles.

```text
Command:
Observed:
Expected:
```

## Acceptance Criteria

- [ ] The check has a clear pass/fail condition.
- [ ] The failure message tells contributors what to fix.
- [ ] The check does not require private data or unclear third-party files.
