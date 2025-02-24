
{ config, lib, pkgs, system, ... }:

with lib;

{
  imports = [ ../z.nix ];
  config = {
    autorandr.machine = "athena";
    i3.enableBacklight = true;
    i3status-rust.enableBattery = true;
  };
}
