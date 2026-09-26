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
PREFIXED_OUTPUT = ROOT / "generated" / "symbols_prefixed.yaml"
DIRECT_OUTPUT = ROOT / "generated" / "symbols_direct.txt"

EXPECTED_TOTAL = 151
EXPECTED_LOCAL_ENGINEERING = {
    "degc",
    "degf",
    "ohm",
    "micro",
    "angstrom",
}
EXPECTED_UPSTREAM_COUNT = EXPECTED_TOTAL - len(EXPECTED_LOCAL_ENGINEERING)
EXPECTED_DIRECT = {
    "alpha",
    "beta",
    "gamma",
    "delta",
    "epsilon",
    "varepsilon",
    "theta",
    "vartheta",
    "iota",
    "kappa",
    "varkappa",
    "lambda",
    "omicron",
    "varpi",
    "rho",
    "varrho",
    "sigma",
    "varsigma",
    "tau",
    "upsilon",
    "phi",
    "varphi",
    "omega",
}

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

    def test_expected_counts_and_direct_subset(self) -> None:
        self.assertEqual(len(self.entries), EXPECTED_TOTAL)
        engineering = {
            str(entry["code"])
            for entry in self.entries
            if entry["category"] == "engineering"
        }
        direct = {
            str(entry["code"])
            for entry in self.entries
            if bool(entry["direct"])
        }
        self.assertEqual(engineering, EXPECTED_LOCAL_ENGINEERING)
        self.assertEqual(len(self.entries) - len(engineering), EXPECTED_UPSTREAM_COUNT)
        self.assertEqual(direct, EXPECTED_DIRECT)

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

    def test_generated_prefixed_file_is_exact_render_of_master(self) -> None:
        self.assertTrue(
            PREFIXED_OUTPUT.exists(), f"Missing generated preset: {PREFIXED_OUTPUT}"
        )
        expected = generate_symbols.render_prefixed(self.entries)
        actual = PREFIXED_OUTPUT.read_text(encoding="utf-8")
        self.assertEqual(actual, expected)

    def test_generated_direct_file_is_exact_render_of_master(self) -> None:
        self.assertTrue(
            DIRECT_OUTPUT.exists(), f"Missing generated dictionary: {DIRECT_OUTPUT}"
        )
        expected = generate_symbols.render_direct(self.entries)
        actual = DIRECT_OUTPUT.read_text(encoding="utf-8")
        self.assertEqual(actual, expected)

        direct_entries = [entry for entry in self.entries if bool(entry["direct"])]
        expected_rows = sum(len(entry["symbols"]) for entry in direct_entries)
        data_rows = [
            line
            for line in actual.splitlines()
            if line and not line.startswith("#") and "\t" in line
        ]
        self.assertEqual(len(data_rows), expected_rows)

    def test_generated_file_inherits_upstream_symbols_and_has_all_codes(self) -> None:
        text = PREFIXED_OUTPUT.read_text(encoding="utf-8")
        self.assertIn("  __include: symbols_v:/symbols\n", text)
        for entry in self.entries:
            code = str(entry["code"])
            with self.subTest(code=code):
                self.assertIn(f'  "/{code}": ', text)


if __name__ == "__main__":
    unittest.main(verbosity=2)
