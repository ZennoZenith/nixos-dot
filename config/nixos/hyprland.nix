{pkgs, ...}: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprlock
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprsunset
    rose-pine-hyprcursor
    banana-cursor

    libnotify ## send alerts
    xdg-desktop-portal-gtk
  ];

  ## required for screen sharing
  services.pipewire.enable = true;
  services.pipewire.wireplumber.enable = true;

  environment.sessionVariables = {
    # # Qt6 environment for quickshell
    # QT_QPA_PLATFORM = "wayland;xcb";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    T_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
