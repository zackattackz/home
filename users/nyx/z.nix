
{ config, lib, pkgs, system, ... }:

with lib;

{
  imports = [ ../z.nix ];
  config = {
    autorandr.machine = "nyx";
    extraPackages.games.enable = true;
    wine.enable = true;
  };
}
