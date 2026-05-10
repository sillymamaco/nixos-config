{ pkgs, config, inputs, ... }:
{
  imports = [
    ./themes/gtk.nix
    ./themes/qt.nix
    ./programs/kitty.nix
    ./programs/firefox.nix
    ./programs/vesktop.nix
  ];
  home.stateVersion = "24.05";
  programs.bash.shellAliases = {
    vesktop = "XDG_SESSION_TYPE=wayland XDG_CURRENT_DESKTOP=niri vesktop";
  };
}
