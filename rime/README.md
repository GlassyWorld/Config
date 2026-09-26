# Rime

Personal Rime / Squirrel configuration layered on top of **rime-frost**.

The rime-frost repository remains the upstream source for schemas, dictionaries, Lua logic, and bundled resources. This directory tracks only personal configuration decisions that should be reproducible across machines.

## Architecture

```text
~/.config/.dotfiles/rime/        # personal configuration, tracked by dotfiles
├── default.custom.yaml          # global Rime behavior overrides
├── squirrel.custom.yaml         # Squirrel appearance overrides
├── rime_frost.custom.yaml       # rime-frost language-model / phrase overrides
├── phrases/
│   └── personal.txt             # personal fixed phrases
└── README.md

~/Library/Rime/                  # active Rime user directory / rime-frost repo
├── default.custom.yaml          -> dotfiles
├── squirrel.custom.yaml         -> dotfiles
├── rime_frost.custom.yaml       -> dotfiles
├── personal.txt                 -> dotfiles
├── wanxiang-lts.gram            # external language model; not tracked here
├── *.userdb/                    # runtime learning data; not tracked here
├── build/                       # generated deployment output
└── ...                          # rime-frost upstream files
```

The design rule is:

> Track personal intent, not upstream source or runtime state.

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

rime-frost-specific overrides:

- use `wanxiang-lts` as the grammar language model;
- preserve the current grammar penalties / collocation settings;
- enable contextual suggestions;
- use `personal` as the custom-phrase table.

The main Chinese translator continues to use the upstream `rime_frost` dictionary. Personal phrases do **not** replace the main dictionary.

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
```

Because the active Rime files are symbolic links, editing them through either path updates the dotfiles source directly.

## Restore on a new Mac

1. Restore the main dotfiles repository.
2. Install Squirrel.
3. Clone rime-frost into the Rime user directory.
4. Obtain `wanxiang-lts.gram` separately and place it in `~/Library/Rime`.
5. Create the four symbolic links shown above.
6. Use **Squirrel → Deploy**.
7. Verify Chinese input, personal phrases, appearance, shortcuts, and long-sentence contextual suggestions.

Example upstream clone:

```sh
git clone https://github.com/gaboolic/rime-frost ~/Library/Rime
```

## Validation checklist

After a configuration change or upstream update, verify:

- normal Chinese candidates appear;
- long-sentence Chinese input works correctly;
- the `wanxiang-lts` contextual model is active;
- personal phrases such as `xinqi -> 芯碁` appear;
- candidate layout and Catppuccin appearance are correct;
- six candidates are shown per page;
- `F4` opens the options menu;
- Left Shift and Right Shift behave consistently;
- `Shift+Space` toggles full-width / half-width mode.

## Repository boundary

Tracked here:

```text
default.custom.yaml
squirrel.custom.yaml
rime_frost.custom.yaml
phrases/personal.txt
README.md
```

Not tracked here:

```text
rime-frost upstream source
wanxiang-lts.gram
zh-moqi.gram and other upstream model assets
*.userdb/
build/
user.yaml
installation.yaml
sync/
logs / caches / generated deployment artifacts
```
