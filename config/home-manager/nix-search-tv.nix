{
  config,
  lib,
  pkgs,
  ...
}: let
  ns = pkgs.writeShellScriptBin "ns" (builtins.readFile ./ns-nixpkgs.sh);
  name = "nix-search-tv";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable nix-search-tv";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      ns
    ];

    programs.nix-search-tv.enableTelevisionIntegration = true;
  };
}
