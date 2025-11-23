{pkgs, ...}: {
  systemd.user.services.syncthing = {
    description = "Syncthing - Open Source Continuous File Synchronization";

    startLimitIntervalSec = 60;
    startLimitBurst = 4;

    serviceConfig = {
      Type = "notify";
      ExecStart = "${pkgs.syncthing}/bin/syncthing serve --no-browser --no-restart --logflags=0";

      Restart = "on-failure";
      RestartSec = 1;

      SuccessExitStatus = "3 4";
      RestartForceExitStatus = "3 4";

      # Hardening
      SystemCallArchitectures = "native";
      MemoryDenyWriteExecute = true;
      NoNewPrivileges = true;

      # Elevated permissions to sync ownership (disabled by default),
      # see https://docs.syncthing.net/advanced/folder-sync-ownership
      #AmbientCapabilities=CAP_CHOWN CAP_FOWNER
    };

    wantedBy = ["default.target"];
  };
}
