{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.xserver;
in
{
  options.xserver.enable = mkEnableOption "xserver options";
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = lib.mkForce false;
      };
      excludePackages = [ pkgs.xterm ];
    };
  };
}
