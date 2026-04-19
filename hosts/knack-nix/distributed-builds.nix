{pkgs, ...}: {
  nix.settings.trusted-users = ["root" "knack"];
  nix.distributedBuilds = true;
  nix.settings.builders-use-substitutes = true;
  nix.settings.trusted-public-keys = [
    "builder-key:MEwLx5gJEF30JOxVjvsJrhb2415KdUu4VBsdFPgKAYI=" ## Builder public key
  ];

  nix.buildMachines = [
    {
      # hostName = "remotebuilder";
      hostName = "100.71.238.4";
      sshUser = "remotebuild";
      protocol = "ssh-ng";
      sshKey = "/home/knack/.ssh/remotebuild";
      system = pkgs.stdenv.hostPlatform.system;
      supportedFeatures = ["nixos-test" "big-parallel" "kvm"];
      maxJobs = 16;
    }
  ];
}
