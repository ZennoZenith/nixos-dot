# alias fzi = fzf --style full --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'

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

