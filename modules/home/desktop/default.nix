{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.desktop;
in
{
  options.desktop = {
    enable = mkEnableOption "desktop";
  };
  config = mkIf cfg.enable {
    qt = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
    gtk.iconTheme = {
      name = "candy-icons";
      package = pkgs.candy-icons;
    };
    fonts.fontconfig.enable = true;
    services.blueman-applet.enable = true;
    services.network-manager-applet.enable = true;
    services.dunst = {
      enable = true;
      settings = {
        global = {
          frame_width = 2;
          separator_height = 2;
        };
      };
    };

    systemd.user.services.polkit-mate-authentication-agent-1 = {
      Unit = {
        Description = "polkit-mate-authentication-agent-1";
        WantedBy = [ "graphical-session.target" ];
        Wants = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
          Type = "simple";
          ExecStart = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };
}
