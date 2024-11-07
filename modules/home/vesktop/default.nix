{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.vesktop;
in
{
  options.vesktop.enable = mkEnableOption "vesktop";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.vesktop ];
    impermanence.extraDirs = [ ".config/vesktop" ];
  };
}
