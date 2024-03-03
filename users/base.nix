
{config, lib, pkgs, homeModulesPath, ...}:

{
  imports = [
    (homeModulesPath + /desktop)
    (homeModulesPath + /extraPackages)
    (homeModulesPath + /firefox)
    (homeModulesPath + /git)
    (homeModulesPath + /gpg)
    (homeModulesPath + /meta)
    (homeModulesPath + /neovim)
    (homeModulesPath + /nixvim)
    (homeModulesPath + /odoo)
    (homeModulesPath + /redshift)
    (homeModulesPath + /shell)
    (homeModulesPath + /ssh)
    (homeModulesPath + /virt)
    (homeModulesPath + /wine)
  ];
}
