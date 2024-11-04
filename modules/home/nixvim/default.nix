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
      # colorschemes.${colorscheme}.enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = {
        direnv.enable = true;
        lightline.enable = true;
        lsp = {
          enable = true;
          servers = {
            bashls = {
              enable = true;
            };
          };
        };
        telescope = {
          enable = true;
          # highlightTheme = colorscheme;
          keymaps = {
            "<leader>fb" = "buffers";
            "<leader>fg" = "live_grep";
            "<leader>ff" = "find_files";
            "<leader>fj" = "jumplist";
            "<c-p>" = "oldfiles";
          };
          extensions = {
            file-browser = {
              enable = true;
            };
            media-files.enable = true;
          };
        };
        treesitter = {
          enable = true;
          settings = {
            indent.enable = true;
          };
        };
        fugitive.enable = true;
        dashboard = {
          enable = true;
        };
        project-nvim = {
          enable = true;
          enableTelescope = true;
        };
        coq-nvim = {
          enable = true;
          settings.auto_start = true;
          settings.keymap.recommended = true;
        };
        web-devicons = {
          enable = true;
        };
      };
      opts = {
        autoindent = true;
        expandtab = true;
        tabstop = 2;
        shiftwidth = 2;
        number = true;
        relativenumber = true;
      };
      keymaps = [
        {
          mode = "n";
          key = " ";
          action = "<NOP>";
        }
        {
          mode = "n";
          key = "<leader>ft";
          action = ":Telescope file_browser<CR>";
        }
        {
          mode = "n";
          key = "<leader>fp";
          action = ":Telescope projects<CR>";
        }
      ];
      globals = {
        mapleader = " ";
      };
    };
  };
}
