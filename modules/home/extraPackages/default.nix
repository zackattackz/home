{config, lib, pkgs, ...}:

with lib;

{
  imports = [
    ./system.nix
    ./games.nix
  ];
}
