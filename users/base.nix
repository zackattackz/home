
{config, lib, pkgs, homeModulesPath, ...}:

{
  imports = [
    (homeModulesPath + /alacritty)
    (homeModulesPath + /bspwm)
    (homeModulesPath + /desktop)
    (homeModulesPath + /extraPackages)
    (homeModulesPath + /feh)
    (homeModulesPath + /file)
    (homeModulesPath + /firefox)
    (homeModulesPath + /git)
    (homeModulesPath + /locker)
    (homeModulesPath + /meta)
    (homeModulesPath + /neovim)
    (homeModulesPath + /odoo)
    (homeModulesPath + /picom)
    (homeModulesPath + /polybar)
    (homeModulesPath + /rofi)
    (homeModulesPath + /shell)
    (homeModulesPath + /ssh)
    (homeModulesPath + /sxhkd)
    (homeModulesPath + /themes)
  ];
}
