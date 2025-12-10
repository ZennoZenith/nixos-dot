{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "keychain";
  inherit (lib) mkIf mkOption types;
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable keychain";
        default = false;
      };

      keys = mkOption {
        type = types.listOf types.str;
        default = [];
        description = ''
          Keys to add to keychain.
        '';
      };
    };
  };

  config = mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.keychain
    ];

    programs.keychain = {
      enable = true;

      keys = config.custom.${name}.keys;

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
