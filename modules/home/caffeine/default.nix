{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.caffeine;
in
{
  options.caffeine = {
    enable = mkEnableOption "Caffeine";
  };
  config = mkIf cfg.enable {
    services.caffeine = {
      enable = true;
    };
    systemd.user.services.caffeine.Service.ProtectHome = lib.mkForce "no";
  };
}
