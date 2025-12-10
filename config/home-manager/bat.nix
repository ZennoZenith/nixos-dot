{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "bat";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable bat";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = with pkgs; [
      bat
      bat-extras.batdiff
      bat-extras.batgrep
      bat-extras.batman
      bat-extras.batpipe
      bat-extras.batwatch
      bat-extras.prettybat
    ];

    programs.bat = {
      enable = true;
      config = {
        map-syntax = [
          ".ignore:Git Ignore"
          "/etc/apache2/**/*.conf:Apache Conf"
          "*.conf:INI"
          "*.jenkinsfile:Groovy"
          "*.props:Java Properties"
        ];
        pager = "less -FRX";
        theme = "Monokai Extended";
        theme-dark = "Monokai Extended";
        theme-light = "Monokai Extended Dark";
        italic-text = "always";
      };
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
  };
}
