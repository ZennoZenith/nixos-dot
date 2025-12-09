{
  lib,
  config,
  ...
}: let
  service_name = "ssh";
in {
  options.custom.${service_name} = {
    enable = lib.mkEnableOption {
      description = "Enable ssh";
      default = false;
    };

    AllowUsers = lib.mkOption {
      type = with lib.types; nullOr (listOf str);
      default = null;
      description = ''
        If specified, login is allowed only for the listed users.
        See {manpage}`sshd_config(5)` for details.
      '';
    };
  };

  config = lib.mkIf config.custom.${service_name}.enable {
    # users.extraGroups.docker.members = config.custom.docker.members;

    programs.ssh = {
      startAgent = true;
      enableAskPassword = true;
    };

    services.openssh = {
      enable = true;
      settings = {
        # # require public key authentication for better security
        # PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = config.custom.${service_name}.AllowUsers;
      };
    };

    services.fail2ban.enable = true;

    environment.variables = {
      SSH_ASKPASS_REQUIRE = "prefer";
    };
  };
}
