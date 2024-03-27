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
    services.xserver = {
      displayManager.defaultSession = "xmonad";
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
