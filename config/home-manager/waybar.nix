{
  config,
  lib,
  variables,
  pkgs,
  ...
}: let
  name = "waybar";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable waybar";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.waybar
    ];

    xdg.configFile."${name}" = {
      source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfiles}/${name}";
      recursive = true;
    };
  };
}
