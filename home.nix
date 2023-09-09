let
tmuxTerminal = "tmux-256color";
homeDirectory = "/home/zaha";
in
{ config, pkgs, ... }:

{
  nix.package = pkgs.nix;

  nix.settings = {
    extra-experimental-features = ["flakes" "nix-command"];
  };

  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home.username = "zaha";
  home.homeDirectory = homeDirectory;

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    i3lock-fancy-rapid
    discord
    steam
    lutris
    protonup-qt
    vscode
    gnome.seahorse
    xclip
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

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    documents = "${homeDirectory}/documents";
    download = "${homeDirectory}/downloads";
    music = "${homeDirectory}/music";
    pictures = "${homeDirectory}/pictures";
    publicShare = null;
    templates = null;
    videos = "${homeDirectory}/videos";
  };

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
    shellAliases = {
        xclip = "xclip -sel clip";
    };
    enableCompletion = true;
    historyControl = [ "ignoredups" ];
    historyIgnore = [ "exit" ];
    historySize = 50000;
    initExtra = ''
      [[ -z "$TMUX" && $TERM != "${tmuxTerminal}" && $TERM != linux  && "$TERM_PROGRAM" != "vscode" ]] && exec tmux
      bind '"\C-k": history-search-backward'
      bind '"\C-j": history-search-forward'
      bind '"\C-p": "\C-M"'
    '';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.feh = {
    enable = true;
  };

  programs.pywal = {
    enable = true;
  };

  programs.rofi = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "Iosevka NFM";
          style = "Regular";
        };
        bold = {
          family = "Iosevka NFM";
          style = "Boldr";
        };
        italic = {
          family = "Iosevka NFM";
          style = "Italic";
        };
        bold_italic = {
          family = "Iosevka NFM";
          style = "Bold Italic";
        };
        size = 15.0 ;
      };
    };
  };

  xsession ={
    enable = true;
    windowManager.bspwm = {
      enable = true;
      monitors = {
        "DP-0" = [ "1" "2" "3" "4" "5"];
      };
    };
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "alacritty";
      "super + w" = "firefox";
      "super + space" = "rofi -show drun";
      "super + {_,shift + }q" = "bspc node -{c,k}";
      "super + {1-9}" = "bspc desktop -f '^{1-9}'";
      "super + shift + {1-9}" = "bspc node -d '^{1-9}'";
    };
  };

  services.dunst = {
    enable = true;

  };

  services.gpg-agent.enable = true;

  #services.screen-locker = {
  #  enable = true;
  #  xautolock = {
  #    enable = false;
  #  };
  #  xsslock
  #};
  services.gnome-keyring = {
    enable = true;
  };

}
