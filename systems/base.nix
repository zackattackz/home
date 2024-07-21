
{config, lib, pkgs, systemModulesPath, overlay, stylix-image, ...}:

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
  stylix.enable = true;
  stylix.image = stylix-image;
  stylix.polarity = "dark";
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
