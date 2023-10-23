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
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.secrets = (if cfg.enableCryptoKeyfile
    then
      {
        "/crypto_keyfile.bin" = null;
      }
    else
      { }
    );
  };
}
