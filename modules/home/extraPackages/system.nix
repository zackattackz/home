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
      discord
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
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          ms-python.python
          ms-python.debugpy
          ms-python.black-formatter
          ms-python.vscode-pylance
          ms-python.isort
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-ssh
          mkhl.direnv
          golang.go
          bbenoist.nix
        ];
      })
    ];
  };
}
