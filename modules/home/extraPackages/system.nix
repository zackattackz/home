{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.extraPackages.system;
in
{
  options.extraPackages.system = {
    enable = mkEnableOption "Packages needed for standard system functionality";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # applications
      atlasvpn
      caffeine-ng
      discord
      element-desktop
      gnome.seahorse
      gnome.gnome-disk-utility
      gnome.file-roller
      gnumake
      transmission-gtk
      mpv
      ffmpeg-full
      jq
      killall
      tldr
      unzip
      vscode
      xclip
      zip
      evince
      libreoffice
      pavucontrol
      qalculate-gtk
      ripgrep
      # fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [
        "FiraCode"
        "Iosevka"
        "Hack"
        "FantasqueSansMono"
        "ProggyClean"
      ]; })
    ];
  };
}
