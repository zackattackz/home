
{ config, lib, pkgs, homeFilesPath, system, ... }:

with lib;

{
  imports = [ ../z.nix ];
  config = {
    autorandr.enable = mkForce false; #TODO: implement athena
    autorandr.machine = "athena";
  };
}
