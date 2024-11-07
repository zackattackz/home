{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.bluetooth;
  bluez-wireplumber-conf =
    pkgs.writeTextDir
      "share/wireplumber/bluetooth.lua.d/bluez-wireplumber-conf.lua"
      (readFile ./bluez-config.lua);
in
{
  options.bluetooth.enable = mkEnableOption "bluetooth options";
  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.pipewire.wireplumber.configPackages = [ bluez-wireplumber-conf ];
    impermanence.extraDirs = [ "/var/lib/bluetooth" ];
  };
}
