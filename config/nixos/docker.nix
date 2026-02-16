{variables, ...}: {
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  users.users.${variables.home.username}.extraGroups = ["docker"];
}
