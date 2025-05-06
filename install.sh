#!/bin/bash

# Backup existing configs (optional)
mkdir -p ~/.config-backup

# Hyprland
ln -sf ~/.ChikenRice/hypr/ ~/.config/hypr/

# fastfetch
ln -sf ~/.ChikenRice/fastfetch/presets/ ~/.config/fastfetch/presets

# Waybar
ln -sf ~/.ChikenRice/waybar/ ~/.config/waybar/

# fish
ln -sf ~/.ChikenRice/fish/config.fish ~/.config/fish/config.fish

#mako
ln -sf ~/.ChikenRice/mako/config ~/.config/mako/config

echo "Dotfiles symlinked!"
