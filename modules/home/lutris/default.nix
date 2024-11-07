{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.lutris;
in
{
  options.lutris.enable = mkEnableOption "lutris";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.lutris ];
    impermanence.extraDirs = [ ".local/share/lutris" ];
  };
}
