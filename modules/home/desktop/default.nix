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
    gtk = {
      enable = true;
        iconTheme = {
        name = "Adwaita";
      };
      theme = {
        name = "Adwaita-dark";
      };
      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
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
  };
}
