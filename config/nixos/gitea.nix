{pkgs, ...}: {
  users.groups.git = {};

  users.users.git = {
    isSystemUser = true;
    description = "Git Version Control";
    home = "/home/git";
    createHome = true;
    shell = pkgs.fish;
    group = "git";
    hashedPassword = "$6$wV.OLT/PQJUY5Qga$kO6slnYFyQ2JeTK55.WV3G.oCWTr1iQowga/rQgsswrvj.X0itvou1OBBGnJTG1./etzuwmnmW0BpvUQtOazK/";
  };

  # services.gitea = {
  #   enable = true;
  #   user = "git";
  #   group = "git";
  #   stateDir = "/var/lib/gitea";

  #   settings.server = {
  #     ROOT_URL = "https://gitea.zennozenith.com/";
  #     HTTP_ADDR = "0.0.0.0";
  #     HTTP_PORT = 3333;
  #   };
  # };

  networking.firewall.allowedTCPPorts = [2222 3333];

  systemd.services.gitea = {
    description = "Gitea (Git with a cup of tea)";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "simple";
      User = "git";
      Group = "git";
      WorkingDirectory = "/var/lib/gitea";

      ExecStart = "${pkgs.gitea}/bin/gitea --config /etc/gitea/app.ini";

      Restart = "always";
      RestartSec = "2s";

      Environment = [
        "USER=git"
        "HOME=/home/git"
        "GITEA_WORK_DIR=/var/lib/gitea"
      ];

      # LimitNOFILE = 524288;
      # RuntimeDirectory = "gitea";
      # CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
      # AmbientCapabilities = "CAP_NET_BIND_SERVICE";
    };
  };
}
