
{ config, lib, pkgs, system, ... }:

with lib;

{
  imports = [ ../z.nix ];
  config = {
    autorandr.machine = "athena";
  };
}
