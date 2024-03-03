{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.displaymanager;
in
{
  options.displaymanager.enable = mkEnableOption "displaymanager";
  config = mkIf cfg.enable {
    services.xserver.displayManager = {
      defaultSession = "xfce";
      lightdm = {
        enable = true;
        greeters.slick = {
          enable = true;
          theme.name = "Adwaita-dark";
        };
      };
    };
  };
}
