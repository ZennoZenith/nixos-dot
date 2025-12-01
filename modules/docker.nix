{...}: {
  virtualisation.docker.enable = true;
  users.users.zenith.extraGroups = ["docker"];
  users.extraGroups.docker.members = ["zenith"];
  virtualisation.docker.storageDriver = "btrfs";
}
