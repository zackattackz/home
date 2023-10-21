{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.avahi;
in
{
  options.avahi.enable = mkEnableOption "avahi/sunshine options";
  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };
    };

    security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      capabilities = "cap_sys_admin+p";
      source = pkgs.sunshine + /bin/sunshine;
    };

    environment.systemPackages = [ pkgs.sunshine ];
    networking.firewall = {
      allowedTCPPorts = [ 47984 47989 48010 ];
      allowedUDPPortRanges = [
        { from = 47998; to = 48010; }
      ];
    };
  };
}
