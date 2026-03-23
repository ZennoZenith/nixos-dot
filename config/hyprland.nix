{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    # xwayland.enable = true;
  };

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

  ## Using hyprland cachix cache for building
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
      "https://unmojang.cachix.org"
      "https://prismlauncher.cachix.org"

      "https://cache.nixos.asia/oss"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "unmojang.cachix.org-1:OfHnbBNduZ6Smx9oNbLFbYyvOWSoxb2uPcnXPj4EDQY="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="

      "oss:KO872wNJkCDgmGN3xy9dT89WAhvv13EiKncTtHDItVU="
    ];
  };
}
