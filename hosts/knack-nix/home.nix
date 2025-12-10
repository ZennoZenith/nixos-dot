{
  inputs,
  pkgs,
  config,
  variables,
  ...
}: let
  dotfiles = "${variables.home.homeDirectory}/nixos-dot/configs";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    glow = "glow";
    mpd = "mpd";
    rmpc = "rmpc";
    omm = "omm";
    zellij = "zellij";
    waybar = "waybar";
    starship = "starship";
    nushell = "nushell";
    scripts = "scripts";
    television = "television";
  };
in {
  imports = [
    inputs.zen-browser.homeModules.beta
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/ghostty.nix
    ../../modules/home-manager/keychain.nix
    ../../modules/home-manager/bash.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/ghostty.nix
    ../../modules/home-manager/atuin.nix
    ../../modules/home-manager/bat.nix
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/yazi.nix
    ../../modules/home-manager/go.nix
    ../../modules/home-manager/nix-search-tv.nix
    ../../modules/home-manager/gpg-agent.nix
    ../../modules/home-manager/jujutsu.nix
    ../../modules/home-manager/tofi.nix
    ../../modules/home-manager/helix.nix
    ../../modules/home-manager/fastfetch.nix
    ../../modules/home-manager/swayosd.nix
    ../../modules/home-manager/htop.nix
    ../../modules/home-manager/cava.nix
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/wizterm.nix
    ## TODO: # ../../modules/home-manager/fzf.nix
  ];

  custom.pgp.enable = true;
  custom.jujutsu = {
    enable = true;
    name = variables.git.name;
    email = variables.git.email;
    gpgKey = variables.git.gpg.key;
  };

  custom.git = {
    enable = true;
    name = variables.git.name;
    email = variables.git.email;
    gpgKey = variables.git.gpg.key;
  };

  home = {
    username = variables.home.username;
    homeDirectory = variables.home.homeDirectory;
    stateVersion = variables.home.stateVersion;
    shell.enableNushellIntegration = true;

    packages = with pkgs; [
      ghostty
      atuin
      zathura
      evince
      seahorse
    ];

    file = {
      ".cargo/config.toml".source = ../../configs/.cargo/config.toml;
    };
  };

  programs.zen-browser.enable = true;

  #  Enables seemless zoxide integration
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.eza = {
    enable = true;
    icons = "always";
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--header" # Show header row
      "--git-ignore"
      "--classify" # append indicator (/, *, =, @, |)
      "--hyperlink" # make paths clickable in some terminals
    ];
  };

  targets.genericLinux.gpu.nvidia.enable = true;

  services.kdeconnect.enable = true;
  services.swayosd.enable = true;

  # Dracula theme configuration
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
    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  xdg = {
    /**
    ## configFile."fastfetch" = {
    ##   source = create_symlink "${dotfiles}/fastfetch/";
    ##   recursive = true;
    ## };
    */

    configFile =
      builtins.mapAttrs (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}/";
        recursive = true;
      })
      configs;

    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
      xdgOpenUsePortal = true;
    };

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
        "text/html" = ["zen.desktop"]; # Any text files
        "video/*" = ["mpv.desktop"]; # Any video files

        "x-scheme-handler/https" = ["zen.desktop"]; # Links
        "x-scheme-handler/http" = ["zen.desktop"]; # Links
        "x-scheme-handler/mailto" = ["zen.desktop"]; # Links
        "x-scheme-handler/chrome" = ["zen.desktop"]; # Links
        "application/x-extension-htm" = ["zen.desktop"];
        "application/x-extension-html" = ["zen.desktop"];
        "application/x-extension-shtml" = ["zen.desktop"];
        "application/xhtml+xml" = ["zen.desktop"];
        "application/x-extension-xhtml" = ["zen.desktop"];
        "application/x-extension-xht" = ["zen.desktop"];

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
