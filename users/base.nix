
{config, lib, pkgs, homeModulesPath, system, ...}:

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
    (homeModulesPath + /impermanence)
    (homeModulesPath + /lazygit)
    (homeModulesPath + /lutris)
    (homeModulesPath + /mpd)
    (homeModulesPath + /nixvim)
    (homeModulesPath + /picom)
    (homeModulesPath + /polybar)
    (homeModulesPath + /rofi)
    (homeModulesPath + /seahorse)
    (homeModulesPath + /shell)
    (homeModulesPath + /ssh)
    (homeModulesPath + /vesktop)
    (homeModulesPath + /virt)
    (homeModulesPath + /wine)
  ];
  home.stateVersion = "23.05";
}
