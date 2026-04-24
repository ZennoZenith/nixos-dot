{variables, ...}: {
  systemd.services.nix-daemon.serviceConfig = {
    MemoryAccounting = true;
    MemoryMax = "90%";
    OOMScoreAdjust = 500;
  };

  # services.mysql = {
  #   enable = true;
  #   package = pkgs.mariadb;
  # };

  services.openssh = {
    enable = true;
    settings = {
      # # require public key authentication for better security
      # PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = variables.ssh.AllowUsers;
    };
  };

  ## run `sudo tailscale up --auth-key=KEY --advertise-exit-node`
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire."10-sunshine-combo-sink" = {
      "context.objects" = [
        {
          factory = "adapter";
          args = {
            "factory.name" = "support.null-audio-sink";
            "node.name" = "sunshine-combo";
            "node.description" = "Sunshine Combo Sink (Local + Stream)";
            "media.class" = "Audio/Sink";
            "audio.position" = ["FL" "FR"];
          };
        }
      ];
    };

    extraConfig.pipewire."10-disable-flatvolumes" = {
      "context.properties" = {
        "flat.volumes" = false;
      };
    };
  };

  ## Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  services.tuned.enable = true;
  services.upower.enable = true;
  services.logind.settings.Login = {
    HandleLidSwitchDocked = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitch = "suspend";
    HandlePowerKeyLongPress = "poweroff";
    HandlePowerKey = "suspend";
  };

  # services.getty.autologinUser = "knack";
  # services.tumbler.enable = true;
  # services.envfs.enable = true;
  # services.seatd.enable = true;
}
