{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.i3status-rust;
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
          format = " $timestamp.datetime(f:'%a %d/%m %r') ";
        }
      ];
    };
  };
}

