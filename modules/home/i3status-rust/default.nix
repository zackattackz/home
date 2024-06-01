{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.i3status-rust;
  colors = config.stylix.base16Scheme;
in
{
  options.i3status-rust = {
    enable = mkEnableOption "i3status-rust";
  };
  config = mkIf cfg.enable {
    programs.i3status-rust = {
      enable = true;
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
          format = " $icon $mem_used_percents ";
          interval = 2;
        }
        {
          block = "cpu";
          interval = 2;
        }
        { block = "sound"; }
        {
          block = "time";
          interval = 60;
          format = " $timestamp.datetime(f:'%a %m/%d %I:%M %p') ";
        }
      ];
      bars.default.settings = {
        theme.overrides = {
          idle_bg = "#${colors.base00}";
          idle_fg = "#${colors.base05}";
          info_bg = "#${colors.base09}";
          info_fg = "#${colors.base05}";
          good_bg = "#${colors.base01}";
          good_fg = "#${colors.base05}";
          warning_bg = "#${colors.base0A}";
          warning_fg = "#${colors.base05}";
          critical_bg = "#${colors.base08}";
          critical_fg = "#${colors.base04}";
          separator_bg = "#${colors.base00}";
          separator_fg = "#${colors.base05}";
        };
      };
    };
  };
}

