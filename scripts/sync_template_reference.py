#!/usr/bin/env python3
"""Check or rewrite the template-reference table from the JSON manifest."""

from __future__ import annotations

import argparse
import difflib
import json
import sys
from pathlib import Path


TABLE_HEADER = "| Template | Renderer | Task | Tags |\n|---|---|---|---|\n"


def markdown_cell(value: object) -> str:
    return str(value).replace("|", "\\|").replace("\n", " ")


def render_rows(manifest: list[dict[str, object]]) -> str:
    lines: list[str] = []
    for index, item in enumerate(manifest):
        try:
            name = markdown_cell(item["Name"])
            renderer = markdown_cell(item["RendererName"])
            task = markdown_cell(item["Task"])
            raw_tags = item["Tags"]
        except KeyError as exc:
            raise ValueError(f"manifest item {index} is missing {exc.args[0]}") from exc
        if not isinstance(raw_tags, list) or not all(isinstance(tag, str) for tag in raw_tags):
            raise ValueError(f"manifest item {index} Tags must be a list of strings")
        tags = ", ".join(f"`{markdown_cell(tag)}`" for tag in raw_tags)
        lines.append(f"| `{name}` | `{renderer}` | {task} | {tags} |")
    return "\n".join(lines) + "\n"


def synchronized_text(reference: str, manifest: list[dict[str, object]]) -> str:
    marker_index = reference.find(TABLE_HEADER)
    if marker_index < 0:
        raise ValueError("reference is missing the template table header")
    prefix = reference[: marker_index + len(TABLE_HEADER)]
    return prefix + render_rows(manifest)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--reference", type=Path, required=True)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--check", action="store_true")
    mode.add_argument("--write", action="store_true")
    args = parser.parse_args()

    try:
        manifest = json.loads(args.manifest.read_text(encoding="utf-8"))
        if not isinstance(manifest, list):
            raise ValueError("manifest root must be a list")
        actual = args.reference.read_text(encoding="utf-8")
        expected = synchronized_text(actual, manifest)
    except (OSError, json.JSONDecodeError, ValueError) as exc:
        print(f"sync_template_reference: {exc}", file=sys.stderr)
        return 2

    if args.write:
        args.reference.write_text(expected, encoding="utf-8")
        print(f"Updated {args.reference} from {args.manifest}.")
        return 0

    if actual != expected:
        sys.stdout.writelines(
            difflib.unified_diff(
                actual.splitlines(keepends=True),
                expected.splitlines(keepends=True),
                fromfile=str(args.reference),
                tofile=f"{args.reference} (generated)",
            )
        )
        print("Template reference table is stale; run the sync command with --write.", file=sys.stderr)
        return 1

    print("Template reference table matches the manifest.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
