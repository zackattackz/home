{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.gamemode;
in
{
  options.gamemode.enable = mkEnableOption "gamemode";
  config = mkIf cfg.enable {
    programs.gamemode.enable = true;
    programs.gamemode.settings.general.inhibit_screensaver = 0;
  };
}