{ config, pkgs, ... }:
{
  users.users.sillymamaco = {
    isNormalUser = true;
    group = "sillymamaco";
    shell = pkgs.bashInteractive;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker" "input" ];
  };
  users.groups.sillymamaco = {};
}
