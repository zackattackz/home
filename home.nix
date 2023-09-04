let
tmuxTerminal = "tmux-256color";
in
{ config, pkgs, ... }:

{
  nix.package = pkgs.nix;

  nix.settings = {
    extra-experimental-features = ["flakes" "nix-command"];
  };

  home.username = "zaha";
  home.homeDirectory = "/home/zaha";

  home.stateVersion = "23.05";

  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # home.file = {
    # ".examplerc".source = dotfiles/examplerc;

    # ".examplerc".text = ''
    #   exampleKey = exampleVal
    # '';
  # };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.home-manager.enable = true;

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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.git = {
    enable = true;
    userName = "Zachary Hanham";
    userEmail = "z.hanham00@gmail.com";
    aliases = {
      unstage = "reset HEAD --";
      pr = "pull --rebase";
      addp = "add --patch";
      comp = "commit --patch";
      co = "checkout";
      ci = "commit";
      c = "commit";
      b = "branch";
      p = "push";
      d = "diff";
      a = "add";
      s = "status";
      f = "fetch";
      br = "branch";
      pa = "add --patch";
      pc = "commit --patch";
      rf = "reflog";
      l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
      pp = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
      recent-branches = "branch --sort=-committerdate";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoredups" ];
    historyIgnore = [ "exit" ];
    historySize = 50000;
    initExtra = ''
      [[ -z "$TMUX" && $TERM != "${tmuxTerminal}" && "$TERM_PROGRAM" != "vscode" ]] && exec tmux
      bind '"\C-k": history-search-backward'
      bind '"\C-j": history-search-forward'
      bind '"\C-p": "\C-M"'
    '';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  services.gpg-agent.enable = true;
}
