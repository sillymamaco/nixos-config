{ config, pkgs, inputs, lib, ... }:
{
  imports = [ 
    ./hardware-configuration.nix 
    ../../modules/core/user.nix
    ../../modules/core/packages.nix 
    ../../modules/hardware/nvidia.nix 
    ../../modules/virtualization/docker.nix
  ];

  # Boot & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];

  # Networking & Unfree
  networking.hostName = "nixos";
  networking.networkmanager.enable = true; 
  nixpkgs.config.allowUnfree = true;

  # Power & Hardware
  services.power-profiles-daemon.enable = true;
  services.asusd.enable = true;
  services.supergfxd.enable = true;

  # Time & DBus
  time.timeZone = "Europe/Lisbon";
  services.timesyncd.enable = true;
  services.dbus.enable = true;
  services.dbus.implementation = "broker";
  programs.dconf.enable = true;

  # Fonts
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  # Audio & Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Native Window Manager Integration
  programs.niri.enable = true;


  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome 
      xdg-desktop-portal-gtk 
    ];
    config.niri.default = lib.mkForce "wlr";
  };

  # THE FIX: Inject NVIDIA variables directly into the background portal service
systemd.user.services.xdg-desktop-portal-gnome.environment = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };


  
  # Graphics Environment (Shell/Compositor)
environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    NIXOS_OZONE_WL = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    KITTY_LISTEN_ON = "unix:/tmp/kitty";
  };

  programs.bash.promptInit = ''PS1="\[\033[1;35m\]sillymamaco\[\033[0m\]@\[\033[1;34m\]nixos \[\033[1;37m\]\w\[\033[0m\] $ "'';
  services.greetd.settings.default_session = {
    command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
    user = "greeter";
  };

  system.stateVersion = "24.05";
}
