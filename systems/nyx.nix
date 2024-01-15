{ config, lib, pkgs, systemModulesPath, ... }:

with lib;

{
  imports = [
    ./base.nix
    (systemModulesPath + /hardware/nyx.nix)
  ];

  config = {
    accounts.zaha.enable = true;
    accounts.zaha-odoo.enable = true;

    atlasvpn.enable = true;

    avahi.enable = true;

    bluetooth.enable = true;

    bootloader.enable = true;
    bootloader.enableCryptoKeyfile = true;

    docker.enable = true;

    gamemode.enable = true;
    
    locale.enable = true;

    meta.enable = true;
    
    network.enable = true;
    network.hostName = "nyx";

    nvidia.enable = true;

    os.enable = true;

    pipewire.enable = true;
    postgres.enable = true;

    virt.enable = true;

    waydroid.enable = true;

    xserver.enable = true;

    xfce.enable = true;

  };
}
