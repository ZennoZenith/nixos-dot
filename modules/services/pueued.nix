{pkgs, ...}: {
  systemd.user.services.pueued = {
    description = "Pueue Daemon - CLI process scheduler and manager";

    serviceConfig = {
      Type = "notify";
      ExecStart = "${pkgs.pueue}/bin/pueue -vv";

      Restart = "no";
    };

    wantedBy = ["default.target"];
  };
}
