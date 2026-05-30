if pgrep -x "wf-recorder" > /dev/null; then
    pkill -INT -x "wf-recorder"
    notify-send "Recording Saved" "Video saved to your Videos folder" -i video-display
    exit 0
fi
mkdir -p "$HOME/Videos"
AUDIO_SINK=$(pactl get-default-sink).monitor
notify-send "Recording Started" "Capturing full screen..." -i media-record
wf-recorder -c libx264 \
            -X \
            -a \
            --audio-device="$AUDIO_SINK" \
            -f "$HOME/Videos/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4" > /dev/null 2>&1 &
