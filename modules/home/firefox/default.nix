{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.firefox;
in
{
  options.firefox.enable = mkEnableOption "firefox options";
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
