{pkgs, ...}: {
  xdg = {
    ## set in nixos/hyprland.nix
    # portal = {
    #   enable = true;
    #   extraPortals = with pkgs; [
    #     xdg-desktop-portal
    #     xdg-desktop-portal-gtk
    #   ];
    #   config.common.default = "*";
    #   xdgOpenUsePortal = true;
    # };

    /**
    ## To list all .desktop-files, run
    ##
    ## ls /run/current-system/sw/share/applications # for global packages
    ## ls /etc/profiles/per-user/$(id -n -u)/share/applications # for user packages
    ## ls ~/.nix-profile/share/applications # for home-manager packages
    */
    mimeApps = {
      enable = true;

      associations.added = {
        "image/jpeg" = ["imv.desktop"];
        "video/mp4" = ["mpv.desktop"];
        "application/pdf" = [
          "evince.desktop"
          "zathura.desktop"
        ]; # .pdf
      };

      defaultApplications = {
        "image/png" = ["imv.desktop"];
        "image/jpeg" = ["imv.desktop"];
        "image/gif" = ["imv.desktop"];
        "image/webp" = ["imv.desktop"];
        "image/bmp" = ["imv.desktop"];
        "image/tiff" = ["imv.desktop"];
        "image/*" = [
          "imv.desktop"
          "gimp.desktop"
        ];

        "inode/directory" = ["dolphin.desktop"]; # Directories
        "text/plain" = ["helix.desktop"]; # Plain text
        "text/*" = ["helix.desktop"]; # Any text files

        "application/pdf" = ["evince.desktop"]; # .pdf

        "application/zip" = ["xarchiver.desktop"];
        "text/html" = ["zen-beta.desktop"]; # Any text files
        "video/*" = ["mpv.desktop"]; # Any video files

        "x-scheme-handler/https" = ["zen-beta.desktop"]; # Links
        "x-scheme-handler/http" = ["zen-beta.desktop"]; # Links
        "x-scheme-handler/mailto" = ["zen-beta.desktop"]; # Links
        "x-scheme-handler/chrome" = ["zen-beta.desktop"]; # Links
        "application/x-extension-htm" = ["zen-beta.desktop"];
        "application/x-extension-html" = ["zen-beta.desktop"];
        "application/x-extension-shtml" = ["zen-beta.desktop"];
        "application/xhtml+xml" = ["zen-beta.desktop"];
        "application/x-extension-xhtml" = ["zen-beta.desktop"];
        "application/x-extension-xht" = ["zen-beta.desktop"];

        # "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
        #   "onlyoffice-desktopeditors.desktop"
        # ]; # .docx
        # "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
        #   "onlyoffice-desktopeditors.desktop"
        # ]; # .pptx
      };
    };
  };
}
