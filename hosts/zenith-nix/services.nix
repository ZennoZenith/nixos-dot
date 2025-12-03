{pkgs, ...}: {
  imports = [
    ../../modules/services/syncthing.nix
    ../../modules/services/tailscale.nix
    ../../modules/docker.nix

    ../../modules/services/jellyfin.nix
    ../../modules/services/immich.nix

    ../../modules/services/user/mpd.nix
    ../../modules/services/user/pueued.nix
  ];

  custom.syncthing = {
    enable = true;
    user = "zenith";
  };

  custom.jellyfin = {
    enable = true;
    user = "zenith";
  };

  services = {
    logind.settings.Login.HandleLidSwitchDocked = "poweroff"; ## one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # getty.autologinUser = "zenith";
    # displayManager.ly.enable = true; ## teminal display manager

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
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

    openssh = {
      enable = true;
      settings = {
        # require public key authentication for better security
        # PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [
          "knack"
          "zenith"
          "hadish"
        ];
      };
    };
    fail2ban.enable = true;

    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
