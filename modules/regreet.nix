{
  config,
  pkgs,
  ...
}: let
  hyprland-conf = pkgs.writeText "hyprland-gtkgreet-config" ''
    exec-once = regreet; hyprctl dispatch exit
    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_hyprland_guiutils_check = true
    }
  '';
in {
  programs.regreet = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.hyprland.package}/bin/Hyprland --config ${hyprland-conf}";
        user = "greeter";
      };

      # background = {
      #   path = "";
      #   fit = "Cover"; # # Contain | Fill | Cover | ScaleDown
      # };

      # env = {
      #   ENV_VARIABLE = "value";
      # };
      gtk = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Adwaita";
        cursor_blink = true;
        font_name = "Cantarell 16";
        icon_theme_name = "Adwaita";
        theme_name = "Adwaita";
      };
    };
  };
}
