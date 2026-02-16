{inputs, ...}: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  ## for nixd package
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
