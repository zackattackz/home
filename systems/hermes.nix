{ config, lib, pkgs, systemModulesPath, ... }:

with lib;

{
  imports = [
    ./base.nix
    (systemModulesPath + /hardware/hermes.nix)
  ];

  config = {
    accounts.zaha-odoo.enable = true;

    avahi.enable = true;

    bluetooth.enable = true;

    bootloader.enable = true;

    docker.enable = true;
    
    gnome-keyring.enable = true;

    locale.enable = true;

    meta.enable = true;
    
    network.enable = true;
    network.hostName = "hermes";

    os.enable = true;

    pipewire.enable = true;

    postgres.enable = true;

    waydroid.enable = true;

    xserver.enable = true;


  };
}
