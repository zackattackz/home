{config, lib, pkgs, globals, ...}:

with lib;

{
  imports = [
    ./system.nix
    ./games.nix
  ];
}
