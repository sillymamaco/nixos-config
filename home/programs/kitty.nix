{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.85";
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled";
    };
    extraConfig = ''
      include ~/.config/kitty/dank-theme.conf
    '';
  };
}
