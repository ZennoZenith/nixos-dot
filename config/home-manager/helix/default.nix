{
  pkgs,
  variables,
  ...
}: let
  pk = with pkgs; [
    nixd
    dprint
    ruff
    marksman
    markdown-oxide
    tailwindcss-language-server
  ];

  setting = import ./config.nix;
  language = import ./language.nix;
in {
  home.packages = pk;

  home.file.".config/helix/runtime/queries/kbd/highlights.scm".text = "; inherits: scheme \n";
  home.file.".config/helix/runtime/queries/kbd/indents.scm".text = "; inherits: scheme \n";
  home.file.".config/helix/runtime/queries/kbd/injections.scm".text = "; inherits: scheme \n";

  programs.helix = {
    enable = true;
    extraPackages = pk;
    defaultEditor = true;

    themes = {
      catppuccin_mocha_transparent = {
        inherits = "catppuccin_mocha";
        "ui.background" = {};
      };
      gruvbox_transparent = {
        inherits = "gruvbox";
        "ui.background" = {};
      };
      snazzy_transparent = {
        inherits = "snazzy";
        "ui.background" = {};
      };
      sonokai_transparent = {
        inherits = "sonokai";
        "ui.background" = {};
      };
      tokyonight_transparent = {
        inherits = "tokyonight";
        "ui.background" = {};
      };
      rose_theme_transparent = {
        inherits = "rose_pine";
        "ui.background" = {};
      };
    };

    settings = setting;

    languages = language {
      inherit pkgs;
      inherit variables;
    };
  };
}
