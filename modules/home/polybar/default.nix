{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.polybar;
  mainfont = config.stylix.fonts.monospace.name;
in
{
  options.polybar.enable = mkEnableOption "polybar options";
  config = mkIf cfg.enable {
    # systemd.user.services.polybar.Install.WantedBy = lib.mkForce [];
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        pulseSupport = true;
        i3Support = true;
      };
      settings = {
        "bar/main" = {
          # monitor = globals.firstMonitor;
          width = "100%";
          height = 27;
          line-size = 3;
          padding-left = 2;
          padding-right = 2;
          module-margin-left = 1;
          module-margin-right = 2;
          font-0 = "${mainfont}:pixelsize=10";
          font-1 = "Siji:pixelsize=10";
          modules-left = "i3";
          modules-right = "pulseaudio date";
          tray-position = "right";
          tray-padding = 2;
          wm-restack = "i3";
          cursor-click = "pointer";
          cursor-scroll = "ns-resize";
        };
        "module/i3" = {
          type = "internal/i3";
          ws-icon-0 = "1";
          ws-icon-1 = "2";
          ws-icon-2 = "3";
          ws-icon-3 = "4";
          ws-icon-4 = "5";
          # label-focused = "%icon%";
          #label-occupied = "%icon%";
          # label-urgent = "%icon%";
          # label-empty = "%icon%";
          #label-separator = "|";
          label-separator-padding = 2;
        };
        "module/pulseaudio" = {
          type = "internal/pulseaudio";
          label-volume = "%percentage%%";
          format-volume = "<ramp-volume> <label-volume>";
          ramp-volume-0 = "";
          ramp-volume-1 = "";
          ramp-volume-2 = "";
          label-muted = "";
        };
        "module/wireless-network" = {
          type = "internal/network";
          interface = "wlp2s0";
          interval = 3.0;
          format-connected = "<ramp-signal> <label-connected>";
          label-connected = "%essid%  %downspeed%  %upspeed%";
          format-disconnected = "";
          ramp-signal-0 = "";
          ramp-signal-1 = "";
          ramp-signal-2 = "";
          ramp-signal-3 = "";
          ramp-signal-4 = "";
        };
        "module/wired-network" = {
          type = "internal/network";
          interface = "enp3s0";
          interval = 3.0;
          format-connected-prefix = " ";
          label-connected = " %downspeed%  %upspeed%";
          format-disconnected = "";
        };
        "module/date" = {
          type = "internal/date";
          interval = 5;
          date = "";
          date-alt = " %Y-%m-%d";
          time = "%I:%M %p";
          time-alt = "%X";
          format-prefix = "";
          label = "%date% %time%";
        };
      };
      script = ''polybar main &'';
    };
  };
}
