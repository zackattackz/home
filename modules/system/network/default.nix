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
    networking.hostName = cfg.hostName; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networking.networkmanager.enable = true;
    networking.firewall.enable = false;
    networking.enableIPv6 = false;
    boot.kernel.sysctl."net.ipv6.conf.enp3s0.disable_ipv6" = true;
  };
}
