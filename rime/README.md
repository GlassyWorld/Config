# Rime

Personal Rime / Squirrel configuration layered on top of **rime-frost**.

The rime-frost repository remains the upstream source for schemas, dictionaries, Lua logic, bundled symbol tables, and other runtime resources. This directory tracks personal configuration decisions and reproducible source files that should survive machine migration and upstream updates.

## Architecture

```text
~/.config/.dotfiles/rime/              # personal source of truth
├── default.custom.yaml                # global Rime behavior overrides
├── squirrel.custom.yaml               # Squirrel appearance overrides
├── rime_frost.custom.yaml             # rime-frost language / symbol overrides
├── phrases/
│   └── personal.txt                   # personal fixed phrases
├── symbols/
│   └── symbols-master.yaml            # canonical personal symbol catalog
├── tools/
│   ├── generate_symbols.py            # validate + generate runtime symbol files
│   └── test_symbols.py                # symbol regression tests
├── generated/
│   ├── symbols_prefixed.yaml          # generated /code symbol preset
│   └── symbols_direct.txt             # generated bare-code stabledb table
└── README.md

~/Library/Rime/                        # active Rime user directory / rime-frost repo
├── default.custom.yaml                -> dotfiles
├── squirrel.custom.yaml               -> dotfiles
├── rime_frost.custom.yaml             -> dotfiles
├── personal.txt                       -> dotfiles
├── symbols_prefixed.yaml              -> dotfiles/generated
├── symbols_direct.txt                 -> dotfiles/generated
├── wanxiang-lts.gram                  # external language model; not tracked here
├── *.userdb/                          # runtime learning data; not tracked here
├── build/                             # generated deployment output
└── ...                                # rime-frost upstream files
```

The design rule is:

> Track personal intent and canonical source data, not upstream source or runtime state.

Generated files under `generated/` are derived artifacts. Do not edit them manually; regenerate them from `symbols/symbols-master.yaml`.

## Upstream

The active Rime directory is also the rime-frost Git repository:

```text
~/Library/Rime
```

Upstream repository:

```text
https://github.com/gaboolic/rime-frost
```

rime-frost should be updated independently of this dotfiles repository.

Typical update:

```sh
cd ~/Library/Rime
git fetch origin
git pull --ff-only
```

Do **not** use `git clean -fd` in this directory without reviewing the result first. Personal symlinks and external model files may be untracked by the rime-frost repository.

## Configuration files

### `default.custom.yaml`

Global behavior overrides currently include:

- enable only `rime_frost` in the schema list;
- six candidates per page;
- `Control+grave` and `F4` for the schema/options menu;
- Right Shift uses the same `commit_code` behavior as Left Shift;
- `Shift+Space` toggles full-width / half-width mode.

Everything else is inherited from the current upstream `default.yaml`.

### `squirrel.custom.yaml`

macOS Squirrel appearance configuration:

- horizontal candidate list;
- inline preedit;
- personal font and font sizes;
- Catppuccin color scheme;
- current Squirrel layout keys for border, spacing, corners, and shadow.

The file intentionally avoids old Squirrel layout keys that are no longer supported.

### `rime_frost.custom.yaml`

rime-frost-specific overrides currently include:

- use `wanxiang-lts` as the grammar language model;
- preserve the current grammar penalties / collocation settings;
- enable contextual suggestions;
- use `personal` as the custom-phrase table;
- replace `punctuator/symbols` with the generated prefixed symbol preset;
- keep slash-symbol recognition compatible with rime-frost's pure-letter codes;
- append a `table_translator@symbols_direct` translator for the reviewed bare-code subset.

The main Chinese translator continues to use the upstream `rime_frost` dictionary. Personal phrases and direct symbols do **not** replace the main dictionary.

### `phrases/personal.txt`

Personal fixed phrases use Rime table format:

```text
phrase<Tab>code<Tab>weight
```

Example:

```text
芯碁    xin qi    1000
```

This file is loaded through rime-frost's existing `custom_phrase` translator.

## Symbol system

### Canonical source

The single source of truth is:

```text
symbols/symbols-master.yaml
```

Each entry has only four fields:

```yaml
- { code: alpha, category: greek, symbols: ["α", "Α"], direct: true }
```

Meaning:

- `code`: mnemonic input code;
- `category`: maintenance grouping only;
- `symbols`: ordered candidate list;
- `direct`: whether the same code is also exposed without `/`.

Every catalog entry is available through `/code`. Only entries marked `direct: true` are additionally exposed as bare codes.

### Current catalog baseline

Current master catalog:

```text
151 symbol codes total
├── 146 imported / normalized from wklchris/Rime-latex-symbols
└──   5 local engineering extensions
```

Primary external symbol reference:

```text
wklchris/Rime-latex-symbols
latexmath.yaml
upstream blob: 06448a858534f5ddc089695bd0f08600ec3280fc
```

Local engineering extensions currently are:

```text
degc
degf
ohm
micro
angstrom
```

### Prefixed symbols

The generator produces:

```text
generated/symbols_prefixed.yaml
```

It inherits rime-frost's existing `symbols_v:/symbols` table and overlays the catalog's `/code` mappings.

Examples:

```text
/alpha      -> α Α
/pi         -> π ϖ Π
/vartheta   -> ϑ
/sqrt       -> √ ∛ ∜
/angstrom   -> Å
```

Existing rime-frost symbol entry points such as `/xl`, `/sx`, and `/jt` remain available through the inherited `symbols_v` table.

### Direct symbols

The currently reviewed direct subset contains 23 Greek-letter codes:

```text
alpha
beta
gamma
delta
epsilon
varepsilon
theta
vartheta
iota
kappa
varkappa
lambda
omicron
varpi
rho
varrho
sigma
varsigma
tau
upsilon
phi
varphi
omega
```

These entries generate:

```text
generated/symbols_direct.txt
```

The direct table is loaded through a dedicated static translator:

```yaml
symbols_direct:
  dictionary: ""
  user_dict: symbols_direct
  db_class: stabledb
  enable_completion: false
  enable_sentence: false
  initial_quality: 2.0
```

This design intentionally mirrors rime-frost's `custom_phrase` mechanism:

- no standalone `.dict.yaml` compilation dependency;
- no sentence generation;
- no completion from partial codes;
- no dynamic learning / frequency adjustment;
- exact reviewed codes only.

Examples:

```text
alpha     -> α Α
lambda    -> λ Λ
omega     -> ω Ω
```

Codes not reviewed for direct input remain slash-only, for example:

```text
/pi
/mu
/nu
/xi
/chi
/psi
/eta
/zeta
```

### Symbol-code constraint

Custom symbol codes must remain **ASCII alphabetic only**.

Do not introduce codes such as:

```text
sup2
sup3
sub1
sub2
```

Rime uses number keys for candidate selection. Allowing digits inside slash-symbol codes creates ambiguity between "continue typing the code" and "select candidate N".

Use the existing grouped entries instead:

```text
/sup
/sub
```

The generator and regression tests enforce alphabetic symbol codes.

## Generate and test symbols

From the Rime dotfiles directory:

```sh
cd ~/.config/.dotfiles/rime

python3 tools/generate_symbols.py --check
python3 tools/generate_symbols.py
python3 tools/test_symbols.py
```

Current expected validation baseline:

```text
151 symbol codes
23 direct codes
all symbol regression tests: OK
```

`generate_symbols.py` uses only the Python standard library. It validates the constrained master format, rejects duplicate codes, and regenerates both runtime symbol files atomically.

`test_symbols.py` currently checks:

- total catalog count;
- local engineering extension set;
- exact direct subset;
- ASCII alphabetic-only codes;
- representative mappings across major categories;
- exact generated-file equivalence with the master catalog;
- prefixed output contains every `/code` entry;
- direct output contains the expected number of candidate rows.

## External language model

The current grammar model is:

```text
wanxiang-lts.gram
```

It lives in:

```text
~/Library/Rime/wanxiang-lts.gram
```

The model binary is intentionally not stored in the dotfiles repository because it is a large external dependency.

`rime_frost.custom.yaml` records the dependency by name:

```yaml
grammar:
  language: wanxiang-lts
```

A restored machine therefore needs a compatible `wanxiang-lts.gram` file before redeployment.

## Active symlinks

From `~/Library/Rime`:

```sh
ln -s ../../.config/.dotfiles/rime/default.custom.yaml default.custom.yaml
ln -s ../../.config/.dotfiles/rime/squirrel.custom.yaml squirrel.custom.yaml
ln -s ../../.config/.dotfiles/rime/rime_frost.custom.yaml rime_frost.custom.yaml
ln -s ../../.config/.dotfiles/rime/phrases/personal.txt personal.txt
ln -s ../../.config/.dotfiles/rime/generated/symbols_prefixed.yaml symbols_prefixed.yaml
ln -s ../../.config/.dotfiles/rime/generated/symbols_direct.txt symbols_direct.txt
```

Because the active Rime files are symbolic links, editing source files through the dotfiles path immediately changes what the next deployment will consume.

## Restore on a new Mac

1. Restore the main dotfiles repository.
2. Install Squirrel.
3. Clone rime-frost into `~/Library/Rime`.
4. Obtain `wanxiang-lts.gram` separately and place it in `~/Library/Rime`.
5. Generate and test the symbol artifacts.
6. Create the six symbolic links shown above.
7. Use **Squirrel → Deploy**.
8. Verify Chinese input, personal phrases, symbol input, appearance, shortcuts, and long-sentence contextual suggestions.

Example upstream clone:

```sh
git clone https://github.com/gaboolic/rime-frost ~/Library/Rime
```

Symbol generation after restoring dotfiles:

```sh
cd ~/.config/.dotfiles/rime
python3 tools/generate_symbols.py
python3 tools/test_symbols.py
```

## Validation checklist

After a configuration change or upstream update, verify:

- normal Chinese candidates appear;
- long-sentence Chinese input works correctly;
- the `wanxiang-lts` contextual model is active;
- personal phrases such as `xinqi -> 芯碁` appear;
- `/alpha`, `/pi`, `/sqrt`, `/angstrom` and representative slash symbols work;
- existing rime-frost symbol browsers such as `/xl`, `/sx`, and `/jt` still work;
- direct symbols such as `alpha`, `lambda`, and `omega` appear;
- partial direct codes such as `alph` do not complete to symbols;
- prefixed-only codes such as `pi` do not expose Greek symbols without `/`;
- `/sup` and `/sub` still allow number-key candidate selection;
- candidate layout and Catppuccin appearance are correct;
- six candidates are shown per page;
- `F4` opens the options menu;
- Left Shift and Right Shift behave consistently;
- `Shift+Space` toggles full-width / half-width mode.

## Repository boundary

Canonical personal source files maintained here include:

```text
default.custom.yaml
squirrel.custom.yaml
rime_frost.custom.yaml
phrases/personal.txt
symbols/symbols-master.yaml
tools/generate_symbols.py
tools/test_symbols.py
README.md
```

Derived symbol artifacts:

```text
generated/symbols_prefixed.yaml
generated/symbols_direct.txt
```

Runtime / external state not owned by this personal configuration layer includes:

```text
rime-frost upstream source
wanxiang-lts.gram
zh-moqi.gram and other upstream model assets
*.userdb/
build/
user.yaml
installation.yaml
sync/
logs / caches / generated deployment output
```
