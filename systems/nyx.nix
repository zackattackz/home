{ config, lib, pkgs, systemModulesPath, ... }:

with lib;

{
  imports = [
    ./base.nix
    (systemModulesPath + /hardware/nyx.nix)
  ];

  config = {
    gamemode.enable = true;
    steam.enable = true;
    network.hostName = "nyx";
    nvidia.enable = true;
    stylix.cursor.size = 32;
    stylix.fonts.sizes = {
      applications = 12;
      terminal = 12;
    };
  };
}
