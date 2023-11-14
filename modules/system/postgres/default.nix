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
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
      ensureUsers = [
        {
          name = "zaha";
          ensurePermissions = {
            "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES"; 
          };
          ensureClauses.createdb = true;
        }
        {
          name = "zaha-odoo";
          ensurePermissions = {
            "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
            "SCHEMA public" = "USAGE";
            "FUNCTION pg_stat_file(text)" = "EXECUTE";
          };
          ensureClauses.createdb = true;
        }
      ];
      ensureDatabases = [
        "zaha"
        "zaha-odoo"
      ];
    };
  };
}
