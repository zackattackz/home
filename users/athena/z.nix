
{ config, lib, pkgs, system, ... }:

with lib;

{
  imports = [ ../z.nix ];
  config = {
    autorandr.enable = mkForce false; #TODO: implement athena
    autorandr.machine = "athena";
  };
}
