
{config, lib, pkgs, homeModulesPath, system, stylix-image, ...}:

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
    (homeModulesPath + /meta)
    (homeModulesPath + /mpd)
    (homeModulesPath + /neovim)
    (homeModulesPath + /nixvim)
    (homeModulesPath + /odoo)
    (homeModulesPath + /picom)
    (homeModulesPath + /polybar)
    (homeModulesPath + /redshift)
    (homeModulesPath + /rofi)
    (homeModulesPath + /shell)
    (homeModulesPath + /ssh)
    (homeModulesPath + /virt)
    (homeModulesPath + /wine)
    (homeModulesPath + /xmonad)
  ];
  stylix.image = stylix-image;
  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.opacity.terminal = 0.83;
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Amber";
    size = 24;
  };
  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.nerdfonts.override {
        fonts = [
          "Iosevka"
        ];
      };
      name = "Iosevka NFM";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
}
