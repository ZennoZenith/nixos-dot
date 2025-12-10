{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "zoxide";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable zoxide";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.zoxide
    ];

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
