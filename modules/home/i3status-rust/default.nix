{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.i3status-rust;
  colors = config.stylix.base16Scheme;
  stylixTheme = config.lib.stylix.i3status-rust.bar // { separator = ""; };
  battery-format = " $icon $percentage.eng(w:4) ";
in
{
  options.i3status-rust = {
    enable = mkEnableOption "i3status-rust";
    enableBattery = mkEnableOption "battery block";
  };
  config = mkIf cfg.enable {
    programs.i3status-rust = {
      enable = true;
      bars.default.icons = "awesome6";
      bars.default.blocks = [
        {
          block = "disk_space";
          path = "/";
          info_type = "available";
          interval = 60;
          warning = 20.0;
          alert = 10.0;
        }
        {
          block = "memory";
          format = " $icon $mem_used_percents.eng(w:4) ";
          interval = 2;
        }
        {
          block = "cpu";
          format = " $icon $utilization.eng(w:4) ";
          interval = 2;
        }
        { 
          block = "sound";
          format = "$icon {$volume.eng(w:4) |} ";
          show_volume_when_muted = true;
          headphones_indicator = true;
        }
        (mkIf cfg.enableBattery {
          block = "battery";
          format = battery-format;
          full_format = battery-format;
          empty_format = battery-format;
          not_charging_format = battery-format;
        })
        {
          block = "time";
          interval = 60;
          format = " $timestamp.datetime(f:'%a %m/%d %I:%M %p') ";
        }
      ];
      bars.default.settings.theme.overrides = stylixTheme;
    };
  };
}

