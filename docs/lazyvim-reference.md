# LazyVim Learning Reference

This document defines the long-term reference source and the current personal operating conventions for LazyVim / Neovim.

It is intended to be read together with the live configuration under `nvim/`.

## Primary Reference

Primary learning source:

- **LazyVim for Ambitious Developers**
- Author: Dusty Phillips
- https://lazyvim-ambitious-devs.phillips.codes/

When discussing LazyVim / Neovim behavior, editing techniques, keybindings, motions, text objects, buffers, windows, LSP, Git, or plugin configuration, use this book as the preferred conceptual and learning reference.

The book is a reference, not an authority over the live configuration.

Interpretation order:

1. Current live configuration in this repository
2. Current LazyVim behavior and documentation
3. *LazyVim for Ambitious Developers*
4. Generic Vim / Neovim conventions

If a keybinding or behavior from the book conflicts with the current configuration, explain the difference instead of blindly reproducing the book.

## Current Neovim Baseline

The active Neovim configuration is based on **LazyVim**.

Current LazyVim extras:

- Copilot
- mini-surround
- DAP core
- mini.files
- Markdown support
- Python support

The configuration deliberately keeps `options.lua` and `keymaps.lua` light and relies on LazyVim defaults unless there is a concrete personal reason to override them.

The preferred model is:

> LazyVim provides the IDE baseline; local configuration changes only the behavior that materially affects daily use.

## Editing Model

The preferred editing model is native Vim composition:

```text
operator + motion / text object
```

Examples:

```text
dw
diw
daw
ci"
di(
yiw
ct,
```

The goal is to learn the editing language rather than memorize isolated shortcuts.

When explaining editing commands, prefer describing:

1. the operator,
2. the motion or text object,
3. the resulting semantic action.

For example:

```text
d + iw
delete + inner word
```

rather than treating `diw` as an unrelated shortcut.

## nvim-spider Convention

`nvim-spider` is used for subword navigation inside CamelCase and snake_case identifiers.

Current custom behavior:

- `w`: Spider motion in Normal and Visual modes
- `e`: Spider motion in Normal and Visual modes
- `b`: Spider motion in Normal and Visual modes
- Operator-pending mode is intentionally **not** overridden

This distinction is deliberate.

Working principle:

> Spider handles where to go; Vim handles what to delete, change, or yank.

Therefore:

- Normal-mode navigation can use Spider semantics.
- Visual-mode navigation can use Spider semantics.
- Commands such as `dw`, `cw`, and `yw` retain native Vim operator-pending semantics.

This was chosen after observing undesirable behavior when Spider also controlled operator-pending mode, including punctuation/newline deletion behavior that differed from expected native Vim editing.

When discussing word-oriented editing, distinguish between:

- movement: `w/e/b`
- current-word editing: `iw/aw`
- line-oriented deletion: `D`
- forward motion deletion: `dw`

Do not assume Spider semantics apply to operator-pending commands.

## File Navigation

`mini.files` is the in-editor file browser and is configured as the default explorer.

Personal entry points:

```text
<leader>e   current file location
<leader>E   current working directory
<leader>fm  LazyVim project root
```

Use them semantically:

- Current-file context → `<leader>e`
- Shell/cwd context → `<leader>E`
- Whole-project context → `<leader>fm`

When giving navigation advice, preserve this distinction instead of collapsing all three into a generic “open file explorer” command.

## Yazi Relationship

Yazi remains the external terminal file manager.

Shell conventions:

```text
yz
```

launches Yazi without changing the shell working directory after exit.

```text
y
```

launches Yazi with cwd synchronization; after exit, the shell follows the directory selected in Yazi.

Therefore the general division is:

- `mini.files`: contextual file operations while already working inside Neovim
- Yazi: terminal-level browsing and broader filesystem navigation

Do not recommend replacing one with the other without a concrete workflow reason.

## Completion

Completion is provided by `blink.cmp`.

Personal setting:

```text
preselect = false
```

A completion candidate should not be automatically preselected.

When discussing completion behavior, account for this setting before assuming stock LazyVim behavior.

## Indentation

`guess-indent.nvim` is enabled on buffer reads.

Current behavior:

- automatically infer indentation
- may override EditorConfig-derived indentation

When diagnosing indentation behavior, check this plugin before assuming the value comes only from LazyVim, filetype defaults, or `.editorconfig`.

## Minimap

`neominimap.nvim` is enabled globally.

Current design:

- floating layout
- width 16
- automatic enable
- diagnostics displayed
- Git changes displayed
- Treesitter information displayed
- wrapping disabled
- `sidescrolloff = 36`

The minimap is considered part of the current visual/navigation environment, not merely an experimental plugin.

## Terminal-Oriented Workflow

Neovim is the default editor:

```text
EDITOR=nvim
VISUAL=nvim
```

The broader workflow is intentionally composed from specialized tools:

```text
Zsh
├── Git
├── Yazi
├── Neovim / LazyVim
└── Claude Code
```

Neovim should remain a focused editor/IDE rather than absorbing every surrounding workflow into itself.

This is one reason recommendations should generally favor simple terminal interoperability over recreating external tools inside Neovim.

## Learning Priorities

When using *LazyVim for Ambitious Developers*, prioritize topics that improve editing fluency and understanding of the current setup:

1. Modal editing
2. Motions and navigation
3. Basic editing
4. Objects and operator-pending mode
5. Registers and Visual mode
6. Buffers, windows, tabs, and sessions
7. Source navigation / LSP
8. Search and replace
9. Git
10. Plugin configuration

The goal is not to reproduce every configuration in the book.

The goal is to understand the underlying model well enough to make deliberate changes to the current setup.

## Guidance for Future Changes

Before recommending or applying a LazyVim-related configuration change:

1. Inspect the current relevant configuration file.
2. Identify whether the behavior comes from native Vim, LazyVim, an Extra, or a local plugin override.
3. Compare the proposed behavior with the primary reference when useful.
4. Preserve established operating conventions unless there is a clear benefit to changing them.
5. Prefer the smallest change that solves the actual problem.
6. Avoid adding a plugin when native Vim, LazyVim, or an already-installed plugin already covers the need.
7. Explain any semantic change to motions, operators, text objects, or mode-specific behavior.

When a problem is caused by interaction between plugins and native Vim behavior, prefer restoring native semantics for editing operators unless there is a strong reason not to.

## Current Philosophy

The current setup favors:

- native Vim editing semantics
- strong modal-editing fundamentals
- LazyVim defaults as the stable baseline
- few, purposeful local overrides
- semantic separation between navigation and editing
- contextual in-editor file browsing
- terminal-level composition with Yazi, Git, Zsh, and Claude Code
- configuration that remains understandable and maintainable

In short:

> Learn the model first, customize only where the current workflow demonstrates a real need.
