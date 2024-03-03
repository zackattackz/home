{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.xfce;
in
{
  options.xfce.enable = mkEnableOption "xfce";
  config = mkIf cfg.enable {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-media-tags-plugin
          thunar-volman
        ];
      };
    };
    services.xserver.desktopManager.xfce.enable = true;
    environment.systemPackages = with pkgs.xfce; [
      catfish
      orage
      xfce4-appfinder
      xfce4-clipman-plugin
      xfce4-cpugraph-plugin
      xfce4-dict
      xfce4-fsguard-plugin
      xfce4-netload-plugin
      xfce4-panel
      xfce4-pulseaudio-plugin
      xfce4-systemload-plugin
      xfce4-weather-plugin
      xfce4-whiskermenu-plugin
      xfce4-xkb-plugin
    ];
  };
}
