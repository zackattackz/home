
{ config, lib, pkgs, homeFilesPath, system, ... }:

with lib;

{
  
  imports = [ ../base.nix ];
  
  config = {
    
    alacritty.enable = true;

    autorandr = {
      enable = false;
      machine = "athena";
    };

    desktop.enable = true;
    # desktop.fontFamily = "Iosevka NFM";

    extraPackages.system.enable = true;
    extraPackages.games.enable = false;

    firefox.enable = true;

    git.enable = true;

    gpg.enable = true;
    
    i3.enable = true;
    #sway.enable = true;
    lazygit.enable = true;
    meta.enable = false;

    mpd.enable = true;

    neovim.enable = false;

    nixvim.enable = true;

    picom.enable = true;

    polybar.enable = false;

    redshift.enable = false;

    rofi.enable = true;

    shell.enable = true;

    ssh.enable = true;
    ssh.z.enable = true;

    virt.enable = true;
    
    vscode.enable = false;

    wine.enable = false;

    xmonad.enable = false;
  };
}
