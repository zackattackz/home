{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.desktop;
in
{
  options.desktop.enable = mkEnableOption "desktop";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      blueman
    ];
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    security.pam.services.gdm.enableGnomeKeyring = true;
    services.blueman.enable = true;
    services.gnome.gnome-keyring.enable = true;
    impermanence.extraUserDirs = [ ".local/share/keyrings" ];
  };
}
