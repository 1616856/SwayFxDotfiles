CACHE_FILE="$HOME/.cache/waybar_brightness"
if [ ! -f "$CACHE_FILE" ]; then
    CURRENT=$(ddcutil getvcp 10 | grep -oP 'current value =\s*\K[0-9]+' || echo "50")
    echo "$CURRENT" > "$CACHE_FILE"
fi
CURRENT=$(cat "$CACHE_FILE")
case "$1" in
    get)
        echo "$CURRENT"
        ;;
    up)
        NEW=$(( CURRENT + 5 ))
        [ $NEW -gt 100 ] && NEW=100
        echo "$NEW" > "$CACHE_FILE"
        echo "$NEW"
        ddcutil setvcp 10 "$NEW" > /dev/null 2>&1 &
        ;;
    down)
        NEW=$(( CURRENT - 5 ))
        [ $NEW -lt 0 ] && NEW=0
        echo "$NEW" > "$CACHE_FILE"
        echo "$NEW"
        ddcutil setvcp 10 "$NEW" > /dev/null 2>&1 &
        ;;
esac
