#!/bin/sh

# Check if zsh is installed and do nothing if not
if ! command -v zsh >/dev/null 2>&1; then
  echo "zsh is not installed. Please install zsh and rerun this script."
  exit 1
fi

# Get the path of zsh
ZSH_PATH=$(which zsh)

# Get the directory of the ZSH plugins
PLUGINS_DIR="$HOME/.zsh_addons"

# Get the directory of the dotfiles
DOTFILES_DIR=$(dirname "$(realpath "$0")")

# Remove existing files if they exist
rm -f "$HOME/.aliases" > /dev/null 2>&1
rm -f "$HOME/.zshrc" > /dev/null 2>&1
rm -f "$HOME/.config/" > /dev/null 2>&1
rm -rf "$PLUGINS_DIR" > /dev/null 2>&1
rm -rf "$HOME/.gitconfig" > /dev/null 2>&1
rm -rf "$HOME/.config/zsh" > /dev/null 2>&1

# Creates root directories if they don't exist
mkdir -p "$HOME/.config"
mkdir -p "$PLUGINS_DIR"
mkdir -p "$HOME/.config/zsh"
mkdir -p "$HOME/.config/zsh/aliases"
mkdir -p "$HOME/.config/zsh/exports"
mkdir -p "$HOME/.config/zsh/registrations"

# Copy bat files to .config
ln -s "$DOTFILES_DIR/configs/bat/.config" "$HOME/.config/bat"
ln -s "$DOTFILES_DIR/configs/bat/zsh/aliases/bat.sh" "$HOME/.config/zsh/aliases/bat.sh"
ln -s "$DOTFILES_DIR/configs/bat/zsh/exports/bat.sh" "$HOME/.config/zsh/exports/bat.sh"

# Copy delta files to .config
ln -s "$DOTFILES_DIR/configs/delta/.config" "$HOME/.config/delta"
git config --global include.path "$HOME/.config/delta/themes"
git config --global core.pager "delta --paging=always"
git config --global interactive.diffFilter "delta --color-only"
git config --global merge.conflictStyle "zdiff3"
git config --global delta.navigate true
git config --global delta.side-by-side true
git config --global delta.hyperlinks true
git config --global delta.features "gruvbox"

# Copy eza files to .config
ln -s "$DOTFILES_DIR/configs/eza/.config" "$HOME/.config/eza"
ln -s "$DOTFILES_DIR/configs/eza/zsh/aliases/eza.sh" "$HOME/.config/zsh/aliases/eza.sh"
ln -s "$DOTFILES_DIR/configs/eza/zsh/exports/eza.sh" "$HOME/.config/zsh/exports/eza.sh"

# Copy fselect files to .config
ln -s "$DOTFILES_DIR/configs/fselect/zsh/aliases/fselect.sh" "$HOME/.config/zsh/aliases/fselect.sh"

# Copy fzf files to .config
ln -s "$DOTFILES_DIR/configs/fzf/zsh/aliases/fzf.sh" "$HOME/.config/zsh/aliases/fzf.sh"
ln -s "$DOTFILES_DIR/configs/fzf/zsh/exports/fzf.sh" "$HOME/.config/zsh/exports/fzf.sh"
ln -s "$DOTFILES_DIR/configs/fzf/zsh/registrations/fzf.sh" "$HOME/.config/zsh/registrations/fzf.sh"

# Copy git files to .config
ln -s "$DOTFILES_DIR/configs/git/.config/config" "$HOME/.config/git/config"

# Copy jq files to .config
ln -s "$DOTFILES_DIR/configs/jq/zsh/aliases/jq.sh" "$HOME/.config/zsh/aliases/jq.sh"

# Copy starship files to .config
ln -s "$DOTFILES_DIR/configs/starship/.config/starship.toml" "$HOME/.config/starship.toml"
ln -s "$DOTFILES_DIR/configs/starship/zsh/registrations/starship.sh" "$HOME/.config/zsh/registrations/starship.sh"

# Copy tldr files to .config
ln -s "$DOTFILES_DIR/configs/tldr/zsh/aliases/tldr.sh" "$HOME/.config/zsh/aliases/tldr.sh"

# Copy zsh files to .config
ln -s "$DOTFILES_DIR/configs/zsh/.config/.zshrc" "$HOME/.zshrc"

# Configure vscode
git config --global delta.hyperlinks-file-link-format "vscode://file/{path}:{line}"
