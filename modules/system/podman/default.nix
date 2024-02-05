{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.podman;
in
{
  options.podman.enable = mkEnableOption "podman";
  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
