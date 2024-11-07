{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.seahorse;
in
{
  options.seahorse.enable = mkEnableOption "seahorse";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.seahorse ];
  };
}

