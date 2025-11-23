{ pkgs, ... }:
let
  ns = pkgs.writeShellScriptBin "ns" (builtins.readFile ./ns-nixpkgs.sh);
in
{
  home.packages = [
    ns
  ];

  programs.nix-search-tv.enableTelevisionIntegration = true;
}
