{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # https://github.com/JaKooLit/NixOS-Hyprland
    # aim
    # jome
    # crates-tui-git
    # https://github.com/muandane/goji
    # hl ## added in flake.nix
    # omm
    # timr-tui
    # clock-tui
    # rust-stakeholder

    libnotify # send alerts
    xdg-desktop-portal-gtk

    ## Hyprland Related
    grimblast
    nwg-look
    rofi
    swww
    tofi
    walker
    waybar
    wlogout
    wofi
    wl-clipboard

    ## Packages
    age
    alacritty
    atuin
    bandwhich
    bibata-cursors
    btop-cuda
    carapace
    clang
    cliphist
    coreutils
    csvlens
    curl
    dua
    dysk
    fastfetch
    fclones
    fd
    fish
    fx
    fzf
    gcc
    gh
    ghostty
    git
    git-cliff
    gitui
    go
    gping
    gtrash
    helix
    igrep
    imv
    jujutsu
    kdePackages.dolphin
    kdePackages.kde-cli-tools
    kdePackages.kdeconnect-kde
    kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    kdePackages.kio-fuse #to mount remote filesystems via FUSE
    kdePackages.kservice
    kdePackages.qtkeychain
    kdePackages.qtsvg
    keychain
    kitty
    lazygit
    lazysql
    mdcat
    meld
    mpd
    gnumake
    cmake
    mpv
    nil
    nixd # nix lsp
    nushell
    pamixer
    pavucontrol
    pipewire
    playerctl
    repgrep
    ripgrep
    ripgrep-all
    rmpc
    sd
    skim
    starship
    tailspin
    tealdeer
    tig
    tree
    uv
    vivid
    vlc
    watchexec
    wireplumber
    wget
    zed-editor
    zellij

    p7zip

    ## Utilities
    biome
    bitwarden-cli
    brightnessctl
    csvq
    difftastic
    discord
    dprint
    hurl
    jaq
    just
    kanata
    monolith
    mprocs
    oha
    pastel
    pueue
    qrtool
    superhtml
    taplo
    television
    topgrade
    wikiman
    xh
    yaak

    # Lesser Known/Specific Utilities
    andcli
    atac
    basalt
    bmm
    diffnav
    koji
    mergiraf
    pik
    rucola
    scooter
    serie
    serpl
    slumber
    uwsm
    syncthing
    dbeaver-bin
    mariadb
    libreoffice-fresh
    evince # pdf
    zathura ## pdf
    localsend
    file

    egl-wayland

    pyright
    ruff
    pyrefly
    seahorse ## Gui for OpenPGP

    nixd
    obsidian
    systemctl-tui
    lazydocker
    jq
    ouch

    nh
    nix-output-monitor
    nvd
    sshfs
    qalculate-qt
    libqalculate
    moonlight-qt

    delta
    yazi
    diffnav

    # wine-staging
    wineWowPackages.staging
    # winetricks
    # wineWowPackages.waylandFull
    bottles
    nur.repos."0komo".sklauncher
    simple-http-server
  ];
}
