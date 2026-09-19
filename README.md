# Dotfiles

Personal configuration repository for my current macOS command-line environment.

This repository is the **canonical source** for the configurations that I actively maintain.  
Applications continue to use their normal paths, while those paths are linked back to this repository.

## Current structure

```text
~/.config/.dotfiles/
├── nvim/      # LazyVim / Neovim configuration
├── yazi/      # Yazi configuration
├── zsh/       # Zsh configuration
├── .gitignore
└── README.md
```

The active configuration paths are:

```text
~/.config/nvim  -> ~/.config/.dotfiles/nvim
~/.config/yazi  -> ~/.config/.dotfiles/yazi
~/.zshrc        -> ~/.config/.dotfiles/zsh/.zshrc
```

Because the application paths are symbolic links, editing the normal configuration files directly also updates this repository. No separate synchronization step is required.

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

The current setup includes Oh My Zsh, Homebrew paths, Neovim as the default editor, Yazi helpers, zsh-syntax-highlighting, and zsh-autosuggestions.

## Restore on a new Mac

Clone the repository:

```sh
git clone https://github.com/GlassyWorld/Config.git ~/.config/.dotfiles
```

Create the application links:

```sh
ln -s ~/.config/.dotfiles/nvim ~/.config/nvim
ln -s ~/.config/.dotfiles/yazi ~/.config/yazi
ln -s ~/.config/.dotfiles/zsh/.zshrc ~/.zshrc
```

Then restore managed Yazi packages:

```sh
ya pkg install
```

Neovim/LazyVim will bootstrap its own managed dependencies when started.

## Workflow

Normal configuration changes are made through the standard application paths, for example:

```text
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
