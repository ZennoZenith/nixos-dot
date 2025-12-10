{
  config,
  variables,
  lib,
  pkgs,
  ...
}: let
  name = "nushell";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable nushell";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.nushell
      pkgs.nushellPlugins.desktop_notifications
      pkgs.nushellPlugins.formats
      pkgs.nushellPlugins.gstat
      pkgs.nushellPlugins.highlight
      pkgs.nushellPlugins.query
      pkgs.nushellPlugins.skim
      # pkgs.nushellPlugins.units
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
