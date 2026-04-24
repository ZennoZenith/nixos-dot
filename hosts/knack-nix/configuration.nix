{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./knack-nvidia-driver.nix
    ./distributed-builds.nix

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
    # ../../config/nixos/docker.nix
    # ../../config/nixos/jellyfin.nix
    # ../../config/nixos/virtual.nix
    # ../../config/nixos/nginx.nix

    ../../config/nixos/hyprland.nix
  ];

  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Kolkata";

  documentation.man.generateCaches = false;
  systemd.services.mandb.enable = false;

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  users.users.knack = {
    shell = pkgs.nushell;
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4JTN/B71Y8mTA2F4CjVXtVYJvfCWkyaxz0QAOMOeAB (none)"

      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvR+icsS7ocB1mlZIXKLMh41RjHSTJKcVwV9bmJxlfI zenith-arch:knack-arch"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENWlT75aCPretBcIhW2Wg7yggAkzKhmRbqJqcXmpyhf linode-ubuntu-1:knack-arch"
    ];

    packages = with pkgs; [
      nix-search-tv
    ];
  };
}
