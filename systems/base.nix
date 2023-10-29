
{config, lib, pkgs, systemModulesPath, ...}:

{
  imports = [
    (systemModulesPath + /accounts)
    (systemModulesPath + /avahi)
    (systemModulesPath + /bluetooth)
    (systemModulesPath + /bootloader)
    (systemModulesPath + /docker)
    (systemModulesPath + /gnome-keyring)
    (systemModulesPath + /locale)
    (systemModulesPath + /meta)
    (systemModulesPath + /network)
    (systemModulesPath + /nvidia)
    (systemModulesPath + /os)
    (systemModulesPath + /pipewire)
    (systemModulesPath + /postgres)
    (systemModulesPath + /waydroid)
    (systemModulesPath + /xserver)
  ];
}
