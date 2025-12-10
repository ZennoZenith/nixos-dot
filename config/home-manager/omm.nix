{
  config,
  lib,
  ...
}: let
  name = "omm";
in {
  options = {
    custom.${name} = {
      enable = lib.mkEnableOption {
        description = "Enable omm";
        default = false;
      };
    };
  };

  config = lib.mkIf config.custom.${name}.enable {
    xdg.configFile."${name}/omm.toml".text = ''
      db_path      = "~/shared/omm/omm.db"
      tl_color     = "#b8bb26"
      atl_color    = "#fabd2f"
      title        = "home"
      list_density = "spacious"
      show_context = true
      editor       = "hx"
    '';
  };
}
