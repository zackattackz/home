{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.network;
in
{
  options.network = {
    enable = mkEnableOption "network options";
    hostName = mkOption {
      type = types.str;
    };
  };
  config = mkIf cfg.enable {
    networking.hostName = cfg.hostName;
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;
    networking.nftables.enable = true;
    impermanence.extraDirs = [ "/etc/NetworkManager/system-connections" ];
  };
}
