# {variables, ...}: let
#   uploadLocation = "/mnt/whole/Services/immich";
# in {
#   services.immich = {
#     enable = true;
#     accelerationDevices = null;
#     # mediaLocation = uploadLocation;
#     # secretsFile = "/home/zenith/nixos-dot/hosts/zenith-nix/secrets/immich";
#     user = variables.home.username;
#     environment = {UPLOAD_LOCATION = uploadLocation;};
#   };
# }
