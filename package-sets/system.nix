{pkgs, ...}:

with pkgs;

[
  libnotify
  betterlockscreen
  discord
  vscode
  scrot
  gnome.seahorse
  gnumake
  xclip
  xdotool
  jq
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  siji
  ponymix
  (nerdfonts.override { fonts = [
    "FiraCode"
    "Iosevka"
    "Hack"
    "FantasqueSansMono"
    "ProggyClean"
  ]; })
]
