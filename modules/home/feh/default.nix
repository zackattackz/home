{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.feh;
in
{
  options.feh.enable = mkEnableOption "feh options";
  config = mkIf cfg.enable {
    programs.feh = {
      enable = true;
    };
  };
}
