{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.bspwm;
in
{
  options.bspwm = {
    enable = mkEnableOption "bspwm options";
  };
  config = mkIf cfg.enable {
    xsession ={
      enable = true;
      windowManager.bspwm = {
        enable = true;
        monitors = {
          "DP-0" = [ "web" "code" "term" "media" "games" ];
          "HDMI-0" = [ "games2" ];
        };
        settings = {
          border_width = 3;
          external_rules_command = "${globals.homeDirectory}/.local/bin/external_rules_command";
        };
        extraConfig = ''
          feh --no-fehbg --bg-center ${globals.wallpaperPath}
        '';
      };
    };
  };
}
