{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.wine;
in
{
  options.wine.enable = mkEnableOption "wine";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
        wineWowPackages.stable
        winetricks
    ];
  };
}