{ pkgs, ... }:

{
  programs.bat = {
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
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };
}
