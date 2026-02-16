$env.EDITOR = 'hx'
$env.PAGER = 'delta'
$env.BAT_THEME = 'Monokai Extended'
$env.MANPAGER = "sh -c 'sed -u -e \"s/\\x1B\\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
$env.GPG_TTY = ^tty
$env.AWWW_TRANSITION_FPS = 255
$env.AWWW_TRANSITION_DURATION = 1.5


$env.LOCAL_BIN = $'($nu.home-dir)/.local/bin'
$env.CARGO_PATH = $'($nu.home-dir)/.cargo/bin'
$env.DENO_INSTALL = $'($nu.home-dir)/.deno'
$env.BUN_INSTALL = $'($nu.home-dir)/.bun'
$env.NVM_DIR = $'($nu.home-dir)/.nvm'
$env.BUN_PATH = $'($env.BUN_INSTALL)/bin'
$env.GO_PATH = '/usr/local/go/bin'
$env.GO_BINS = $'($nu.home-dir)/go/bin'
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


