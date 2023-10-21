{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.waydroid;
in
{
  options.waydroid.enable = mkEnableOption "waydroid options";
  config = mkIf cfg.enable {
    virtualisation.waydroid.enable = true;
  };
}
