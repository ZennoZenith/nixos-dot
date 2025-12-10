{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
  };

  environment.systemPackages = with pkgs; [
    hyprlock
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprsunset
    rose-pine-hyprcursor

    libnotify ## send alerts
    xdg-desktop-portal-gtk
  ];

  ## If cursor is not visible, try to set this to "on".
  environment.variables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  environment.sessionVariables = {
    # Qt6 environment for quickshell
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    T_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  ## Using hyprland cachix cache for building
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
