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
    environment.variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      NVD_BACKEND = "direct";
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      forceFullCompositionPipeline = true;
    };

    services.xserver = {
      videoDrivers = [ "nvidia" ];
    };
  };
}
