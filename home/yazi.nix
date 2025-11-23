{
  pkgs,
  lib,
  ...
}: let
  targetDir = ".config/yazi/flavors";
  sourceDir = ../configs/yazi/flavors;

  yaziFlavors = {
    "catppuccin-mocha.yazi" = sourceDir + "/catppuccin-mocha.yazi";
    "gruvbox-dark.yazi" = sourceDir + "/gruvbox-dark.yazi";
    "nord.yazi" = sourceDir + "/nord.yazi";
  };
in {
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
    extraPackages = with pkgs; [
      glow
      ouch
    ];

    keymap = {
      input.prepend_keymap = [
        {
          on = ["<Esc>"];
          run = "close";
          desc = "Cancel input";
        }
      ];
    };

    shellWrapperName = "yy";

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
        sort_reverse = true;
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
}
