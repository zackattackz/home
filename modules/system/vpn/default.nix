{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.vpn;
in
{
  options.vpn.enable = mkEnableOption "vpn";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.openvpn ];
  };
}
