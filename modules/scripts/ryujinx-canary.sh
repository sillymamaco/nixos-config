export AVALONIA_SCREEN_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export GDK_BACKEND=wayland
exec steam-run /home/sillymamaco/.local/share/ryujinx-canary/Ryujinx --root /home/sillymamaco/.config/Ryujinx "$@"
