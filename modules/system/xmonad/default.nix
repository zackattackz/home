{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.xmonad;
in
{
  options.xmonad = {
    enable = mkEnableOption "xmonad";
  };
  config = mkIf cfg.enable {
    services.displayManager.defaultSession = "xmonad";
    services.xserver = {
      desktopManager.session = [{
        name = "xmonad";
        start = ''
          ${pkgs.runtimeShell} $HOME/.xsession-xmonad &
          waitPID=$!
        '';
      }];
    };
  };
}
