{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.redshift;
in
{
  options.redshift.enable = mkEnableOption "redshift";
  config = mkIf cfg.enable {
    services.redshift = {
      enable = true;
      provider = "geoclue2";
      tray = true;
      temperature.night = 2500;
    };
  };
}
