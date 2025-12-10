{...}: {
  imports = [
    ../common/home.nix
  ];

  custom.keychain.keys = [
    "github"
    "knack"
    "linode"
    "zenith"
  ];
}
