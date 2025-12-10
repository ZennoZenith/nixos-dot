{
  config,
  variables,
  lib,
  pkgs,
  ...
}: let
  name = "starship";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable starship";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.starship
    ];

    programs.starship = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    xdg.configFile.${name} = {
      source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfiles}/${name}/";
      recursive = true;
    };
  };
}
