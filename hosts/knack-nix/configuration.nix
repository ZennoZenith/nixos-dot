#
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./services.nix

    ../common/configuration.nix
  ];

  boot.loader.timeout = 5;

  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "knacknix"; # Define your hostname.

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
