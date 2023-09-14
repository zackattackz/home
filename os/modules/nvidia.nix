{ config, pkgs, args, ...}:

if args.enable
then
{
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
}
else
{ }
