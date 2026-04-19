{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./remote-builder.nix
    ./nvidia-drivers.nix

    ../../config/nixos/nix.nix
    ../../config/nixos/packages.nix
    ../../config/nixos/fonts.nix
    ../../config/nixos/programs.nix
    ../../config/nixos/networking.nix
    ../../config/nixos/system.nix
    ../../config/nixos/environment.nix
    ../../config/nixos/services.nix
    ../../config/nixos/systemd.nix

    ../../config/nixos/flatpak.nix
    ../../config/nixos/kanata.nix
    ../../config/nixos/display-manager.nix
    ../../config/nixos/bluetooth.nix
    ../../config/nixos/rust.nix
    ../../config/nixos/syncthing.nix
    ../../config/nixos/docker.nix
    ../../config/nixos/jellyfin.nix
    ../../config/nixos/virtual.nix
    # ../../config/nixos/nginx.nix

    ../../config/nixos/hyprland.nix
  ];

  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Kolkata";

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  users.users = {
    zenith = {
      shell = pkgs.nushell;
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINxeHhhBmXYP1Be4m+snZlVHieXAHBaOUv3a83QpSbG4 (none)"

        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvR+icsS7ocB1mlZIXKLMh41RjHSTJKcVwV9bmJxlfI zenith-arch:knack-arch"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENWlT75aCPretBcIhW2Wg7yggAkzKhmRbqJqcXmpyhf linode-ubuntu-1:knack-arch"
      ];

      packages = with pkgs; [
        nix-search-tv
      ];
    };

    hadish = {
      isNormalUser = true;
      # extraGroups = ["docker"]; ## TEMP:
      extraGroups = [];
      openssh.authorizedKeys.keys = [];

      hashedPassword = "$y$j9T$ew/v8gDWhQgGKUrT.HZ/81$D9VjEg3r8kLPqeKgUwxpZt1ParFl28Z2Wup4G2rQSW2";

      packages = with pkgs; [
        nix-search-tv
      ];
    };
  };
}
