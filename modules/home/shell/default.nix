{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.shell;
  homeCfg = config.home;
  tmuxTerminal = "tmux-256color";
in
{
  options.shell.enable = mkEnableOption "Module concerning shell configuration, and services that shell utilities depend on.";
  config = mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.sessionPath = [
      "$HOME/.local/bin"
    ];

    xdg.enable = true;

    xdg.userDirs = rec {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "${homeCfg.homeDirectory}/documents";
      download = "${homeCfg.homeDirectory}/downloads";
      music = "${homeCfg.homeDirectory}/music";
      pictures = "${homeCfg.homeDirectory}/pictures";
      publicShare = null;
      templates = null;
      videos = "${homeCfg.homeDirectory}/videos";
      extraConfig = {
        "XDG_SCREENSHOTS_DIR" = "${pictures}/screenshots";
      };
    };

    programs.tmux = {
      enable = true;
      escapeTime = 1;
      mouse = true;
      sensibleOnTop = false;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      terminal = tmuxTerminal;
      extraConfig = ''
        # vim-like kill pane
        bind q kill-pane

        # vim-like pane
        bind -r w select-pane -l

        bind g copy-mode

        # use <prefix> s for horizontal split
        bind s split-window -v -c "#{pane_current_path}"
        # use <prefix> v for vertical split
        bind v split-window -h -c "#{pane_current_path}"
      '';
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.bash = {
      enable = true;
      shellAliases = {
        xclip = "xclip -sel clip";
        lg = "lazygit";
        ll = "ls -lah";
      };
      enableCompletion = true;
      historyControl = [ "ignoredups" ];
      historyIgnore = [ "exit" ];
      historySize = 50000;
      initExtra = ''
        #[[ -z "$TMUX" && $TERM != "${tmuxTerminal}" && $TERM != linux  && "$TERM_PROGRAM" != "vscode" ]] && exec tmux
        bind '"\C-k": history-search-backward'
        bind '"\C-j": history-search-forward'
        bind '"\C-p": "\C-M"'
      '';
    };

    impermanence.extraDirs = [
      ".local/share/direnv"
    ];
    impermanence.extraFiles = [
      ".bash_history"
    ];
  };
}
