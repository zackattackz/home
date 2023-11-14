{config, lib, pkgs, globals, ...}:

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
      btop
      discord
      element-desktop
      gnome.seahorse
      gnumake
      jq
      libnotify
      ponymix
      scrot
      tldr
      vscode
      xclip
      xdotool

      # fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      siji
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
