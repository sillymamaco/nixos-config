{ config, pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false; # Set to false for proprietary (most stable for 2050)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
