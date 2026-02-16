{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
      #package = pkgs.tokyonight-gtk-theme;
      #Dark (Blue Accent): "Tokyonight-Dark-B"
      #Dark (Moon Accent): "Tokyonight-Dark-Moon"
      #Storm (Gray/Muted Accent): "Tokyonight-Storm-B"
    };
    # Optional: uncomment for Dracula icons
    iconTheme = {
      name = "candy-icons";
      package = pkgs.candy-icons;
    };
    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
    };

    gtk4.theme = null;
    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
