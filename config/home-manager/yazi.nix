{
  config,
  lib,
  pkgs,
  ...
}: let
  name = "yazi";
  targetDir = ".config/yazi/flavors";
  sourceDir = ../../symlinks/yazi/flavors;

  yaziFlavors = {
    "catppuccin-mocha.yazi" = sourceDir + "/catppuccin-mocha.yazi";
    "gruvbox-dark.yazi" = sourceDir + "/gruvbox-dark.yazi";
    "nord.yazi" = sourceDir + "/nord.yazi";
  };
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable yazi";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    home.packages = [
      pkgs.yazi
      pkgs.glow
      pkgs.ouch
    ];

    home.file =
      lib.mapAttrs (fileName: sourcePath: {
        target = "${targetDir}/${fileName}";
        source = sourcePath;
      })
      yaziFlavors;

    programs.yazi = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;

      plugins = {
        lazygit = pkgs.yaziPlugins.lazygit;
        full-border = pkgs.yaziPlugins.full-border;
        git = pkgs.yaziPlugins.git;
        smart-enter = pkgs.yaziPlugins.smart-enter;
      };

      initLua = ''
        require("full-border"):setup()
           require("git"):setup()
           require("smart-enter"):setup {
             open_multi = true,
           }
      '';

      keymap = {
        input.prepend_keymap = [
          {
            on = ["<Esc>"];
            run = "close";
            desc = "Cancel input";
          }
        ];
      };

      shellWrapperName = "y";

      settings = {
        log = {
          enabled = false;
        };
        mgr = {
          ratio = [
            2
            4
            5
          ];
          sort_by = "natural";
          show_hidden = true;
          sort_dir_first = true;
          sort_reverse = false;
        };
      };

      theme = {
        flavor = {
          # dark = "nord";
          # dark = "gruvbox-dark";
          dark = "catppuccin-mocha";
          light = "catppuccin-mocha";
        };
      };
    };
  };
}
