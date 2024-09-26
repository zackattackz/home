{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.vscode;
in
{
  options.vscode.enable = mkEnableOption "vscode";
  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
          ms-python.python
          ms-python.debugpy
          ms-python.black-formatter
          ms-python.vscode-pylance
          ms-python.isort
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-ssh
          mkhl.direnv
          golang.go
          bbenoist.nix
          elixir-lsp.vscode-elixir-ls
      ];
      # enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      userSettings = {
        "[nix]"."editor.tabSize" = 2;
      };
    };
  };
}
