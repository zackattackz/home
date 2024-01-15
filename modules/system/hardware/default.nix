{ config, lib, pkgs, modulesPath, ... }:

{
  networking.useDHCP = lib.mkDefault true;
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}