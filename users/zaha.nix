
{ config, lib, pkgs, homeFilesPath, ... }:

with lib;

{
  
  imports = [ ./base.nix ];
  
  config = {

    alacritty.enable = true;

    autorandr.enable = true;
    
    bspwm.enable = true;

    caffeine.enable = true;

    desktop = {
      enable = true;
      cursorName = "Nordzy-cursors";
    };

    extraPackages.system.enable = true;
    extraPackages.games.enable = true;

    feh.enable = true;

    file.enable = true;
    file.autorandrBspcCmds = {
      "single" = "bspc monitor 'HDMI-0' -r";
      "double" = "bspc monitor 'HDMI-0' -a second";
    };

    firefox.enable = true;

    git.enable = true;

    locker.enable = true;

    meta.enable = true;

    neovim.enable = true;

    picom.enable = true;

    polybar.enable = true;

    rofi.enable = true;

    shell.enable = true;

    ssh.enable = true;
    ssh.zaha.enable = true;

    sxhkd.enable = true;
    
    themes.enable = true;
    themes.theme = "nord";
  };
}
