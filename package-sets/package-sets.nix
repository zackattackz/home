{pkgs, ...}:

{
  system = (import ./system.nix  { inherit pkgs; });
  games = (import ./games.nix  { inherit pkgs; });
}
