{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.autorandr;
in
{
  options.autorandr = {
    enable = mkEnableOption "Autorandr";

  };
  config = mkIf cfg.enable {
    programs.autorandr = {
      enable = true;
    };
  }
}