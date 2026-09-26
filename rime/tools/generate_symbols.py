#!/usr/bin/env python3
"""Generate the prefixed Rime symbol preset from symbols-master.yaml.

This generator intentionally depends only on the Python standard library.  The
master catalog uses a constrained one-entry-per-line YAML form so the script can
validate and extract entries without adding a PyYAML dependency.
"""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MASTER = ROOT / "symbols" / "symbols-master.yaml"
OUTPUT = ROOT / "generated" / "symbols_prefixed.yaml"

ENTRY_RE = re.compile(
    r"^\s*-\s*\{\s*code:\s*([A-Za-z]+),\s*"
    r"category:\s*([A-Za-z0-9_]+),\s*"
    r"symbols:\s*(\[.*\]),\s*"
    r"direct:\s*(true|false)\s*\}\s*$"
)


def load_entries(path: Path) -> list[dict[str, object]]:
    entries: list[dict[str, object]] = []
    seen_codes: set[str] = set()

    for lineno, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        if not line.lstrip().startswith("- {"):
            continue

        match = ENTRY_RE.match(line)
        if not match:
            raise ValueError(f"Unsupported catalog entry format at {path}:{lineno}: {line}")

        code, category, symbols_raw, direct_raw = match.groups()
        if code in seen_codes:
            raise ValueError(f"Duplicate symbol code {code!r} at {path}:{lineno}")

        try:
            symbols = json.loads(symbols_raw)
        except json.JSONDecodeError as exc:
            raise ValueError(f"Invalid symbols list at {path}:{lineno}: {exc}") from exc

        if not isinstance(symbols, list) or not symbols or not all(
            isinstance(item, str) and item for item in symbols
        ):
            raise ValueError(f"symbols must be a non-empty list of strings at {path}:{lineno}")

        seen_codes.add(code)
        entries.append(
            {
                "code": code,
                "category": category,
                "symbols": symbols,
                "direct": direct_raw == "true",
            }
        )

    if not entries:
        raise ValueError(f"No symbol entries found in {path}")

    return entries


def render_prefixed(entries: list[dict[str, object]]) -> str:
    lines = [
        "# GENERATED FILE - DO NOT EDIT MANUALLY",
        "# Source: symbols/symbols-master.yaml",
        "# Regenerate with: python3 tools/generate_symbols.py",
        "#",
        "# This preset inherits the current rime-frost symbols_v table and then",
        "# overlays the curated /code entries from the master catalog.",
        "",
        "symbols:",
        "  __include: symbols_v:/symbols",
    ]

    for entry in entries:
        code = entry["code"]
        symbols = entry["symbols"]
        key = json.dumps(f"/{code}", ensure_ascii=False)
        value = json.dumps(symbols, ensure_ascii=False)
        lines.append(f"  {key}: {value}")

    lines.append("")
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--check",
        action="store_true",
        help="validate the master catalog without writing the generated preset",
    )
    args = parser.parse_args()

    entries = load_entries(MASTER)
    direct_count = sum(bool(entry["direct"]) for entry in entries)

    if args.check:
        print(f"OK: {len(entries)} symbol codes; {direct_count} direct codes")
        return 0

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    temp = OUTPUT.with_suffix(OUTPUT.suffix + ".tmp")
    temp.write_text(render_prefixed(entries), encoding="utf-8")
    temp.replace(OUTPUT)

    print(f"Generated {OUTPUT}")
    print(f"Entries: {len(entries)}; direct: {direct_count}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
