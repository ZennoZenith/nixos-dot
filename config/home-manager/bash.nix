{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "bash";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable bash";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.bash
    ];

    programs.bash = {
      enable = true;
      shellAliases = {
        btw = "echo i use nixos, btw";
      };
      # profileExtra = ''
      #   if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      #     exec Hyperland
      #   fi
      # '';
    };
  };
}
