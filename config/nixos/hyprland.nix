{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  ## https://wiki.hypr.land/Nix/Hyprland-on-NixOS/#fixing-problems-with-themes
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita";
        icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Noto Sans Medium 11";
        document-font-name = "Noto Sans Medium 11";
        monospace-font-name = "Noto Sans Mono Medium 11";
      };
    }
  ];

  environment.systemPackages = with pkgs; [
    hyprlock
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprsunset
    rose-pine-hyprcursor
    banana-cursor

    libnotify ## send alerts
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
