# Module concerning look/feel of desktop, fonts, and services relating to non WM UI.

{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.desktop;
in
{
  options.desktop = {
    enable = mkEnableOption "Module concerning look/feel of desktop, fonts, and services relating to non WM UI";
    cursorName = mkOption {
      type = types.str;
      example = "Nordzy-cursors";
      description = "Name of cursor theme to use";
    };
  };
  config = mkIf cfg.enable {
    home.pointerCursor = {
      package = pkgs.nordzy-cursor-theme;
      name = cfg.cursorName;
      size = 16;
      x11.enable = true;
      gtk.enable = true;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.nordic;
        name = "Nordic";
      };
      cursorTheme = {
         name = cfg.cursorName;
         size = 16;
      };
    };

    fonts.fontconfig.enable = true;

    services.blueman-applet.enable = true;

    services.dunst = {
      enable = true;
      settings = {
        global = {
          #transparency = 50;
          frame_width = 2;
          separator_height = 2;
          separator_color = "frame";
          font = "${globals.fontFamily} 11";
        };
      };
    };
  };
}
