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

  # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"
  services.logind.settings.Login.HandleLidSwitchDocked = "hybrid-sleep";

  boot.loader.timeout = 20;

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
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

  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "knacknix"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [
        "hsp_hs"
        "hsp_ag"
        "hfp_hf"
        "hfp_ag"
      ];
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.getty.autologinUser = "knack";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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

  programs.firefox.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages
  ];

  environment.variables.EDITOR = "hx";
  environment.systemPackages = with pkgs;
    [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
    ]
    ++ programs;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      # PasswordAuthentication = false;
      # KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [
        "knack"
        "zenith"
      ];
    };
  };
  services.fail2ban.enable = true;

  networking.firewall.allowedTCPPorts = [
    22
    80
    443
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  networking.extraHosts = ''
    100.75.63.27 knacknix
    100.75.63.27 knack
    100.116.135.61 linode
    100.76.194.92 zenith
  '';

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.autoUpgrade = {
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

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  system.stateVersion = "25.05";
}
