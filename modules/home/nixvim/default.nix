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
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
        };
      };
      viAlias = true;
      vimAlias = true;
      clipboard.providers.xclip.enable = true;
      plugins = {
        direnv.enable = true;
        lazygit.enable = true;
        lualine = {
          enable = true;
          settings.colorscheme = "base16";
        };
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
            "<leader>bb" = "buffers";
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
    impermanence.extraDirs = [
      ".local/share/nvim"
      ".local/state/nvim"
    ];
  };
}
