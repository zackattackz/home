{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.gnome-keyring;
in
{
  options.gnome-keyring.enable = mkEnableOption "gnome-keyring options";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.gnome.gnome-keyring ];
    services.gnome.gnome-keyring.enable = true;
  };
}
