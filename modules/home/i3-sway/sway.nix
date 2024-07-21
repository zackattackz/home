{ config, lib, pkgs, ... }:

with lib;

let
  base-cfg = config.xsession.windowManager.i3;
  cfg = config.sway;
  i3status-rust-cfg-file = "${config.xdg.configHome}/i3status-rust/config-default.toml";
in
{
  imports = [
    ./common.nix
  ];
  options.sway = {
    enable = mkEnableOption "sway";
  };
  config = mkIf cfg.enable {
    i3-sway.menu = "${pkgs.wofi}/bin/wofi -show drun";
    programs.rofi.package = pkgs.wofi;
    wayland.windowManager.sway = {
      enable = true;
      config = {
        output.HDMI-A-1.disable = "";
        output.DP-1 = {
          enable = "";
          adaptive_sync = "on";
          mode = "3440x1440";
          pos = "0 0";
        };
        # menu = "${pkgs.rofi}/bin/rofi -show drun";
        # modifier = "Mod4";
        
        # bars = [
        #   ({
        #     position = "top";
        #     statusCommand = "i3status-rs ${i3status-rust-cfg-file}";
        #     workspaceButtons = true;
        #     workspaceNumbers = true;
        #   } // config.lib.stylix.i3.bar)
        # ];
        # startup = [
        #   { command = "autorandr --cycle # ;  systemctl --user restart polybar"; notification = false; }
        #   { command = "alttab -d 2 -sc 1"; notification = false; }
        # ];
      };
    };
  };
}
