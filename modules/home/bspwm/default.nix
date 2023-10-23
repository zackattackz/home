{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.bspwm;
in
{
  options.bspwm = {
    enable = mkEnableOption "bspwm options";
  };
  config = mkIf cfg.enable {
    xsession ={
      enable = true;
        initExtra = ''
          eval $(${pkgs.gnome3.gnome-keyring}/bin/gnome-keyring-daemon --daemonize --components=ssh,secrets,pkcs11)
          export SSH_AUTH_SOCK
      '';
      windowManager.bspwm = {
        enable = true;
        monitors = {
          "${globals.firstMonitor}" = [ "web" "code" "term" "media" "games" ];
          "${globals.secondMonitor}" = [ "games2" ];
        };
        settings = {
          border_width = 3;
          external_rules_command = "${globals.homeDirectory}/.local/bin/external_rules_command";
        };
        extraConfig = ''
          feh --no-fehbg --bg-center ${globals.wallpaperPath}
        '';
      };
    };
  };
}
