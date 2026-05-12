{ pkgs, inputs, lib, ... }:
let
  dms-patched = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

  wrapWayland = pkg: bin: pkgs.symlinkJoin {
    name = "${bin}-wayland";
    paths = [ pkg ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/${bin} \
        --unset GBM_BACKEND \
        --add-flags "--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer --ozone-platform=wayland --enable-wayland-ime --disable-gpu-memory-buffer-video-frames"
    '';
  };

  wrapSoftware = pkg: bin: pkgs.symlinkJoin {
    name = "${bin}-software-fallback";
    paths = [ pkg ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/${bin} \
        --set LIBGL_ALWAYS_SOFTWARE "1"
    '';
  };

  ryujinxScript = pkgs.writeShellScriptBin "ryujinx-canary" (builtins.readFile ../scripts/ryujinx-canary.sh);

  ryujinxDesktop = pkgs.makeDesktopItem {
    name = "ryujinx-canary";
    desktopName = "Ryujinx Canary";
    exec = "ryujinx-canary";
    icon = "ryujinx";
    terminal = false;
    type = "Application";
    categories = [ "Game" "Emulator" ];
  };

in
{
  environment.systemPackages = with pkgs; [
    # Core Tools
    git neovim kitty fd rofi fastfetch slurp brightnessctl jq psmisc ffmpeg
    dms-patched pkgs.quickshell matugen swaybg inotify-tools glib steam-run 
    xwayland-satellite networkmanager pipewire wireplumber wf-recorder libnotify
    discord kdePackages.dolphin gnugrep pulseaudio ripes zathura zsh

    # Apps, Gaming & Dev Tools
    (wrapWayland pkgs.vesktop "vesktop")
    (wrapWayland pkgs.heroic "heroic")
    (wrapSoftware pkgs.karere "karere")

    prismlauncher steam ripes gcc gdb valgrind gnumake python3 binutils unzip

    # Scripts extracted to files
    ryujinxScript
    ryujinxDesktop
    (pkgs.writeShellScriptBin "dms-engine" (builtins.readFile ../scripts/dms-engine.sh))
    (pkgs.writeShellScriptBin "record-screen" (builtins.readFile ../scripts/record-screen.sh))
  ];
}
