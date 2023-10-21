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
      desktopManager.xterm.enable = false;
      desktopManager.session = [
        {
          name = "xsession";
          start = ''
            ${pkgs.runtimeShell} $HOME/.xsession &
            waitPID=$!
          '';
        }
      ];

      displayManager.lightdm.enable = true;
      displayManager.sessionCommands = ''
        ${pkgs.lightlocker}/bin/light-locker &
      '';
      displayManager.defaultSession = "xsession";
    };
  };
}
