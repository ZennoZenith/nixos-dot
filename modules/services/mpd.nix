{ pkgs, ... }:

{
  systemd.user.services.mpd = {
    description = "Music Player Daemon";

    serviceConfig = {
      Type = "notify";
      ExecStart = "${pkgs.mpd}/bin/mpd --systemd";

      # WatchdogSec = 120;

      # sandboxing
      PrivateUsers = true;
      ProtectSystem = "yes";
      NoNewPrivileges = true;
      ProtectKernelTunables = true;
      ProtectControlGroups = true;
      RestrictNamespaces = true;
      RestrictAddressFamilies = [
        "AF_INET"
        "AF_INET6"
        "AF_UNIX"
      ];

      # Real-time & io_uring limits (optional, from your original unit)
      LimitRTPRIO = 40;
      LimitRTTIME = "infinity";
      LimitMEMLOCK = "64M";
    };

    wantedBy = [ "default.target" ];
  };

  systemd.user.sockets.mpd = {
    socketConfig = {
      ListenStream = [
        "%t/mpd/socket"
        "6600"
      ];

      Backlog = 5;
      KeepAlive = true;
      PassCredentials = true;
    };

    wantedBy = [ "sockets.target" ];
  };

}
