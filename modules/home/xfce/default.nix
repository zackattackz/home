{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.xfce;
in
{
  options.xfce = {
    enable = mkEnableOption "xfce";
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
    };
    qt = {
      enable = true;
      platformTheme = "gtk3";
      style.name = "Adwaita-dark";
    };
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };
}
