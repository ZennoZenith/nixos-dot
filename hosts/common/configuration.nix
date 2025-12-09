{
  pkgs,
  inputs,
  config,
  variables,
  ...
}: {
  imports = [
    ../../config/packages.nix
    ../../config/fonts.nix
    ../../config/misc.nix
    ../../config/display-manager.nix
    ../../config/flatpak.nix
    ../../config/kanata.nix
    ../../config/hyprland.nix
    ../../config/ssh.nix
    ../../config/steam.nix
    ../../config/tailscale.nix
    ../../config/mpd.nix
    ../../config/pueue.nix
    ../../config/sound.nix
  ];
  nixpkgs.config.allowUnfree = true;

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

    stateVersion = variables.home.stateVersion;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;

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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  networking = {
    # hostName = "..."; ## Define your hostname.
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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  programs = {
    dconf.enable = true;

    ## Gui for OpenPGP
    seahorse.enable = true;
    localsend.enable = true;
    localsend.openFirewall = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    nix-ld.enable = true;
    nix-ld.libraries = [
      # Add any missing dynamic libraries for unpackaged
      # programs here, NOT in environment.systemPackages
    ];
  };

  environment = {
    pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];

    variables = {
      EDITOR = "${pkgs.helix}/bin/hx";
    };

    ## [Fix for dolphin default file association](https://discuss.kde.org/t/dolphin-file-associations/38934/2)
    etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    sessionVariables = {
      XDG_DATA_DIRS = [
        "${config.system.path}/share"
        "${pkgs.kdePackages.dolphin}/share"
      ];
    };
  };

  custom = {
    syncthing = {
      enable = true;
      user = "knack";
    };
  };
}
