{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.bootloader;
in
{
  options.bootloader.enable = mkEnableOption "bootloader options";
  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
  };
}
