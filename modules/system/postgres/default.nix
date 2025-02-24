{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.postgres;
in
{
  options.postgres.enable = mkEnableOption "postgresql options";
  config = mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      authentication = lib.mkForce ''
        # Generated file; do not edit!
        # TYPE  DATABASE        USER            ADDRESS                 METHOD
        local   all             all                                     trust
        host    all             all             127.0.0.1/32            trust
        host    all             all             ::1/128                 trust
      '';
      ensureUsers = [
        {
          name = "z";
          ensureDBOwnership = true;
          ensureClauses.createdb = true;
        }
      ];
      ensureDatabases = [
        "z"
      ];
    };
  };
}
