{pkgs, ...}: {
  systemd.user.services.pueued = {
    enable = true;

    description = "Pueue Daemon - CLI process scheduler and manager";

    serviceConfig = {
      Type = "notify";
      ExecStart = "${pkgs.pueue}/bin/pueued -vv";

      Restart = "no";
    };

    wantedBy = ["default.target"];
  };
}
