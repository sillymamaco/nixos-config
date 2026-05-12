{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    # Enable Zsh integration automatically
    enableZshIntegration = true;

    settings = {
      # Minimalist layout: single line, no unnecessary empty space
      add_newline = false;

      # Define the order of modules
      format = pkgs.lib.concatStrings [
        "$os"
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$nix_shell"
        "$container"
        "$cmd_duration"
        "$character"
      ];

      # Module configurations
      os = {
        disabled = false;
        symbols = {
          NixOS = "❄️ ";
          Alpine = " ";
        };
      };

      username = {
        style_user = "white bold";
        style_root = "black bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };

      hostname = {
        ssh_only = false;
        format = "on [$hostname]($style) ";
        style = "dimmed white bold";
      };

      directory = {
        style = "bold blue";
        truncation_length = 3;
        truncation_symbol = "…/";
        read_only = " 󰌾";
      };

      git_branch = {
        symbol = " ";
        style = "bold purple";
      };

      git_status = {
        style = "bold red";
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
      };

      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state( \\($name\\))]($style) ";
        style = "bold blue";
      };

      cmd_duration = {
        min_time = 500;
        format = "took [$duration]($style) ";
      };

      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[➜](bold red) ";
      };
    };
  };
}
