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

    user = lib.mkOption {
      type = with lib.types; nullOr (types.str);
      default = null;
      description = ''
        add <user> to docker group
      '';
    };
  };

  config = lib.mkIf config.custom.${service_name}.enable {
    virtualisation.docker.enable = true;

    users.users.${config.custom.${service_name}.user}.extraGroups = ["docker"];
    virtualisation.docker.storageDriver = "btrfs";
  };
}
