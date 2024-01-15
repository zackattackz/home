{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.virt;
in
{
  options.virt.enable = mkEnableOption "virtualization";
  config = mkIf cfg.enable {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
