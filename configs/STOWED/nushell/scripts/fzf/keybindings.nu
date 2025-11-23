# # alias fzi = fzf --style full --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'

alias fzi = fzf --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'

$env.ENV_CONVERSIONS.__keybindings_loaded = {
    from_string: { |s| $s | into bool }
    to_string: { |v| $v | into string }
}


# https://github.com/junegunn/fzf/issues/4122
# Dependencies: `fd`, `bat, `rg`, `nufmt`, `tree`.
# cargo install --git https://github.com/nushell/nufmt
export-env {
  $env.FZF_ALT_C_COMMAND = "fd --type directory --hidden"
  $env.FZF_ALT_C_OPTS = "--preview 'tree -C {} | head -n 200'"
  $env.FZF_CTRL_T_COMMAND = "fd --type file --hidden"
  $env.FZF_CTRL_T_OPTS = "--preview 'bat --color=always --style=full --line-range=:500 {}' "
  $env.FZF_DEFAULT_COMMAND = "fd --type file --hidden"
}


# Directories
const alt_c = {
    name: fzf_dirs
    modifier: alt
    keycode: char_c
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: executehostcommand
        cmd: "
          let fzf_alt_c_command = \$\"($env.FZF_ALT_C_COMMAND) | fzf ($env.FZF_ALT_C_OPTS)\";
          let result = nu -c $fzf_alt_c_command;
          cd $result;
        "
      }
    ]
}

# History
const ctrl_h = {
  name: history_menu
  modifier: control
  keycode: char_h
  mode: [emacs, vi_insert, vi_normal]
  event: [
    {
      send: executehostcommand
      cmd: "
        let result = history
          | reverse
          | get command
          | str replace --all (char newline) ' '
          | to text
          | fzf --no-sort --preview 'printf \'{}\' | nufmt --stdin | rg -v ERROR';
        commandline edit --append $result;
        commandline set-cursor --end
      "
    }
  ]
}

# Files
const ctrl_t =  {
    name: fzf_files
    modifier: control
    keycode: char_t
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: executehostcommand
        cmd: "
          let fzf_ctrl_t_command = \$\"($env.FZF_CTRL_T_COMMAND) | fzf ($env.FZF_CTRL_T_OPTS)\";
          let result = nu -c $fzf_ctrl_t_command;
          commandline edit --append $result;
          commandline set-cursor --end
        "
      }
    ]
}

# Update the $env.config
export-env {
  if ('fzf_dirs' not-in ($env.config.keybindings | get name) ) {
    $env.config.keybindings = $env.config.keybindings | append $alt_c
  }

  if ('history_menu' not-in ($env.config.keybindings | get name) ) {
    $env.config.keybindings = $env.config.keybindings | append $ctrl_h
  }

  if ('fzf_files' not-in ($env.config.keybindings | get name) ) {
    $env.config.keybindings = $env.config.keybindings | append $ctrl_t
  }

  $env.__keybindings_loaded = true
}
