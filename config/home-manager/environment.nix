{
  pkgs,
  variables,
  ...
}: let
  tomlFormat = pkgs.formats.toml {};
  myPathList = [
    "${variables.home.homeDirectory}/.local/bin"
    "${variables.home.homeDirectory}/.cargo/bin"
    "${variables.home.homeDirectory}/.cargo/bin"
    "${variables.home.homeDirectory}/.bin"
    "${variables.home.homeDirectory}/.bin/hypremoji/target/release"
  ];
in {
  home.file.".env_vars.toml".source = tomlFormat.generate ".env_vars.toml" {
    inherit myPathList;
    FOO = "BAR";
    EDITOR = "${pkgs.helix}/bin/hx";
    PAGER = "${pkgs.helix}/bin/delta";

    ## Zoxide
    _ZO_DATA_DIR = "${variables.home.homeDirectory}/.local/share/zoxide";
    # _ZO_ECHO = 1;
    # _ZO_EXCLUDE_DIRS
    # _ZO_FZF_OPTS
    # _ZO_MAXAGE

    STARSHIP_CONFIG = "${variables.home.homeDirectory}/.config/starship/starship.toml";

    BAT_THEME = "Monokai Extended";
    MANPAGER = "sh -c 'sed -u -e \"s/\\x1B\\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'";
    AWWW_TRANSITION_FPS = 255;
    AWWW_TRANSITION_DURATION = 1.5;
  };
}
