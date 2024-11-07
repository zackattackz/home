{ config, lib, pkgs, ... }:

with lib;

{
  stylix = {
    image = ./wallpaper;
    base16Scheme = import ./scheme.nix;
    enable = true;
    polarity = "dark";
    opacity.terminal = 0.4;
    cursor = {
      package = pkgs.catppuccin-cursors.mochaRosewater;
      name = "catppuccin-mocha-rosewater-cursors";
    };
    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
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
  };
}
