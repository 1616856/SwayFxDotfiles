#!/usr/bin/env bash

REPO_DIR="$HOME/dotfiles"

# 1. Create the repository folder structure
mkdir -p "$REPO_DIR/sway/scripts"
mkdir -p "$REPO_DIR/waybar/scripts"
mkdir -p "$REPO_DIR/rofi"
mkdir -p "$REPO_DIR/swaync"
mkdir -p "$REPO_DIR/kitty"

# 2. The cleaning engine
clean_file() {
    local src="$1"
    local dest="$2"
    if [ -f "$src" ]; then
        sed -e 's/[[:space:]]*#.*$//' \
            -e 's/[[:space:]]*\/\*.*\*\/[[:space:]]*//' \
            -e 's/[[:space:]]*\/\/.*$//' \
            -e '/^[[:space:]]*$/d' "$src" > "$dest"
    fi
}

# 3. Process Sway & Core
clean_file "$HOME/.config/sway/config" "$REPO_DIR/sway/config"
clean_file "$HOME/.config/sway/scripts/toggle_record.sh" "$REPO_DIR/sway/scripts/toggle_record.sh"
clean_file "$HOME/.config/hyprlock.conf" "$REPO_DIR/hyprlock.conf"

# 4. Process Waybar
clean_file "$HOME/.config/waybar/style.css" "$REPO_DIR/waybar/style.css"
clean_file "$HOME/.config/waybar/config.jsonc" "$REPO_DIR/waybar/config.jsonc"
clean_file "$HOME/.config/waybar/scripts/brightness.sh" "$REPO_DIR/waybar/scripts/brightness.sh"

# 5. Process Rofi & Scripts
clean_file "$HOME/.config/rofi/config.rasi" "$REPO_DIR/rofi/config.rasi"
clean_file "$HOME/.config/rofi/wallpaper-grid.rasi" "$REPO_DIR/rofi/wallpaper-grid.rasi"
clean_file "$HOME/.config/Rofi-background-selector/rofi_background_selector.sh" "$REPO_DIR/rofi/rofi_background_selector.sh"

# 6. Process SwayNC & Kitty
clean_file "$HOME/.config/swaync/style.css" "$REPO_DIR/swaync/style.css"
clean_file "$HOME/.config/swaync/config.json" "$REPO_DIR/swaync/config.json"
clean_file "$HOME/.config/kitty/kitty.conf" "$REPO_DIR/kitty/kitty.conf"

# 7. Restore execute permissions for all scripts
chmod +x "$REPO_DIR/sway/scripts/toggle_record.sh"
chmod +x "$REPO_DIR/rofi/rofi_background_selector.sh"
chmod +x "$REPO_DIR/waybar/scripts/brightness.sh"

echo "Dotfiles compiled cleanly into $REPO_DIR with zero comments."
