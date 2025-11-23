##
## some code is taken from (tv init nu). If needed to regenerate run that command 
##

def tv_files [] {
    let line = (commandline)
    let cursor = (commandline get-cursor)
    let lhs = ($line | str substring 0..$cursor)
    let rhs = ($line | str substring $cursor..)
    cd ~
    let output = (tv files | str trim)
    const PREFIX = "~/"

    if ($output | str length) > 0 {
        let needs_space = not ($lhs | str ends-with " ")
        let lhs_with_space = if $needs_space { $"($lhs) " } else { $lhs }
        let new_line =  $lhs_with_space + $PREFIX + $output + $rhs
        let new_cursor = ($lhs_with_space + $PREFIX + $output | str length)
        commandline edit --replace $new_line
        commandline set-cursor $new_cursor
    }
}

def tv_files_in_cwd [] {
    let line = (commandline)
    let cursor = (commandline get-cursor)
    let lhs = ($line | str substring 0..$cursor)
    let rhs = ($line | str substring $cursor..)
    # let output = (tv --inline --autocomplete-prompt $lhs | str trim)
    let output = (tv files | str trim)

    if ($output | str length) > 0 {
        let needs_space = not ($lhs | str ends-with " ")
        let lhs_with_space = if $needs_space { $"($lhs) " } else { $lhs }
        let new_line = $lhs_with_space + $output + $rhs
        let new_cursor = ($lhs_with_space + $output | str length)
        commandline edit --replace $new_line
        commandline set-cursor $new_cursor
    }
}

def --env tv_change_dir [] {
    let current_prompt = (commandline)
    let output = (tv dirs --input $current_prompt | str trim)
    cd $output
}

def tv_shell_history [] {
    let current_prompt = (commandline)
    let cursor = (commandline get-cursor)
    let current_prompt = ($current_prompt | str substring 0..$cursor)

    let output = (tv nu-history --inline --input $current_prompt | str trim)

    if ($output | is-not-empty) {
        commandline edit --replace $output
        commandline set-cursor --end
    }
}

export-env {
    if ('tv_dirs' not-in ($env.config.keybindings | get name) ) {
        $env.config.keybindings ++= [{
            name: tv_dirs,
            modifier: alt
            keycode: char_c
            mode: [emacs, vi_normal, vi_insert]
            event: {
                send: executehostcommand,
                ## using a function and using cd inside it does not actually change dir
                cmd: "tv_change_dir"
            }
        }]
    }

    if ('tv_history' not-in ($env.config.keybindings | get name) ) {
        $env.config.keybindings ++= [{
            name: tv_history,
            modifier: Control,
            keycode: char_h,
            mode: [vi_normal, vi_insert, emacs],
            event: {
                send: executehostcommand,
                cmd: "tv_shell_history"
            }
        }]
    }

    if ('tv_files_keybind' not-in ($env.config.keybindings | get name) ) {
        $env.config.keybindings ++= [{
            name: tv_files_keybind,
            modifier: Control,
            keycode: char_f,
            mode: [vi_normal, vi_insert, emacs],
            event: {
                send: executehostcommand,
                cmd: "tv_files"
            }
        }]
    }

    if ('tv_files_in_cwd_keybind' not-in ($env.config.keybindings | get name) ) {
        $env.config.keybindings ++= [{
            name: tv_files_in_cwd_keybind,
            modifier: Control,
            keycode: char_t,
            mode: [vi_normal, vi_insert, emacs],
            event: {
                send: executehostcommand,
                cmd: "tv_files_in_cwd"
            }
        }]
    }
}

