{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.impermanence;
  cfg-users = config.accounts;
  userConf = {
    directories = cfg.extraUserDirs;
    files = cfg.extraUserFiles;
  };
in
{
  options.impermanence.enable = mkEnableOption "impermanenece";
  options.impermanence.extraDirs = mkOption {
    type = types.listOf types.str;
    default = [];
  };
  options.impermanence.extraFiles = mkOption {
    type = types.listOf types.str;
    default = [];
  };
  options.impermanence.extraUserDirs = mkOption {
    type = types.listOf types.str;
    default = [];
  };
  options.impermanence.extraUserFiles = mkOption {
    type = types.listOf types.str;
    default = [];
  };
  config = mkIf cfg.enable {
    programs.fuse.userAllowOther = true;
    environment.persistence."/persistent" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
      ] ++ cfg.extraDirs;
      files = [
        "/etc/machine-id"
        "/crypto_keyfile.bin"
      ] ++ cfg.extraFiles;
      users = lib.mapAttrs
        (_: _: userConf)
        cfg-users;
    };
  };
}
