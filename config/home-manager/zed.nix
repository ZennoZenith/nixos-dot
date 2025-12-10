{
  config,
  variables,
  lib,
  pkgs,
  ...
}: let
  name = "zed";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable Zed";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.zed-editor
    ];
    xdg.configFile.${name} = {
      source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfiles}/${name}/";
      recursive = true;
    };
  };
}
