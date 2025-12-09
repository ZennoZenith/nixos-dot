{
  lib,
  config,
  ...
}: let
  service_name = "docker";
in {
  options.custom.${service_name} = {
    enable = lib.mkEnableOption {
      description = "Enable Docker";
      default = false;
    };

    members = lib.mkOption {
      # type = lib.types.listOf lib.types.str;
      type = with lib.types; listOf (passwdEntry str);
      default = [];
      description = ''
        The user names of the group members, added to the
        `/etc/group` file.
      '';
    };
  };

  config = lib.mkIf config.custom.${service_name}.enable {
    virtualisation.docker.enable = true;

    # users.users.<username>.extraGroups = ["docker"];
    users.users = lib.genAttrs config.custom.${service_name}.members (member: {
      member.extraGroups = ["docker"];
    });
    users.extraGroups.docker.members = config.custom.${service_name}.members;
    virtualisation.docker.storageDriver = "btrfs";
  };
}
