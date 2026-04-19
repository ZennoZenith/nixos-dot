{...}: {
  ## REMOTE BUILDER
  users.users.remotebuild = {
    isSystemUser = true;
    group = "remotebuild";
    useDefaultShell = true;

    # openssh.authorizedKeys.keyFiles = [./remotebuild.pub];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINxeHhhBmXYP1Be4m+snZlVHieXAHBaOUv3a83QpSbG4 (none)"

      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvR+icsS7ocB1mlZIXKLMh41RjHSTJKcVwV9bmJxlfI zenith-arch:knack-arch"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENWlT75aCPretBcIhW2Wg7yggAkzKhmRbqJqcXmpyhf linode-ubuntu-1:knack-arch"

      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIILmN38TN7jL7jIUHhu2t25+KdkdBaHpllpOGbRlb/8t knack@knacknix"
    ];
  };

  users.groups.remotebuild = {};

  nix.settings = {
    trusted-users = ["remotebuild"];
    secret-key-files = ["/etc/nix/secret-key"];
    trusted-public-keys = [
      "builder-key:MEwLx5gJEF30JOxVjvsJrhb2415KdUu4VBsdFPgKAYI=" ## Builder public key
    ];
  };
}
