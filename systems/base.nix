
{config, lib, pkgs, systemModulesPath, overlay, ...}:

{
  imports = [
    (systemModulesPath + /accounts)
    (systemModulesPath + /atlasvpn)
    (systemModulesPath + /avahi)
    (systemModulesPath + /bluetooth)
    (systemModulesPath + /bootloader)
    (systemModulesPath + /docker)
    (systemModulesPath + /gamemode)
    (systemModulesPath + /geoclue2)
    (systemModulesPath + /locale)
    (systemModulesPath + /meta)
    (systemModulesPath + /network)
    (systemModulesPath + /nix-ld)
    (systemModulesPath + /nvidia)
    (systemModulesPath + /os)
    (systemModulesPath + /pipewire)
    (systemModulesPath + /postgres)
    (systemModulesPath + /virt)
    (systemModulesPath + /waydroid)
    (systemModulesPath + /xserver)
    (systemModulesPath + /xfce)
  ];
  nixpkgs.overlays = [ overlay ];
}
