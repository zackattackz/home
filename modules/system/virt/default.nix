{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.virt;
in
{
  options.virt.enable = mkEnableOption "virtualization";
  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    users.users.z.extraGroups = [ "libvirtd" ];
  };
}
