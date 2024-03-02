
{ config, lib, pkgs, homeFilesPath, ... }:

with lib;

{
  
  imports = [ ./base.nix ];
  
  config = {

    extraPackages.system.enable = true;
    extraPackages.games.enable = true;

    firefox.enable = true;

    git.enable = true;

    gpg.enable = true;

    meta.enable = true;

    neovim.enable = false;

    nixvim.enable = true;


    redshift.enable = true;

    shell.enable = true;

    ssh.enable = true;
    ssh.zaha.enable = true;
    ssh.zaha-odoo.enable = true;

    virt.enable = true;

    wine.enable = true;

    xfce.enable = true;

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
