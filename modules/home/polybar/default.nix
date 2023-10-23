{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.polybar;
in
{
  options.polybar.enable = mkEnableOption "polybar options";
  config = mkIf cfg.enable {
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        pulseSupport = true;
      };
      settings = {
        "bar/main" = {
          monitor = globals.firstMonitor;
          width = "100%";
          height = 27;
          line-size = 3;
          padding-left = 2;
          padding-right = 2;
          module-margin-left = 1;
          module-margin-right = 2;
          font-0 = "${globals.fontFamily}:pixelsize=10";
          font-1 = "Siji:pixelsize=10";
          modules-left = "bspwm";
          modules-right = "pulseaudio wireless-network wired-network date";
          tray-position = "right";
          tray-padding = 2;
          wm-restack = "bspwm";
          cursor-click = "pointer";
          cursor-scroll = "ns-resize";
        };
        "module/bspwm" = {
          type = "internal/bspwm";
          ws-icon-0 = "web;";
          ws-icon-1 = "code;";
          ws-icon-2 = "term;";
          ws-icon-3 = "media;";
          ws-icon-4 = "games;";
          label-focused = "%icon%";
          label-occupied = "%icon%";
          label-urgent = "%icon%";
          label-empty = "%icon%";
          label-separator = "|";
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
      script = ''
      # wait until bspwm starts
      (
      until [[ -e /tmp/bspwm_0_0-socket ]]; do
        ${pkgs.coreutils-full}/bin/sleep 0.1
      done
      polybar main
      ) &
      '';
    };
  };
}
