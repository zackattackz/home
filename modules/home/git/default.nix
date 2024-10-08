{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.git;
in
{
  options.git.enable = mkEnableOption "git options";
  config = mkIf cfg.enable {
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
        ac = "commit --amend --no-edit";
        rf = "reflog";
        l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
        pp = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
        recent-branches = "branch --sort=-committerdate";
      };
    };
  };
}
