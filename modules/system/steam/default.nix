{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.steam;
in
{
  options.steam.enable = mkEnableOption "steam options";
  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      fontPackages = with pkgs; [
        corefonts
        vistafonts
        source-han-sans
      ];
    };
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
    hardware.steam-hardware.enable = true;
    impermanence.extraUserDirs = [
      ".steam"
      ".local/share/Steam"
    ];
  };
}
