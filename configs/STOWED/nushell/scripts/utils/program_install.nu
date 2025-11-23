let dnf_installs = [
  helix
  clang
  mold
  lld
  postgresql-server
  postgresql-contrib
  fastfetch
]
# dnf copr enable zeno/scrcpy && dnf install scrcpy

# https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions
# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
# echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
# dnf check-update
# sudo dnf install code # or code-insiders



let brew_programs = [
  # gcc
  # bacon
  # watchexec
  # helix
  # nushell
  # fzf
  # zoxide
  # ripgrep
  # bat
  # zellij
  # lsd
  # fd
  # sd
  # lazygit
  # csvq
  # atuin
  # mprocs
  # sccache
  # fish # required for nushell completer
  # rsteube/tap/carapace # required for nushell completer
  # tlrc # command name is tldr
  # thefuck
  # csvlens
  # git-delta
  # golangci-lint
  # just
  # dprint
  # clipboard
  # marksman
  # gh
  # pyright # python lsp 
]

# rustup component add
let rustup_components = [
  rust-analyzer
  clippy
  rustfmt
  llvm-tools-preview
]
 
# rustup target add
let rustup_target = [
  wasm32-unknown-unknown
]

let rust_toolchain = [
   'nightly --allow-downgrade'
]

let cargo_installs = [
  'sqlx-cli --no-default-features --features postgres'
  cargo-binstall
  cargo-info
  cargo-udeps
]
let cargo_installs_git = [
  cargo install --git https://github.com/nushell/nufmt
]

let cargo_binstalls = [
  cargo-nextest
  cargo-watch
  atac
  ttyper
  pylyzer --locked # python lsp
]

let script_installs = []

let script_installs_with_bash = [
  # rust
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

  # starship
  curl -sS https://starship.rs/install.sh | sh

  # fnm
  curl -fsSL https://fnm.vercel.app/install | bash

  # bun
  curl -fsSL https://bun.sh/install | bash

  # ruff ## python LSP
  curl -LsSf https://astral.sh/ruff/install.sh | sh

  # ab-download manager (https://github.com/amir1376/ab-download-manager)
  curl -fsSL https://raw.githubusercontent.com/amir1376/ab-download-manager/master/scripts/install.sh | bash
]

## Go tools
# go install golang.org/x/tools/gopls@latest                         # LSP
# go install github.com/go-delve/delve/cmd/dlv@latest                # Debugger
# go install golang.org/x/tools/cmd/goimports@latest                 # Formatter
# go install github.com/nametake/golangci-lint-langserver@latest     # Linter
let go_installs = [
  golang.org/x/tools/gopls@latest                         # LSP github.com/go-delve/delve/cmd/dlv@latest                # Debugger
  golang.org/x/tools/cmd/goimports@latest                 # Formatter
  github.com/nametake/golangci-lint-langserver@latest     # Linter
  github.com/melkeydev/go-blueprint@latest
  github.com/a-h/templ/cmd/templ@latest
  github.com/air-verse/air@latest
]


# npm install -g 
let bun_installs = [
  vscode-langservers-extracted
  typescript
  typescript-language-server
  sql-language-server
  @tailwindcss/language-server
  svelte-language-server
  live-server
  emmet-ls
]


### ARCH linux
# install yay
# sudo pacman -S --needed git base-devel
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si

let yay = [
  alacritty
  kitty
  ttf-font-awesome
  wireguard-tools
  syncthing
  clang
  mold
  lld
  fastfetch
  eget-bin
  p7zip
  pueue # Pueue is a command-line task management tool for sequential and parallel execution of long-running tasks.
  yazi # (optional dependiecies) paru -S yazi ffmpeg p7zip jq poppler fd ripgrep fzf zoxide imagemagick
  tree
  age
  ouch # https://terminaltrove.com/ouch/
  tealdeer # tldr in rust
]

let autostart_commands = [
  $'systemctl enable syncthing@($env.USER).service'
  $'systemctl start syncthing@($env.USER).service'
  systemctl enable syncthing.service --user
  systemctl enable pueued --user
  systemctl --user enable atuin.service --now

]

let hyprland_cursor = "https://github.com/ndom91/rose-pine-hyprcursor"


let arch_fonts = [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  noto-fonts-extra
]

let nerd_fonts_aur = [
  ttf-cascadia-code-nerd
  ttf-cascadia-mono-nerd
  # ttf-fira-code
  ttf-fira-mono
  # ttf-fira-sans
  ttf-firacode-nerd
  # ttf-iosevka-nerd
  # ttf-iosevkaterm-nerd
  ttf-jetbrains-mono-nerd
  ttf-jetbrains-mono
  # ttf-nerd-fonts-symbols
  # ttf-nerd-fonts-symbols
  # ttf-nerd-fonts-symbols-mono
]


# paru -S ripgrep-all
# (Optional)
#     ffmpeg: for the ffmpeg adapter
#     graphicsmagick: for the pdfpages adapter
#     pandoc: for the pandoc adapter
#     poppler: for the poppler adapter
#     tesseract: for the tesseract adapter


