{
  lib,
  config,
  pkgs,
  ...
}: let
  name = "jujutsu";
in {
  options.custom.${name} = {
    enable = lib.mkEnableOption {
      description = "Enable Syncthing";
      default = false;
    };

    name = lib.mkOption {
      type = lib.types.nonEmptyStr;
      default = "";
      description = "Git username";
    };

    email = lib.mkOption {
      type = lib.types.nonEmptyStr;
      default = "";
      description = "Git email";
    };

    gpgKey = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Gnupg signing key";
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.jujutsu
    ];

    programs.${name} = {
      enable = true;

      settings = {
        user = {
          name = config.custom.${name}.name;
          email = config.custom.${name}.email;
        };
        git = {
          sign-on-push = true;
          subprocess = true;
        };
        signing = {
          behavior = "own";
          backend = "gpg";
          key = config.custom.${name}.gpgKey;
        };
        ui = {
          default-command = [
            "log"
            "--limit"
            "6"
          ];
          pager = [
            "delta"
            "-s"
            "--dark"
          ];
          diff-formatter = ":git";
          diff-editor = ":builtin";
        };
        colors = {
          "diff removed token" = {
            fg = "bright red";
            bg = "#400000";
            underline = false;
          };
          "diff added token" = {
            fg = "bright green";
            bg = "#003000";
            underline = false;
          };
        };
        aliases = {
          l = [
            "log"
            "-r"
            "ancestors(reachable(@; mutable()); 2)"
          ];
          "n" = [
            "new"
          ];
        };
      };
    };
  };
}
