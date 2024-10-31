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
      arandr
      alttab
      caffeine-ng
      vesktop
      element-desktop
      gnome.seahorse
      gnome.gnome-disk-utility
      gnome.file-roller
      gnumake
      transmission-gtk
      mpv
      feh
      ffmpeg-full
      jq
      killall
      tldr
      toolbox
      unzip
      xclip
      zip
      evince
      libreoffice
      trayer
      pavucontrol
      qalculate-gtk
      ripgrep
      # fonts
      siji
      noto-fonts-cjk
      font-awesome
corefonts
      vistafonts
      source-han-sans
    ];
  };
}
