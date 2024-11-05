
{config, lib, pkgs, homeModulesPath, system, stylix-config, ...}:

with lib;

{
  imports = [
    (homeModulesPath + /alacritty)
    (homeModulesPath + /autorandr)
    (homeModulesPath + /desktop)
    (homeModulesPath + /extraPackages)
    (homeModulesPath + /firefox)
    (homeModulesPath + /git)
    (homeModulesPath + /gpg)
    (homeModulesPath + /i3status-rust)
    (homeModulesPath + /i3-sway)
    (homeModulesPath + /lazygit)
    (homeModulesPath + /meta)
    (homeModulesPath + /mpd)
    (homeModulesPath + /neovim)
    (homeModulesPath + /nixvim)
    (homeModulesPath + /picom)
    (homeModulesPath + /polybar)
    (homeModulesPath + /redshift)
    (homeModulesPath + /rofi)
    (homeModulesPath + /shell)
    (homeModulesPath + /ssh)
    (homeModulesPath + /virt)
    (homeModulesPath + /vscode)
    (homeModulesPath + /wine)
    (homeModulesPath + /xmonad)
  ];
  stylix = stylix-config;
}
