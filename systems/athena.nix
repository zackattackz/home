{ config, lib, pkgs, systemModulesPath, ... }:

with lib;

{
  imports = [
    ./base.nix
    (systemModulesPath + /hardware/athena.nix)
  ];

  config = {
    network.hostName = "athena";
  };
}
