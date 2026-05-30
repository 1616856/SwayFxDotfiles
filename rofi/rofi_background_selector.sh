WALL_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALL_DIR"
CHOICE=$(
    find "$WALL_DIR" -type f -regextype posix-extended -iregex '.*\.(png|jpg|jpeg|webp|gif|avif|bmp)' | while read -r img; do
        filename=$(basename "$img")
        echo -en "$filename\0icon\x1f$img\n"
    done | rofi -dmenu \
                -p "󰸉 Wallpapers" \
                -theme "$HOME/.config/rofi/wallpaper-grid.rasi" \
                -show-icons
)
[[ -z "$CHOICE" ]] && exit 0
TARGET_WALL="$WALL_DIR/$CHOICE"
awww img "$TARGET_WALL" --transition-type grow --transition-pos top-right --transition-duration 1.5 --transition-fps 120
if command -v wal &> /dev/null; then
    wal -i "$TARGET_WALL" -n
    PRISM_THEME_DIR="$HOME/.local/share/prismlauncher/themes/Catppuccin-Mocha"
    if [ -d "$PRISM_THEME_DIR" ]; then
        COLOR_BG=$(jq -r '.special.background' "$HOME/.cache/wal/colors.json")
        COLOR_ACCENT=$(jq -r '.colors.color5' "$HOME/.cache/wal/colors.json")
        COLOR_TEXT=$(jq -r '.special.foreground' "$HOME/.cache/wal/colors.json")
        COLOR_MUTED=$(jq -r '.colors.color8' "$HOME/.cache/wal/colors.json")
        cat <<EOF > "$PRISM_THEME_DIR/theme.json"
{
    "colors": {
        "AlternateBase": "${COLOR_BG}80",
        "Base": "${COLOR_BG}80",
        "BrightText": "${COLOR_TEXT}",
        "Button": "${COLOR_MUTED}aa",
        "ButtonText": "${COLOR_TEXT}",
        "Highlight": "${COLOR_ACCENT}",
        "HighlightedText": "${COLOR_BG}",
        "Link": "${COLOR_ACCENT}",
        "Text": "${COLOR_TEXT}",
        "ToolTipBase": "${COLOR_TEXT}",
        "ToolTipText": "${COLOR_TEXT}",
        "Window": "${COLOR_BG}aa",
        "WindowText": "${COLOR_TEXT}",
        "fadeAmount": 0.5,
        "fadeColor": "${COLOR_MUTED}"
    },
    "logColors": {
        "Launcher": "${COLOR_ACCENT}",
        "Error": "
        "Warning": "
        "Debug": "
        "FatalHighlight": "
        "Fatal": "${COLOR_BG}"
    },
    "name": "Pywal Glass Dynamic",
    "widgets": "Fusion"
}
EOF
    fi
    swaymsg reload
    pkill -SIGUSR2 waybar
fi
