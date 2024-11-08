{ config, lib, pkgs, ... }:

with lib;

let
  base-cfg = config.xsession.windowManager.i3;
  cfg = config.i3;
  i3status-rust-cfg-file = "${config.xdg.configHome}/i3status-rust/config-default.toml";
in
{
  imports = [
    ./common.nix
  ];
  options.i3 = {
    enable = mkEnableOption "i3";
    enableBacklight = mkEnableOption "backlight control";
  };
  config = mkIf cfg.enable {
    xsession.enable = true;
    xsession.scriptPath = ".xsession-hm";
    xsession.profilePath = ".xprofile-hm";
    i3-sway.menu = "${pkgs.rofi}/bin/rofi -show drun -show-icons";
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        startup = [
          { command = "xsetroot -cursor_name left_ptr"; notification = false; }
        ];
        keybindings = mkIf cfg.enableBacklight {
          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86MonBrightnessDown" = "exec light -U 5";
        };
        # Force indicator color to be same as border color
        colors.focused.indicator = mkForce base-cfg.config.colors.focused.border;
      };
    };
  };
}
