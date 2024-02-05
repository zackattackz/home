{ config, lib, pkgs, systemModulesPath, ... }:

with lib;

{
  imports = [
    ./base.nix
    (systemModulesPath + /hardware/hermes.nix)
  ];

  config = {
    accounts.zaha-odoo.enable = true;

    atlasvpn.enable = true;

    avahi.enable = true;

    bluetooth.enable = true;

    bootloader.enable = true;

    docker.enable = true;

    geoclue2.enable = true;
    
    locale.enable = true;

    meta.enable = true;
    
    network.enable = true;
    network.hostName = "hermes";

    nix-ld.enable = true;

    os.enable = true;

    pipewire.enable = true;

    postgres.enable = true;

    waydroid.enable = true;

    xserver.enable = true;

    xfce.enable = true;


  };
}
