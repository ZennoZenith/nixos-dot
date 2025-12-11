{
  pkgs,
  variables,
  ...
}: let
  greetdStartup = pkgs.writeShellScriptBin "greetd-startup" ''
    #!/bin/sh
    export WLR_NO_HARDWARE_CURSORS=1
    start-hyprland -- --config ~/.config/hypr/hyprland.conf
  '';
in {
  imports = [
    # ../../config/regreet.nix
  ];

  # services.displayManager.ly = {
  #   enable = true;
  #   settings = {

  #     animation = "matrix";
  #     bigclock = "true";
  #   };
  # };

  # make script available system-wide (optional but useful)
  environment.systemPackages = [
    greetdStartup
  ];

  services = {
    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "Hyprland";
          user = "${variables.home.username}";
        };
        default_session = {
          # note: use the script as the command started by tuigreet
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'Welcome To NixOS' --asterisks --remember --remember-user-session --time -cmd ${greetdStartup}/bin/greetd-startup";
          #   # DO NOT CHANGE THIS USER
          user = "greeter";
        };
        # default_session = {
        #   command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'Welcome To NixOS' --asterisks --remember --remember-user-session --time -cmd Hyprland";
        #   # DO NOT CHANGE THIS USER
        #   user = "greeter";
        # };
      };
    };
  };
}
