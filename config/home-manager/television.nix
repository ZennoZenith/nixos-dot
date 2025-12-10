{
  config,
  variables,
  lib,
  pkgs,
  ...
}: let
  name = "television";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable television";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.television
    ];

    programs.television = {
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    xdg.configFile.${name} = {
      source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfiles}/${name}/";
      recursive = true;
    };
  };
}
