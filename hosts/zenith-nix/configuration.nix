# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
#
{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko.nix
    ./services.nix

    ../common/configuration.nix
  ];

  fileSystems."/mnt/whole" = {
    device = "/dev/disk/by-uuid/bc034754-5770-44e4-b606-2566262c567a";
    fsType = "btrfs";
    options = ["compress=zstd" "nofail" "noatime"];
  };

  fileSystems."/mnt/old-drive" = {
    device = "/dev/disk/by-uuid/ec062600-5190-4e73-b431-0edcbdaffea1";
    fsType = "btrfs";
    options = ["compress=zstd" "nofail" "noatime"];
  };

  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "zenithnix"; # Define your hostname.

  users.users.zenith = {
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

  users.users.hadish = {
    isNormalUser = true;
    extraGroups = []; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [];

    hashedPassword = "$y$j9T$ew/v8gDWhQgGKUrT.HZ/81$D9VjEg3r8kLPqeKgUwxpZt1ParFl28Z2Wup4G2rQSW2";

    packages = with pkgs; [
      nix-search-tv
    ];
  };

  programs.firefox.preferences = let
    ffVersion = config.programs.firefox.package.version;
  in {
    "media.ffmpeg.vaapi.enabled" = lib.versionOlder ffVersion "137.0.0";
    "media.hardware-video-decoding.force-enabled" = lib.versionAtLeast ffVersion "137.0.0";
    "media.rdd-ffmpeg.enabled" = lib.versionOlder ffVersion "97.0.0";

    "gfx.x11-egl.force-enabled" = true;
    "widget.dmabuf.force-enabled" = true;

    # Set this to true if your GPU supports AV1.
    #
    # This can be determined by reading the output of the
    # `vainfo` command, after the driver is enabled with
    # the environment variable.
    "media.av1.enabled" = false;
  };
}
