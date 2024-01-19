
{ config, lib, pkgs, homeFilesPath, ... }:

with lib;

{
  
  imports = [ ./base.nix ];
  
  config = {

    extraPackages.system.enable = true;

    firefox.enable = true;

    git.enable = true;

    gpg.enable = true;
    
    meta.enable = true;

    neovim.enable = true;

    odoo.enable = true;

    redshift.enable = true;

    shell.enable = true;

    ssh.enable = true;
    ssh.zaha.enable = true;
    ssh.zaha-odoo.enable = true;

    wine.enable = true;

    xfce.enable = true;
  };
}
