{
  pkgs,
  variables,
  config,
  ...
}: {
  environment = {
    pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
    ## [Fix for dolphin default file association](https://discuss.kde.org/t/dolphin-file-associations/38934/2)
    etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    variables = {
      EDITOR = "${pkgs.helix}/bin/hx";
      # SSH_ASKPASS_REQUIRE = "prefer";
    };

    sessionVariables = {
      NH_FLAKE = "${variables.home.homeDirectory}/nixos-dot";
      XDG_DATA_DIRS = [
        "${config.system.path}/share"
        "${pkgs.kdePackages.dolphin}/share"
      ];
    };
  };
}
