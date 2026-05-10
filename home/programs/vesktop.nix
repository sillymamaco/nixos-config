{ config, pkgs, ... }:
{
  home.file.".local/share/applications/vesktop.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Vesktop
    Exec=env XDG_SESSION_TYPE=wayland XDG_CURRENT_DESKTOP=niri vesktop %U
    Icon=discord
    Categories=Network;InstantMessaging;
  '';
}
