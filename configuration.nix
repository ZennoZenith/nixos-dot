# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
#
{
  pkgs,
  inputs,
  ...
}: let
  programs = import ./pkgs/pkgs.nix {inherit pkgs;};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko-config.nix
    ./modules/regreet.nix
    ./modules/services.nix
    ./modules/kanata.nix
    ./modules/nvidia.nix
    ./modules/fonts.nix
  ];

  boot = {
    loader = {
      timeout = 20;
      efi.canTouchEfiVariables = true;
      # Use the GRUB 2 boot loader.
      grub = {
        enable = true;
        efiSupport = true;
        # efiInstallAsRemovable = true;

        # Define on which hard drive you want to install Grub.
        # no need to set devices, disko will add all device...
        # device = "/dev/sda"; # or "nodev" for efi only
        device = "nodev";

        minegrub-theme = {
          enable = true;
          splash = "100% Flakes!";
          background = "background_options/1.16 - [Nether Update].png";
          boot-options-count = 7;
        };
      };
    };
  };

  networking = {
    hostName = "knacknix"; # Define your hostname.
    networkmanager.enable = true;
    extraHosts = ''
      100.75.63.27 knacknix
      100.75.63.27 knack
      100.116.135.61 linode
      100.76.194.92 zenith
    '';

    # firewall.allowedUDPPorts = [ ... ];
    # firewall.enable = false;
    firewall.allowedTCPPorts = [
      22
      80
      443
    ];
  };

  time.timeZone = "Asia/Kolkata";
  security.rtkit.enable = true;

  users.users.knack = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvR+icsS7ocB1mlZIXKLMh41RjHSTJKcVwV9bmJxlfI zenith-arch:knack-arch"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENWlT75aCPretBcIhW2Wg7yggAkzKhmRbqJqcXmpyhf linode-ubuntu-1:knack-arch"
    ];

    packages = with pkgs; [
      nix-search-tv
    ];
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    firefox.enable = true;

    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged
      # programs here, NOT in environment.systemPackages
    ];
  };

  environment = {
    variables.EDITOR = "hx";
    systemPackages = with pkgs;
      [
        vim
        wget
      ]
      ++ programs;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  system = {
    autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-all"
        "nixpkgs"
        "-L" # print build logs
      ];
      dates = "07:00";
      randomizedDelaySec = "59min";
    };

    stateVersion = "25.05";
  };
}
