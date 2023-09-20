{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.hardware.nvidia;
in
{
  options.hardware.nvidia = {
    enable = mkEnableOption "enable/configure nvidia drivers";
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
