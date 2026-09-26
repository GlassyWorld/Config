#!/usr/bin/env python3
"""Regression tests for the Rime symbol master catalog and generated preset."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TOOLS = ROOT / "tools"
if str(TOOLS) not in sys.path:
    sys.path.insert(0, str(TOOLS))

import generate_symbols  # noqa: E402

MASTER = ROOT / "symbols" / "symbols-master.yaml"
OUTPUT = ROOT / "generated" / "symbols_prefixed.yaml"

EXPECTED_TOTAL = 151
EXPECTED_LOCAL_ENGINEERING = {
    "degc",
    "degf",
    "ohm",
    "micro",
    "angstrom",
}
EXPECTED_UPSTREAM_COUNT = EXPECTED_TOTAL - len(EXPECTED_LOCAL_ENGINEERING)

REPRESENTATIVE = {
    "dots": ["…", "⋯", "⋮", "⋰", "⋱"],
    "mathbb": ["ℂ", "ℕ", "ℙ", "ℚ", "ℝ", "ℤ"],
    "ellipse": ["⬭", "\u2B2C", "⬯", "⬮"],
    "partial": ["∂"],
    "times": ["×", "⊗", "·", "⊙", "∘", "∙", "⋆", "∗"],
    "subset": ["⊂", "⊆", "⫅", "⫋"],
    "rightarrow": ["→", "⟶", "⇨", "🡪", "⮚", "⮞"],
    "vartheta": ["ϑ"],
    "roman": ["ⅰ", "ⅱ", "ⅲ", "ⅳ", "ⅴ", "ⅵ", "ⅶ", "ⅷ", "ⅸ", "ⅹ", "ⅺ", "ⅻ", "ⅼ", "ⅽ", "ⅾ", "ⅿ"],
    "gender": ["♂", "♀", "⚢", "⚣", "⚤", "⚥", "⚦"],
    "angstrom": ["Å"],
}


class SymbolCatalogTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.entries = generate_symbols.load_entries(MASTER)
        cls.by_code = {str(entry["code"]): entry for entry in cls.entries}

    def test_expected_counts_and_phase1_direct_state(self) -> None:
        self.assertEqual(len(self.entries), EXPECTED_TOTAL)
        engineering = {
            str(entry["code"])
            for entry in self.entries
            if entry["category"] == "engineering"
        }
        self.assertEqual(engineering, EXPECTED_LOCAL_ENGINEERING)
        self.assertEqual(len(self.entries) - len(engineering), EXPECTED_UPSTREAM_COUNT)
        self.assertFalse(any(bool(entry["direct"]) for entry in self.entries))

    def test_codes_are_alphabetic(self) -> None:
        for entry in self.entries:
            code = str(entry["code"])
            with self.subTest(code=code):
                self.assertTrue(code.isascii() and code.isalpha())

    def test_representative_mappings(self) -> None:
        for code, expected_symbols in REPRESENTATIVE.items():
            with self.subTest(code=code):
                self.assertIn(code, self.by_code)
                self.assertEqual(self.by_code[code]["symbols"], expected_symbols)

    def test_generated_file_is_exact_render_of_master(self) -> None:
        self.assertTrue(OUTPUT.exists(), f"Missing generated preset: {OUTPUT}")
        expected = generate_symbols.render_prefixed(self.entries)
        actual = OUTPUT.read_text(encoding="utf-8")
        self.assertEqual(actual, expected)

    def test_generated_file_inherits_upstream_symbols_and_has_all_codes(self) -> None:
        text = OUTPUT.read_text(encoding="utf-8")
        self.assertIn("  __include: symbols_v:/symbols\n", text)
        for entry in self.entries:
            code = str(entry["code"])
            with self.subTest(code=code):
                self.assertIn(f'  "/{code}": ', text)


if __name__ == "__main__":
    unittest.main(verbosity=2)
