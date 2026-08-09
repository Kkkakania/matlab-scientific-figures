#!/usr/bin/env python3
"""Query the template manifest by name or tag."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", required=True, type=Path)
    parser.add_argument("--name", help="Match one exact template name.")
    parser.add_argument("--tag", help="Match templates containing this exact tag.")
    parser.add_argument("--json", action="store_true", help="Emit machine-readable output.")
    args = parser.parse_args()

    try:
        manifest = json.loads(args.manifest.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        print(f"query_templates: {exc}", file=sys.stderr)
        return 2
    if not isinstance(manifest, list):
        print("query_templates: manifest root must be a list", file=sys.stderr)
        return 2

    matches = manifest
    if args.name:
        matches = [item for item in matches if item.get("Name") == args.name]
    if args.tag:
        matches = [item for item in matches if args.tag in item.get("Tags", [])]
    if not matches:
        print("query_templates: no matching templates", file=sys.stderr)
        return 1

    if args.json:
        print(json.dumps({"schemaVersion": 1, "matchCount": len(matches), "templates": matches}, indent=2))
        return 0

    print("| Template | Renderer | Task | Tags |")
    print("|---|---|---|---|")
    for item in matches:
        tags = ", ".join(f"`{tag}`" for tag in item["Tags"])
        print(f"| `{item['Name']}` | `{item['RendererName']}` | {item['Task']} | {tags} |")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
