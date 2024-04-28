{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.mpd;
in
{
  options.mpd.enable = mkEnableOption "mpd";
  config = mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;
    };
    services.mpd = {
      enable = true;
    };
  };
}
