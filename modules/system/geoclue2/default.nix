{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.geoclue2;
in
{
  options.geoclue2.enable = mkEnableOption "geoclue2";
  config = mkIf cfg.enable {
    services.geoclue2.enable = true;
  };
}