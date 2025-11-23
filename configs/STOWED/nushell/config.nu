$env.EDITOR = 'hx'
$env.PAGER = 'delta'
$env.BAT_THEME = 'Monokai Extended'
$env.MANPAGER = "sh -c 'sed -u -e \"s/\\x1B\\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
$env.GPG_TTY = ^tty


$env.config.show_banner = false # true or false to enable or disable the welcome banner at startup
$env.config.buffer_editor = "hx"
$env.config.edit_mode = 'vi'
# "block", "underscore", "line", "blink_block", "blink_underscore", "blink_line", or "inherit"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

## TODO: load LS_COLORS from file
$env.LS_COLORS = (vivid generate lava)
$env.config.render_right_prompt_on_last_line = true

$env.config.history = {
  file_format: sqlite
  max_size: 5_000_000
  sync_on_enter: true
  isolation: true
}
$env.config.rm.always_trash = true
$env.config.filesize.unit = 'binary'

# =============================== ENV =========================================
$env.LOCAL_BIN = $'($nu.home-path)/.local/bin'
$env.CARGO_PATH = $'($nu.home-path)/.cargo/bin'
$env.DENO_INSTALL = $'($nu.home-path)/.deno'
$env.BUN_INSTALL = $'($nu.home-path)/.bun'
$env.NVM_DIR = $'($nu.home-path)/.nvm'
$env.BUN_PATH = $'($env.BUN_INSTALL)/bin'
$env.GO_PATH = '/usr/local/go/bin'
$env.GO_BINS = $'($nu.home-path)/go/bin'
$env.CUDA_PATH = "/opt/cuda"
$env.CUDA_BIN = $'($env.CUDA_PATH)/bin'


# =============================== PATH ========================================
let list_of_paths = [
  $env.LOCAL_BIN
  /home/linuxbrew/.linuxbrew/bin 
  /home/linuxbrew/.linuxbrew/sbin 
  $env.CARGO_PATH
  $"($env.DENO_INSTALL)/bin"
  $env.BUN_PATH
  $env.GO_PATH
  $env.GO_BINS
  $env.CUDA_BIN
   # etc.
]
use std/util "path add"
path add ...$list_of_paths
# $env.path ++= ["~/.local/bin"]

## theme is handeled by ghostty terminal
# source ($nu.config-path | path dirname | path join 'nu-themes/catppuccin-mocha.nu')

# =============================== ALIAS =======================================
alias pp = do {pacman -Qqe | fzf --multi --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'}

use ~/dotfiles/.config/nushell/scripts/keychain/keychain.nu *
load_keychian

def show_banner [] {
    let ellie = [
        "     __  ,"
        " .--()°'.'"
        "'|, . ,'  "
        ' !_-(_\   '
    ]
    let s_mem = (sys mem)
    let s_ho = (sys host)
    print $"(ansi reset)(ansi green)($ellie.0)"
    print $"(ansi green)($ellie.1)  (ansi yellow) (ansi yellow_bold)Nushell (ansi reset)(ansi yellow)v(version | get version)(ansi reset)"
    print $"(ansi green)($ellie.2)  (ansi light_blue) (ansi light_blue_bold)RAM (ansi reset)(ansi light_blue)($s_mem.used) / ($s_mem.total)(ansi reset)"
    print $"(ansi green)($ellie.3)  (ansi light_purple)ﮫ (ansi light_purple_bold)Uptime (ansi reset)(ansi light_purple)($s_ho.uptime)(ansi reset)"
}

show_banner
