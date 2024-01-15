{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.atlasvpn;
in
{
  options.atlasvpn.enable = mkEnableOption "atlasvpn";
  config = mkIf cfg.enable {
    systemd.sockets.atlasvpnd = {
      description = "AtlasVPN Daemon Socket";
      partOf = [ "atlasvpnd.service" ];
      listenStreams = [ "/run/atlasvpn/atlasvpnd.sock" ];
      wantedBy = [ "sockets.target" ];
      socketConfig = {
        "SocketGroup" = "atlasvpn";
        "SocketMode" = "0770";
        "DirectoryMode" = "0750";
        "NoDelay" = true;
      };
    };
    systemd.services.atlasvpnd = {
      description = "AtlasVPN Daemon";
      path = [ pkgs.iproute2 pkgs.procps ];
      requires = [ "atlasvpnd.socket" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        "ExecStart" = "${pkgs.atlasvpn}/bin/atlasvpnd";
        "NonBlocking" = true;
        "KillMode" = "process";
        "Restart" = "on-failure";
        "RestartSec" = "5";
        "StateDirectory" = "atlasvpn";
        "RuntimeDirectory" = "atlasvpn";
        "RuntimeDirectoryMode" = "0750";
        "Group" = "atlasvpn";
      };
    };
    users.extraGroups = { atlasvpn = {}; };
  };
}
