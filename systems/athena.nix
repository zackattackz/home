{ config, lib, pkgs, systemModulesPath, ... }:

with lib;

{
  imports = [
    ./base.nix
    (systemModulesPath + /hardware/athena.nix)
  ];

  config = {
    network.hostName = "athena";
    stylix.cursor.size = 16;
    stylix.fonts.sizes = {
      applications = 11;
      terminal = 10;
    };
    libinput.enable = true;
    libinput.dev = "/dev/input/event7";
    light = {
      enable = true;
      users = [ "z" ];
    };
  };
}
