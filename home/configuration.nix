{ config, lib, pkgs, cfg, ... }:
let
tmuxTerminal = "tmux-256color";
homeDirectory = "/home/${cfg.home.username}";
picturesPath =  "${homeDirectory}/pictures";
wallpaper = "aurora1.png";
wallpaperPath = "${picturesPath}/wallpapers/${wallpaper}";
fontFamily = "Iosevka NFM";
cursorName = "Nordzy-cursors";
in
{
  imports = [
    ./modules/themes
  ];

  nix.package = pkgs.nix;

  nix.settings = {
    extra-experimental-features = ["flakes" "nix-command"];
  };

  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home.username = cfg.home.username;
  home.homeDirectory = homeDirectory;

  home.stateVersion = "23.05";
  home.packages = (cfg.home.getPackages pkgs);

  home.file =
  let
  wallpaperRepoPath = ./files/wallpapers/${wallpaper};
  in
  {
    ".local/bin/alacritty-keep-cwd".source = ./files/alacritty-keep-cwd;
    ".local/bin/bspc-node-focus".source = ./files/bspc-node-focus;
    ".local/bin/bspc-node-swap".source = ./files/bspc-node-swap;
    ".local/bin/bspc-close-all-quit".source = ./files/bspc-close-all-quit;
    ".local/bin/bspc-northsouth-focus".source = ./files/bspc-northsouth-focus;
    ".local/bin/rofi-pulse-select".source = ./files/rofi-pulse-select;
    ".local/bin/external_rules_command".source = ./files/external_rules_command;
    ".local/bin/sss".source = ./files/sss;
    ".local/bin/screenshot".source = ./files/screenshot;
    "${wallpaperPath}".source = wallpaperRepoPath;
    ".cache/betterlockscreen/current/lock_dim.png".source = wallpaperRepoPath;
    ".cache/betterlockscreen/1-DP-0/dim.png".source = wallpaperRepoPath;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  xdg.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = null;
    documents = "${homeDirectory}/documents";
    download = "${homeDirectory}/downloads";
    music = "${homeDirectory}/music";
    pictures = picturesPath;
    publicShare = null;
    templates = null;
    videos = "${homeDirectory}/videos";
    extraConfig = {
      "XDG_SCREENSHOTS_DIR" = "${picturesPath}/screenshots";
    };
  };

  home.pointerCursor = {
    package = pkgs.nordzy-cursor-theme;
    name = cursorName;
    size = 16;
    x11.enable = true;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    cursorTheme = {
       name = cursorName;
       size = 16;
    };
  };

  fonts.fontconfig.enable = true;

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
    extraConfig = ''
      set autoindent expandtab tabstop=2 shiftwidth=2
    '';
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
      #[[ -z "$TMUX" && $TERM != "${tmuxTerminal}" && $TERM != linux  && "$TERM_PROGRAM" != "vscode" ]] && exec tmux
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

  programs.rofi = {
    enable = true;
    font = "${fontFamily} 13";
    extraConfig = {
      kb-row-up = "Up,Control+k,ISO_Left_Tab";
      kb-row-down = "Down,Control+j,Tab";
      kb-accept-entry = "Control+p,Return,KP_Enter";
      kb-remove-to-eol = "";
      kb-element-next = "";
      kb-element-prev = "";
    };
  };

  programs.firefox = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.83;
      font = {
        normal = {
          family = fontFamily;
          style = "Regular";
        };
        bold = {
          family = fontFamily;
          style = "Bold";
        };
        italic = {
          family = fontFamily;
          style = "Italic";
        };
        bold_italic = {
          family = fontFamily;
          style = "Bold Italic";
        };
        size = 13.0 ;
      };
    };
  };

  xsession ={
    enable = true;
    windowManager.bspwm = {
      enable = true;
      monitors = {
        "DP-0" = [ "web" "code" "term" "media" "games" ];
        "HDMI-0" = [ "games2" ];
      };
      settings = {
        border_width = 3;
        external_rules_command = "${homeDirectory}/.local/bin/external_rules_command";
      };
      extraConfig = ''
      feh --no-fehbg --bg-center ${wallpaperPath}
      '';
    };
  };

  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "alacritty-keep-cwd";
      "super + w" = "firefox";
      "super + space" = "rofi -show drun";
      "super + {_,shift + } q" = "bspc node -{c,k}";
      "super + {1-9}" = "bspc desktop -f '^{1-9}'";
      "super + shift + {1-9}" = "bspc node -d '^{1-9}' --follow";
      "super + {j,k}" = "bspc-northsouth-focus {south,north}";
      "super + {h,l}" = "bspc-node-focus {west,east}";
      "super + button{4,5}" = "bspc desktop -f {next,prev}";
      "super + shift + {j,k}" = "bspc node -s {south,north}";
      "super + shift + {h,l}" = "bspc-node-swap {west,east}";
      "super + shift + control + q" = "bspc-close-all-quit";
      "super + t" = "bspc desktop -l next";
      "super + shift + t" = "bspc node -t ~fullscreen";
      "super + bracketright" = "[[ $(systemctl --user is-active picom) == \"active\" ]] && systemctl --user stop picom || systemctl --user start picom";
      "{_,shift +} Print" = "screenshot {yes,no} ${picturesPath}/screenshots";
      "XF86AudioLowerVolume" = "ponymix decrease 5";
      "XF86AudioRaiseVolume" = "ponymix increase 5";
      "XF86AudioMute" = "ponymix toggle";
      "super + backslash" = "rofi-pulse-select sink";
      "super + shift backslash" = "rofi-pulse-select source";
    };
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        #transparency = 50;
        frame_width = 2;
        separator_height = 2;
        separator_color = "frame";
        font = "${fontFamily} 11";
      };
    };
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      pulseSupport = true;
    };
    settings = {
      "bar/main" = {
        monitor = "DP-0";
        width = "100%";
        height = 27;
        line-size = 3;
        padding-left = 2;
        padding-right = 2;
        module-margin-left = 1;
        module-margin-right = 2;
        font-0 = "${fontFamily}:pixelsize=10";
        font-1 = "Siji:pixelsize=10";
        modules-left = "bspwm";
        modules-right = "pulseaudio wireless-network wired-network date";
        tray-position = "right";
        tray-padding = 2;
        wm-restack = "bspwm";
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
      };
      "module/bspwm" = {
        type = "internal/bspwm";
        ws-icon-0 = "web;";
        ws-icon-1 = "code;";
        ws-icon-2 = "term;";
        ws-icon-3 = "media;";
        ws-icon-4 = "games;";
        label-focused = "%icon%";
        label-occupied = "%icon%";
        label-urgent = "%icon%";
        label-empty = "%icon%";
        label-separator = "|";
        label-separator-padding = 2;
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        label-volume = "%percentage%%";
        format-volume = "<ramp-volume> <label-volume>";
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        label-muted = "";
      };
      "module/wireless-network" = {
        type = "internal/network";
        interface = "wlp2s0";
        interval = 3.0;
        format-connected = "<ramp-signal> <label-connected>";
        label-connected = "%essid%  %downspeed%  %upspeed%";
        format-disconnected = "";
        ramp-signal-0 = "";
        ramp-signal-1 = "";
        ramp-signal-2 = "";
        ramp-signal-3 = "";
        ramp-signal-4 = "";
      };
      "module/wired-network" = {
        type = "internal/network";
        interface = "enp3s0";
        interval = 3.0;
        format-connected-prefix = " ";
        label-connected = " %downspeed%  %upspeed%";
        format-disconnected = "";
      };
      "module/date" = {
        type = "internal/date";
        interval = 5;
        date = "";
        date-alt = " %Y-%m-%d";
        time = "%I:%M %p";
        time-alt = "%X";
        format-prefix = "";
        label = "%date% %time%";
      };
    };
    script = ''
    # wait until bspwm starts
    (
    until [[ -e /tmp/bspwm_0_0-socket ]]; do
      ${pkgs.coreutils-full}/bin/sleep 0.1
    done
    polybar main
    ) &
    '';
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

  services.xidlehook = {
    enable = true;
    not-when-fullscreen = true;
    not-when-audio = true;
    timers =
    let
    minutes = 8;
    warningSeconds = 15;
    in
    [
      {
        # warn about screen lock
        delay = minutes * 60;
        command = "${pkgs.dunst}/bin/dunstify -p -u low -t ${toString ((warningSeconds - 1) * 1000)} 'Screen lock in ${toString warningSeconds} seconds' >> /tmp/lock_warning_notif_ids";
        canceller = "while IFS= read -r id; do ${pkgs.dunst}/bin/dunstify -C \"$id\"; done < /tmp/lock_warning_notif_ids; ${pkgs.coreutils-full}/bin/rm /tmp/lock_warning_notif_ids";
      }
      {
        # lock screen
        delay = warningSeconds;
	      command = "${pkgs.betterlockscreen}/bin/betterlockscreen --time-format '%I:%M %p' -l dim --off 10";
      }
    ];
  };

  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 6;
    fadeSteps = [ 3.0e-2 1.0 ];
    fadeExclude = [
      "window_type *= 'menu'"
    ];
    shadow = true;
    shadowOffsets = [ (-7) (-7) ];
    shadowOpacity = 0.75;
    activeOpacity = 1;
    inactiveOpacity = 0.81;
    opacityRules = [
      "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      "100:class_g = 'firefox' && argb"
      "100:class_g = 'discord'"
      "100:class_g = 'Alacritty'"
      "100:class_g = 'steam'"
    ];
    vSync = true;
    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        opacity = 0.75;
        focus = true;
        full-shadow = false;
      };
      dock = {
        shadow = false;
      };
      utility = {
        shadow = false;
        opacity = 1;
      };
      dnd = {
        shadow = false;
      };
      popup_menu = {
        opacity = 1;
        shadow = false;
      };
      dropdown_menu = {
        opacity = 1;
        shadow = false;
      };
    };
    settings = {
      shadow-radius = 7;
      blur-kern = "3x3box";
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      use-damage = true;
      xrender-sync-fence = true;
    };
  };

  misc = cfg.misc;
}
