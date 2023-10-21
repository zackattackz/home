{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.nvidia;
in
{
  options.nvidia = {
    enable = mkEnableOption "nvidia options";
  };
  config = mkIf cfg.enable {
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    services.xserver = {
      videoDrivers = [ "nvidia" ];
    };
  };
}
