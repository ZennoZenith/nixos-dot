{
  inputs,
  pkgs,
  ...
}: {
  # services.swayosd.enable = true; ## started in hyprland.conf exec
  # services.kdeconnect.enable = true; ## started in hyprland.conf exec

  systemd.user.services.ie-r = {
    Unit = {
      Description = "ie-r autostart";
      After = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${inputs.ie-r.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/ie-r";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  systemd.user.startServices = "sd-switch";
}
