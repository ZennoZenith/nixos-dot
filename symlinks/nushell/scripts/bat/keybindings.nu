def bat_help_autocomplete [] {
    let line = (commandline)
    let needs_space = not ($line | str ends-with " ")
    let line_with_space = if $needs_space { $"($line) " } else { $line }
    let new_line = $line_with_space + '--help | bh'
    commandline edit --replace $new_line
    commandline set-cursor --end
}

export-env {
    $env.config.keybindings ++= [{
        name: help_completion,
        modifier: Control,
        keycode: "char_7",
        mode: [vi_normal, vi_insert, emacs],
        event: {
            send: executehostcommand,
            cmd: "bat_help_autocomplete"
        }
    }]
}
