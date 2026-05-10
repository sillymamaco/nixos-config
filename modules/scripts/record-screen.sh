OUTPUT_DIR="$HOME/Videos/Recordings"
RAW_FILE="/tmp/recording_raw.mkv"
PID_FILE="/tmp/recording.pid"
mkdir -p "$OUTPUT_DIR"

TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
OUTPUT_FILE="$OUTPUT_DIR/recording_$TIMESTAMP.mp4"

if [ -f "$PID_FILE" ]; then
  notify-send "Recording" "Processing for Web..."
  kill -INT $(cat "$PID_FILE") 2>/dev/null
  rm -f "$PID_FILE"
  
  sleep 1.5
  
  ffmpeg -i "$RAW_FILE" \
    -c:v libx264 -preset fast -profile:v main -pix_fmt yuv420p \
    -c:a aac \
    -movflags +faststart \
    "$OUTPUT_FILE" -y > /tmp/ffmpeg.log 2>&1
    
  rm -f "$RAW_FILE"
  notify-send "Recording" "Saved and Web-Ready!"
else
  rm -f "$RAW_FILE"
  notify-send "Recording" "Started..."
  
  # Target the desktop audio output monitor instead of the microphone
  DEFAULT_SINK=$(pactl get-default-sink)
  
  wf-recorder \
    -c libx264 \
    --framerate 60 \
    --audio="$DEFAULT_SINK.monitor" \
    -f "$RAW_FILE" > /tmp/recording.log 2>&1 &
  
  echo $! > "$PID_FILE"
fi
