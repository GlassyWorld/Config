# Dotfiles

Personal configuration repository for my current macOS command-line environment.

This repository is the **canonical source** for the configurations that I actively maintain.  
Applications continue to use their normal paths, while those paths are linked back to this repository.

## Current structure

```text
~/.config/.dotfiles/
├── doom/      # Doom Emacs private configuration
├── nvim/      # LazyVim / Neovim configuration
├── yazi/      # Yazi configuration
├── zsh/       # Zsh configuration
├── .gitignore
└── README.md
```

The active configuration paths are:

```text
~/.config/doom  -> ~/.config/.dotfiles/doom
~/.config/nvim  -> ~/.config/.dotfiles/nvim
~/.config/yazi  -> ~/.config/.dotfiles/yazi
~/.zshrc        -> ~/.config/.dotfiles/zsh/.zshrc
```

Because the application paths are symbolic links, editing the normal configuration files directly also updates this repository. No separate synchronization step is required.

## Doom Emacs

Doom Emacs is split into two layers:

```text
~/.config/emacs    # Doom framework / upstream repository
~/.config/doom     # Personal Doom configuration
```

Only the personal configuration is tracked by this repository.

Configuration source:

```text
~/.config/.dotfiles/doom
```

Active path:

```text
~/.config/doom
```

The Doom framework itself remains an independent upstream Git repository at:

```text
~/.config/emacs
```

It is intentionally **not** tracked inside this dotfiles repository.

Important personal configuration files include:

```text
init.el
config.el
packages.el
```

The Doom CLI is exposed through the shell PATH:

```text
~/.config/emacs/bin
```

Common management commands include:

```sh
doom doctor
doom sync
doom upgrade
```

For macOS GUI launches, regenerate Doom's environment snapshot when the shell environment changes materially:

```sh
doom sync --env
```

Current editor policy:

- Neovim remains the default shell editor through `EDITOR` and `VISUAL`.
- Doom Emacs is currently used as an additional project/editor environment.
- Obsidian and OmniFocus remain the primary knowledge-management and task-management tools.

## Neovim

Neovim is based on **LazyVim**.

Configuration source:

```text
~/.config/.dotfiles/nvim
```

Active path:

```text
~/.config/nvim
```

The repository keeps `lazy-lock.json` so plugin versions can be reproduced as closely as possible on another machine.

## Yazi

Configuration source:

```text
~/.config/.dotfiles/yazi
```

Active path:

```text
~/.config/yazi
```

Important configuration files include:

```text
yazi.toml
keymap.toml
theme.toml
package.toml
```

Packages and flavors managed by Yazi should be restored from `package.toml` rather than treated as hand-maintained configuration.

After restoring the configuration, install the declared packages with:

```sh
ya pkg install
```

Shell usage:

- `yz` launches Yazi without changing the shell working directory when Yazi exits.
- `y` launches Yazi with cwd synchronization, so the shell follows the directory selected in Yazi.

## Zsh

The active shell configuration is stored at:

```text
~/.config/.dotfiles/zsh/.zshrc
```

and linked to:

```text
~/.zshrc
```

The current setup includes Oh My Zsh, Homebrew paths, Neovim as the default editor, Yazi helpers, Doom CLI access, zsh-syntax-highlighting, and zsh-autosuggestions.

## Restore on a new Mac

Clone the repository:

```sh
git clone https://github.com/GlassyWorld/Config.git ~/.config/.dotfiles
```

Create the application links:

```sh
ln -s ~/.config/.dotfiles/doom ~/.config/doom
ln -s ~/.config/.dotfiles/nvim ~/.config/nvim
ln -s ~/.config/.dotfiles/yazi ~/.config/yazi
ln -s ~/.config/.dotfiles/zsh/.zshrc ~/.zshrc
```

Restore Doom Emacs separately from the dotfiles repository:

```sh
git clone --depth 1 https://github.com/doomemacs/core ~/.config/emacs
~/.config/emacs/bin/doom sync
~/.config/emacs/bin/doom sync --env
```

Then restore managed Yazi packages:

```sh
ya pkg install
```

Neovim/LazyVim will bootstrap its own managed dependencies when started.

The Emacs application itself and other command-line dependencies remain managed outside this repository, for example through Homebrew.

## Workflow

Normal configuration changes are made through the standard application paths, for example:

```text
~/.config/doom/...
~/.config/nvim/...
~/.config/yazi/...
~/.zshrc
```

Because these paths resolve into this repository, review and publish changes with:

```sh
cd ~/.config/.dotfiles
git status
git diff
git add .
git commit -m "update dotfiles"
git push
```

## Repository boundary

This repository tracks configuration that represents personal decisions and should be reproducible across machines.

It does not track third-party framework source code, package caches, compiled artifacts, runtime state, history, or other generated data.

For Doom Emacs specifically:

```text
Tracked:
~/.config/.dotfiles/doom

Not tracked:
~/.config/emacs
Doom package sources
compiled Emacs Lisp
native compilation output
cache / state / history
```
