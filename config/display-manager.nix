{...}: {
  imports = [
    # ../../config/regreet.nix
  ];

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      bigclock = "true";
    };
  };
}
