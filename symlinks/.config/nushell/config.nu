$env.GPG_TTY = ^tty

export-env {
    let envs = open ~/.env_vars.toml
    load-env $envs

    if "myPathList" in $envs {
        $env.PATH = $envs.myPathList ++ $env.PATH
    }
}


$env.config.show_banner = false # true or false to enable or disable the welcome banner at startup
$env.config.buffer_editor = "hx"
$env.config.edit_mode = 'vi'
# "block", "underscore", "line", "blink_block", "blink_underscore", "blink_line", or "inherit"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

## TODO: load LS_COLORS from file
## DEPRECATED:
# $env.LS_COLORS = (vivid generate lava)
 
$env.config.render_right_prompt_on_last_line = true
$env.config.history = {
  file_format: sqlite
  max_size: 5_000_000
  sync_on_enter: true
  isolation: true
}
$env.config.rm.always_trash = true
$env.config.filesize.unit = 'binary'


source ~/.config/nushell/source/alias.nu

## ── GPG ─────────────────────────────────────────────────────────────────────
$env.SSH_AUTH_SOCK = $"(gpgconf --list-dirs agent-ssh-socket)"
gpgconf --launch gpg-agent

## ── Atuin ───────────────────────────────────────────────────────────────────
source ~/.config/nushell/source/atuin_hex_init.nu
source ~/.config/nushell/source/atuin_init.nu
#bind to ctrl-r in emacs, vi_normal and vi_insert modes, add any other bindings you want here too
export-env {
    if ('atuin' not-in ($env.config.keybindings | get name) ) {
        $env.config.keybindings ++= [{
            name: atuin
            modifier: control
            keycode: char_r
            mode: [emacs, vi_normal, vi_insert]
            event: { send: executehostcommand cmd: (_atuin_search_cmd) }
        }]
    }
}

## ── Completer ───────────────────────────────────────────────────────────────
source ~/.config/nushell/source/completer.nu

## ── Fzf ─────────────────────────────────────────────────────────────────────
source ~/.config/nushell/source/fzf.nu

## ── Starship ────────────────────────────────────────────────────────────────
# $env.STARSHIP_CONFIG = $'($nu.home-dir)/.config/starship/starship.toml'
source ~/.config/nushell/source/starship.nu

## ── Yazi ────────────────────────────────────────────────────────────────────
source ~/.config/nushell/source/yazi.nu

## ── Zoxide ──────────────────────────────────────────────────────────────────
source ~/.config/nushell/source/zoxide.nu
 
## ── Zellij ──────────────────────────────────────────────────────────────────
source ~/.config/nushell/source/zellij.nu


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

# show_banner

