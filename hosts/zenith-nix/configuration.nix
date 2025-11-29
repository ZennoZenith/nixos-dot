# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
#
{
  pkgs,
  inputs,
  config,
  ...
}: let
  programs = import ../../modules/nixos/pkgs.nix {inherit pkgs;};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./services.nix
    ./disko.nix
    ../../modules/nixos/regreet.nix
    ../../modules/nixos/kanata.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/fonts.nix

    # inputs.hyprland.nixosModules.default
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

  boot = {
    loader = {
      timeout = 5;
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
    hostName = "zenithnix"; # Define your hostname.
    networkmanager.enable = true;
    extraHosts = ''
      100.116.135.61  linode
      100.71.238.4    zenith
      100.75.63.27    knack
    '';

    # firewall.allowedUDPPorts = [ ... ];
    # firewall.enable = false;
    firewall = rec {
      allowedTCPPorts = [
        22
        80
        443
      ];

      ## For kde connect
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  time.timeZone = "Asia/Kolkata";
  security.rtkit.enable = true;

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

  programs = {
    dconf.enable = true;
    ## Gui for OpenPGP
    seahorse.enable = true;
    localsend.enable = true;
    localsend.openFirewall = true;

    # gnupg.agent = {
    #   enable = true;
    #   # enableSSHSupport = true;
    # };
    ## Note: You can't use ssh-agent and GnuPG agent with SSH support enabled at the same time!
    ssh = {
      startAgent = true;
      enableAskPassword = true;
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged
      # programs here, NOT in environment.systemPackages
    ];
  };
  environment = {
    pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];

    variables = {
      EDITOR = "hx";
      SSH_ASKPASS_REQUIRE = "prefer";
    };

    ## [Fix for dolphin default file association](https://discuss.kde.org/t/dolphin-file-associations/38934/2)
    etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    sessionVariables.XDG_DATA_DIRS = [
      "${config.system.path}/share"
      "${pkgs.kdePackages.dolphin}/share"
    ];
    systemPackages = with pkgs;
      [
        vim
        wget
      ]
      ++ programs;
  };

  ## Using hyprland cachix cache for building
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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
