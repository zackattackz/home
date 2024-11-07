{ config, lib, pkgs, system, ... }:

with lib;

{
  imports = [
    ./base.nix
  ];
  config = {
    impermanence.user = "z";

    alacritty.enable = true;
    autorandr.enable = true;

    desktop.enable = true;

    extraPackages.system.enable = true;

    firefox.enable = true;

    git.enable = true;

    gpg.enable = true;

    impermanence.enable = true;
    i3.enable = true;
    #sway.enable = true;
    lazygit.enable = true;

    mpd.enable = true;

    nixvim.enable = true;

    picom.enable = true;

    polybar.enable = false;

    rofi.enable = true;

    seahorse.enable = true;

    shell.enable = true;

    ssh.enable = true;
    ssh.z.enable = true;

    vesktop.enable = true;

    virt.enable = true;
  };
}

