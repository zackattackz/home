{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.bootloader;
in
{
  options.bootloader = {
    enable = mkEnableOption "bootloader options";
    enableCryptoKeyfile = mkEnableOption "set boot.initrd.secrets crypto keyfile";
  };
  config = mkIf cfg.enable {
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.useOSProber = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.secrets = mkIf cfg.enableCryptoKeyfile {
      "/crypto_keyfile.bin" = null;
    };
  };
}
