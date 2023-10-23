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
    };
  };
}
