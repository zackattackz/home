
{config, lib, pkgs, systemModulesPath, overlay, stylix-config, ...}:

{
  imports = [
    (systemModulesPath + /accounts)
    (systemModulesPath + /avahi)
    (systemModulesPath + /bluetooth)
    (systemModulesPath + /bootloader)
    (systemModulesPath + /desktop)
    (systemModulesPath + /displaymanager)
    (systemModulesPath + /docker)
    (systemModulesPath + /gamemode)
    (systemModulesPath + /geoclue2)
    (systemModulesPath + /i3-sway)
    (systemModulesPath + /locale)
    (systemModulesPath + /meta)
    (systemModulesPath + /network)
    (systemModulesPath + /nix-ld)
    (systemModulesPath + /nvidia)
    (systemModulesPath + /os)
    (systemModulesPath + /pipewire)
    (systemModulesPath + /podman)
    (systemModulesPath + /postgres)
    (systemModulesPath + /steam)
    (systemModulesPath + /virt)
    (systemModulesPath + /vpn)
    (systemModulesPath + /waydroid)
    (systemModulesPath + /wayland)
    (systemModulesPath + /xserver)
    (systemModulesPath + /xfce)
    (systemModulesPath + /xmonad)
  ];
  nixpkgs.overlays = [ overlay ];
  stylix = stylix-config;
}
