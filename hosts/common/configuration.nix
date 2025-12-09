#
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

    # ../../config/regreet.nix
    ../../config/kanata.nix
    ../../config/nvidia.nix
  ];
  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

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

  programs = {
    dconf.enable = true;

    ## Gui for OpenPGP
    seahorse.enable = true;
    localsend.enable = true;
    localsend.openFirewall = true;

    ## Note: You can't use ssh-agent and GnuPG agent with SSH support enabled at the same time!
    ssh = {
      startAgent = true;
      enableAskPassword = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    };

    bash.loginShellInit = ''
      if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
        exec nu
      fi
    '';

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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  systemd.services.flatpak-add-flathub = {
    description = "Add Flathub Flatpak remote";
    wantedBy = ["multi-user.target"];
    wants = ["network-online.target"];
    after = ["network-online.target" "flatpak-system-helper.service"];
    serviceConfig = {
      Type = "oneshot";
    };
    script = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  environment = {
    pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];

    variables = {
      EDITOR = "hx";
      SSH_ASKPASS_REQUIRE = "prefer";

      # If cursor is not visible, try to set this to "on".
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };

    ## [Fix for dolphin default file association](https://discuss.kde.org/t/dolphin-file-associations/38934/2)
    etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    sessionVariables = {
      # Qt6 environment for quickshell
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      T_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";

      XDG_DATA_DIRS = [
        "${config.system.path}/share"
        "${pkgs.kdePackages.dolphin}/share"
      ];
    };
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

    stateVersion = variables.home.stateVersion;
  };
}
