{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.odoo;
in
{
  options.odoo.enable = mkEnableOption "odoo options";
  config = mkIf cfg.enable {
    home.sessionVariables = {
      OE_SUPPORT_PATH = "${globals.homeDirectory}/src/odoo/support-tools";
    };
    home.packages = [
      (pkgs.writeShellScriptBin "oe-support" ''
        $OE_SUPPORT_PATH/oe-support.py $@
      '')
      (pkgs.writeShellScriptBin "clean_database" ''
        $OE_SUPPORT_PATH/clean_database $@
      '')
    ];
    programs.bash.initExtra = ''
      source "$OE_SUPPORT_PATH/scripts/completion/oe-support-completion.sh"
      complete -o default -F _oe-support oe-support
      source "$OE_SUPPORT_PATH/scripts/completion/clean-database-completion.sh"
      complete -o default -F _clean-database clean_database
    '';
  };
}
