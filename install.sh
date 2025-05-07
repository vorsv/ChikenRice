#!/bin/bash

# Dotfiles directory (where this script is located)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Backup directory (for existing configs)
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to safely create symlinks
link_file() {
    local src="$1"
    local dst="$2"
    
    # If destination exists, back it up first
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        echo "Backing up existing: $dst → $BACKUP_DIR/"
        mv "$dst" "$BACKUP_DIR/"
    fi
    
    echo "Creating symlink: $src → $dst"
    ln -s "$src" "$dst"
}

# Main linking process
echo "=== Setting up dotfiles ==="

# Fastfetch
mkdir -p "$HOME/.config/fastfetch"
link_file "$DOTFILES_DIR/fastfetch/defaultNew.jsonc" "$HOME/.config/fastfetch/config.jsonc"

# Fish
mkdir -p "$HOME/.config/fish"
link_file "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"
link_file "$DOTFILES_DIR/fish/functions" "$HOME/.config/fish/functions"

# Hyprland
mkdir -p "$HOME/.config/hypr"
link_file "$DOTFILES_DIR/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
link_file "$DOTFILES_DIR/hypr/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
link_file "$DOTFILES_DIR/hypr/hyprstart" "$HOME/.config/hypr/hyprstart"
link_file "$DOTFILES_DIR/hypr/scripts" "$HOME/.config/hypr/scripts"

# Mako
mkdir -p "$HOME/.config/mako"
link_file "$DOTFILES_DIR/mako/config" "$HOME/.config/mako/config"

# Waybar
mkdir -p "$HOME/.config/waybar"
link_file "$DOTFILES_DIR/waybar/config" "$HOME/.config/waybar/config"
link_file "$DOTFILES_DIR/waybar/style.css" "$HOME/.config/waybar/style.css"
link_file "$DOTFILES_DIR/waybar/scripts" "$HOME/.config/waybar/scripts"

echo "=== Done! ==="
echo "Original configs were backed up to: $BACKUP_DIR"
