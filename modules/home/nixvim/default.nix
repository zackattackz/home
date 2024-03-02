{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nixvim;
in
{
  options.nixvim.enable = mkEnableOption "nixvim options";
  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      colorschemes.kanagawa.enable = true;
      plugins = {
        direnv.enable = true;
        lightline.enable = true;
        lsp = {
          enable = true;
          servers = {
            nixd = {
              enable = true;
            };
          };
        };
        treesitter.enable = true;
        fugitive.enable = true;
      };
      options = {
        autoindent = true;
        expandtab = true;
        tabstop = 2;
        shiftwidth = 2;
        number = true;
        relativenumber = true;
      };
      globals = {
        mapleader = "<SPC>";
      };
    };
  };
}
