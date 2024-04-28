{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.xmonad;
  fontFamily = config.desktop.fontFamily;
in
{
  options.xmonad = {
    enable = mkEnableOption "xmonad";

  };
  config = mkIf cfg.enable {
    home.packages = [ pkgs.xorg.xmessage ];
    xsession.enable = true;
    xsession.scriptPath = ".xsession-xmonad";
    xsession.profilePath = ".xprofile-xmonad";
    xsession.windowManager.xmonad = {
      enable = true;
      # enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
      ];
      config = ./xmonad.hs;
    };
    programs.xmobar = {
      enable = true;
      extraConfig = lib.readFile ./xmobarrc;
    };
  };
}

