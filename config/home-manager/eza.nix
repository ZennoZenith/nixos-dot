{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "eza";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable eza";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.eza
    ];

    programs.eza = {
      enable = true;
      icons = "always";
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--no-quotes"
        "--header" # Show header row
        "--git-ignore"
        "--classify" # append indicator (/, *, =, @, |)
        "--hyperlink" # make paths clickable in some terminals
      ];
    };
  };
}
