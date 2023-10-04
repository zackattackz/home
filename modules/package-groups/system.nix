pkgs:

with pkgs;

[
  # applications
  betterlockscreen
  btop
  discord
  gnome.seahorse
  gnumake
  jq
  libnotify
  ponymix
  scrot
  tldr
  vscode
  xclip
  xdotool

  # fonts
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  siji
  (nerdfonts.override { fonts = [
    "FiraCode"
    "Iosevka"
    "Hack"
    "FantasqueSansMono"
    "ProggyClean"
  ]; })
]
