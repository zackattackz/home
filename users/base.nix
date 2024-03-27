
{config, lib, pkgs, homeModulesPath, system, ...}:

with lib;

{
  imports = [
    (homeModulesPath + /alacritty)
    (homeModulesPath + /desktop)
    (homeModulesPath + /extraPackages)
    (homeModulesPath + /firefox)
    (homeModulesPath + /git)
    (homeModulesPath + /gpg)
    (homeModulesPath + /i3status-rust)
    (homeModulesPath + /i3-sway)
    (homeModulesPath + /meta)
    (homeModulesPath + /neovim)
    (homeModulesPath + /nixvim)
    (homeModulesPath + /odoo)
    (homeModulesPath + /picom)
    (homeModulesPath + /redshift)
    (homeModulesPath + /rofi)
    (homeModulesPath + /shell)
    (homeModulesPath + /ssh)
    (homeModulesPath + /virt)
    (homeModulesPath + /wine)
    (homeModulesPath + /xmonad)
  ];
}
