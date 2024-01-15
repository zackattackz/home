
{config, lib, pkgs, homeModulesPath, ...}:

{
  imports = [
    (homeModulesPath + /extraPackages)
    (homeModulesPath + /firefox)
    (homeModulesPath + /git)
    (homeModulesPath + /gpg)
    (homeModulesPath + /meta)
    (homeModulesPath + /neovim)
    (homeModulesPath + /odoo)
    (homeModulesPath + /shell)
    (homeModulesPath + /ssh)
    (homeModulesPath + /virt)
    (homeModulesPath + /wine)
    (homeModulesPath + /xfce)
  ];
}
