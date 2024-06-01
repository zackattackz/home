{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.i3-sway;
in
{
  options.i3-sway = {
    enable = mkEnableOption "i3-sway";
  };
  config = mkIf cfg.enable {
    services.displayManager.defaultSession = "xsession";
    services.xserver = {
      desktopManager.session = [{
        name = "xsession";
        start = ''
          ${pkgs.runtimeShell} $HOME/.xsession-hm & 2>&1 > $HOME/log.txt
          waitPID=$!
        '';
      }];
    };
  };
}

