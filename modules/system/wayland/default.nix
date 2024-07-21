{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.wayland;
in
{
  options.wayland.enable = mkEnableOption "wayland";
  config = mkIf cfg.enable {
    programs.xwayland.enable = true;
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
