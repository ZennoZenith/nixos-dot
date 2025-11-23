{...}: {
  imports = [
    ./services/default.nix
    ./services/mpd.nix
    ./services/syncthing.nix
    ./services/pueued.nix
  ];
}
