
{ config, lib, pkgs, homeFilesPath, system, ... }:

with lib;

{
  
  imports = [ ./base.nix ];
  
  config = {
    
    alacritty.enable = true;

    desktop.enable = true;
    desktop.fontFamily = "Iosevka NFM";

    extraPackages.system.enable = true;
    extraPackages.games.enable = true;

    firefox.enable = true;

    git.enable = true;

    gpg.enable = true;
    
    i3status-rust.enable = false;
    i3-sway.enable = false;

    meta.enable = true;

    mpd.enable = true;

    neovim.enable = false;

    nixvim.enable = true;

    picom.enable = true;

    redshift.enable = true;

    rofi.enable = true;

    shell.enable = true;

    ssh.enable = true;
    ssh.zaha.enable = true;
    ssh.zaha-odoo.enable = true;

    virt.enable = true;

    wine.enable = true;

    xmonad.enable = true;

    oe-config = {
      enable = true;
      settings = {
        user = "zaha@odoo.com";
        src = "${config.home.homeDirectory}/src/odoo/versions";
        internal = "${config.home.homeDirectory}/src/odoo/internal";
      };
    };
  };
}
