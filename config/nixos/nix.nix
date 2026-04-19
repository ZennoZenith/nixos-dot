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

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
      "https://unmojang.cachix.org"
      "https://prismlauncher.cachix.org"

      "https://cache.nixos.asia/oss"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "unmojang.cachix.org-1:OfHnbBNduZ6Smx9oNbLFbYyvOWSoxb2uPcnXPj4EDQY="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="

      "oss:KO872wNJkCDgmGN3xy9dT89WAhvv13EiKncTtHDItVU="
    ];
  };
}
