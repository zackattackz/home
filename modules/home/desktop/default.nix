{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.desktop;
in
{
  options.desktop = {
    enable = mkEnableOption "desktop";
    fontFamily = mkOption {
      type = types.str;
    };
  };
  config = mkIf cfg.enable {
    gtk = {
      enable = true;
        iconTheme = {
        name = "Adwaita";
      };
      theme = {
        name = "Adwaita-dark";
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme=1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme=1;
      };
      cursorTheme = {
         name = "Adwaita";
         package = pkgs.gnome.adwaita-icon-theme;
         size = 16;
      };
    };
    qt = {
      enable = true;
      platformTheme = "gtk3";
      style.name = "Adwaita-dark";
    };
    home.pointerCursor = {
        x11.enable = true;
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size = 16;
    };
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
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
          font = "${cfg.fontFamily} 11";
        };
      };
    };
  };
}
