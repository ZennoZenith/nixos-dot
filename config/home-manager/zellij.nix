{
  config,
  lib,
  variables,
  pkgs,
  ...
}: let
  name = "zellij";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable zellij";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.zellij
    ];

    programs.zellij.enableBashIntegration = true;
    programs.zellij.enableFishIntegration = true;
    programs.zellij.enableZshIntegration = true;

    xdg.configFile."${name}" = {
      source = config.lib.file.mkOutOfStoreSymlink "${variables.dotfiles}/${name}";
      recursive = true;
    };
  };
}
