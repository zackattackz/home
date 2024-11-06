{ config, lib, pkgs, systemModulesPath, ... }:

with lib;

{
  imports = [
    ./base.nix
    (systemModulesPath + /hardware/athena.nix)
  ];

  config = {
    accounts.z.enable = true;

    avahi.enable = true;

    bluetooth.enable = true;

    bootloader.enable = true;
    bootloader.enableCryptoKeyfile = true;

    desktop.enable = true;

    displaymanager.enable = true;

    docker.enable = true;

    gamemode.enable = false;
    
    geoclue2.enable = true;

    i3-sway.enable = true;
    impermanence.enable = true;   
    locale.enable = true;

    network.enable = true;
    network.hostName = "athena";

    nix-ld.enable = true;

    nvidia.enable = false;

    os.enable = true;

    pipewire.enable = true;

    podman.enable = true;

    postgres.enable = false;

    steam.enable = false;

    virt.enable = true;
    
    vpn.enable = true;

    waydroid.enable = false;

    # wayland.enable = true;

    xserver.enable = true;
  };
}
