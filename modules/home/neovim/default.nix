{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.neovim;
in
{
  options.neovim.enable = mkEnableOption "neovim options";
  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = ''
        set autoindent expandtab tabstop=2 shiftwidth=2
      '';
    };
  };
}
