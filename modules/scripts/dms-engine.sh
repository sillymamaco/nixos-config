CONFIG="$HOME/.config/awww/config.toml"
while true; do
  inotifywait -q -e close_write "$CONFIG"
  WALL=$(grep "path =" "$CONFIG" | cut -d '"' -f 2)
  if [ -f "$WALL" ]; then
    pkill -9 swaybg
    swaybg -i "$WALL" -m fill &
    matugen image "$WALL" -m dark
    bash "$HOME/.config/apply-colors.sh"
    touch "$HOME/.config/niri/config.kdl"
    dms ipc theme dark || true
  fi
done
